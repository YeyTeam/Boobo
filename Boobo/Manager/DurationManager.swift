//
//  DurationManager.swift
//  Boobo
//
//  Created by Abdul Jabbar on 22/09/25.
//


//
//  DurationManager.swift
//  Boobo
//
//  Created by Abdul Jabbar on 20/09/25.

import Foundation
import Combine

final class DurationManager: ObservableObject {
    @Published private(set) var isActive: Bool = false
    @Published private(set) var remaining: TimeInterval = 0
    @Published var durationMinutes: Int = 30 // default if user never sets

    private var timer: Timer?
    private var onTimeUp: (() -> Void)?

    // Cached end date for robustness if you later add foreground/background handling
    private var endDate: Date?

    // MARK: - Public API (existing)
    func configure(onTimeUp: @escaping () -> Void) {
        self.onTimeUp = onTimeUp
    }

    /// Sets the configured duration (in minutes).
    func setDuration(minutes: Int) {
        durationMinutes = max(1, minutes)
        // If active, caller can decide whether to restart or not via restartIfActiveAndPlaying.
    }

    /// Start the timer if needed. If `isPlaying` is false, we mark active but keep full remaining.
    func startIfNeeded(isPlaying: Bool) {
        if !isActive {
            remaining = TimeInterval(durationMinutes * 60)
            isActive = true
        }
        resetTimer()
        if isPlaying {
            startTicking()
        } else {
            // Not playing: ensure no ticking and full remaining (reset rule on pause)
            remaining = TimeInterval(durationMinutes * 60)
            stopTicking()
        }
    }

    /// If a timer is active and playback is true, restart countdown to full duration.
    /// Call this when the active mix changes while playing.
    func restartIfActiveAndPlaying(isPlaying: Bool) {
        guard isActive else { return }
        remaining = TimeInterval(durationMinutes * 60)
        if isPlaying {
            startTicking()
        } else {
            stopTicking()
        }
    }

    func handlePlaybackChange(isPlaying: Bool) {
        guard isActive else { return }
        // Reset on any pause/stop per requirement
        remaining = TimeInterval(durationMinutes * 60)
        if isPlaying {
            startTicking()
        } else {
            stopTicking()
        }
    }

    func cancel() {
        stopTicking()
        isActive = false
        remaining = 0
        endDate = nil
    }

    // MARK: - Convenience API (added to match your View code)

    /// Start immediately with a specific duration in *seconds*.
    @MainActor
    func start(duration: TimeInterval) {
        cancel()
        isActive = true
        remaining = max(0, duration)
        endDate = Date().addingTimeInterval(remaining)
        startTicking()
    }

    /// Stop explicitly (alias of `cancel()` but keeps a clearer name at call sites).
    @MainActor
    func stop() {
        cancel()
    }

    /// Reset remaining time. If `to` is nil, reset to the configured `durationMinutes`.
    @MainActor
    func reset(to duration: TimeInterval? = nil) {
        stopTicking()
        remaining = max(0, duration ?? TimeInterval(durationMinutes * 60))
        endDate = nil
    }

    /// Read-only alias used by your UI.
    var currentRemainingTime: TimeInterval { max(0, remaining) }

    /// Shim used by earlier call sites that passed a mix name.
    /// Keeps compatibility while ignoring the `for` parameter for now.
    @MainActor
    func setDuration(_ duration: TimeInterval, for _: String) {
        durationMinutes = max(1, Int(ceil(duration / 60)))
        if isActive {
            // If already active, adopt new remaining but do not auto-start ticking.
            remaining = duration
            endDate = nil
        }
    }

    // MARK: - Internal ticking

    private func startTicking() {
        stopTicking()
        if endDate == nil {
            endDate = Date().addingTimeInterval(remaining)
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            let now = Date()
            if let end = self.endDate {
                self.remaining = max(0, end.timeIntervalSince(now))
            } else {
                self.remaining = max(0, self.remaining - 1)
            }
            if self.remaining <= 0 {
                self.cancel()
                self.onTimeUp?()
            }
        }
        if let timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }

    private func stopTicking() {
        timer?.invalidate()
        timer = nil
        endDate = nil
    }

    private func resetTimer() {
        stopTicking()
        endDate = nil
    }
}
