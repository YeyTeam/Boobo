//
//  DurationManager.swift
//  Boobo
//
//  Created by Abdul Jabbar on 20/09/25.
import Foundation
import Combine

/// Mengelola countdown durasi playback (sleep session).
/// Sumber kebenaran untuk "durasi yang dikonfigurasi" adalah `durationMinutes`.
/// - Default: 30 menit.
/// - Reset rules:
///   - Pause/stop => reset ke penuh & berhenti meng-tick.
///   - Ganti mix/sound => reset ke penuh; jika sedang play, mulai meng-tick, jika tidak maka idle.
/// - Set dari sheet tidak auto-start; ticking hanya jika sedang play.
final class DurationManager: ObservableObject {
    // MARK: - Published State
    @Published private(set) var isActive: Bool = false
    @Published private(set) var remaining: TimeInterval = 0
    @Published var durationMinutes: Int = 30 // default jika user belum mengatur

    // MARK: - Internals
    private var timer: Timer?
    private var onTimeUp: (() -> Void)?
    private var endDate: Date? // untuk akurasi ketika app lifecycle berubah

    // MARK: - Hooks
    /// Pasang callback ketika waktu habis.
    func configure(onTimeUp: @escaping () -> Void) {
        self.onTimeUp = onTimeUp
    }

    // MARK: - Public API (Konfigurasi)
    /// Set durasi (dalam menit). Tidak otomatis mulai menghitung.
    func setDuration(minutes: Int) {
        let clamped = max(1, minutes)
        durationMinutes = clamped

        // Jika sudah ada sesi aktif, kita prime remaining ke durasi baru
        // tapi tidak auto-start ticking (biar dikontrol dari Play/Pause).
        if isActive {
            remaining = TimeInterval(clamped * 60)
            endDate = nil
            stopTicking()
        }
    }

    // MARK: - Public API (Start/Reset sesuai state playback)
    /// Memastikan timer terinisialisasi. Jika `isActive` belum true, aktifkan dan set `remaining` ke durasi penuh.
    /// - Parameter isPlaying: Jika true, mulai ticking; jika false, hanya prime (idle).
    func startIfNeeded(isPlaying: Bool) {
        if !isActive {
            isActive = true
            remaining = TimeInterval(durationMinutes * 60)
        }
        resetTimer() // pastikan timer bersih
        if isPlaying {
            startTicking()
        } else {
            stopTicking() // tetap idle pada nilai penuh
        }
    }

    /// Restart countdown ke durasi penuh **jika** sudah aktif.
    /// - Jika `isPlaying == true` → mulai ticking dari penuh.
    /// - Jika `isPlaying == false` → reset ke penuh dan idle.
    func restartIfActiveAndPlaying(isPlaying: Bool) {
        guard isActive else { return }
        remaining = TimeInterval(durationMinutes * 60)
        resetTimer()
        if isPlaying {
            startTicking()
        } else {
            stopTicking()
        }
    }

    /// Dipanggil ketika state playback berubah (Play ↔ Pause/Stop).
    /// - isPlaying true  → reset ke penuh lalu mulai ticking.
    /// - isPlaying false → reset ke penuh & berhenti ticking.
    func handlePlaybackChange(isPlaying: Bool) {
        // Jika belum aktif, kita aktifkan supaya UI bisa menampilkan remaining.
        if !isActive {
            isActive = true
        }
        remaining = TimeInterval(durationMinutes * 60)
        resetTimer()
        if isPlaying {
            startTicking()
        } else {
            stopTicking()
        }
    }

    // MARK: - Public API (Kontrol eksplisit)
    /// Mulai segera dengan durasi tertentu (detik).
    @MainActor
    func start(duration: TimeInterval) {
        cancel()
        isActive = true
        remaining = max(0, duration)
        endDate = Date().addingTimeInterval(remaining)
        startTicking()
    }

    /// Alias yang lebih semantik untuk `cancel()`.
    @MainActor
    func stop() {
        cancel()
    }

    /// Reset waktu tersisa. Jika `to` nil, reset ke `durationMinutes`.
    @MainActor
    func reset(to duration: TimeInterval? = nil) {
        stopTicking()
        remaining = max(0, duration ?? TimeInterval(durationMinutes * 60))
        endDate = nil
        if !isActive { isActive = true } // biar UI bisa baca remaining
    }

    /// Batalkan sesi: nonaktifkan dan nolkan remaining.
    func cancel() {
        stopTicking()
        isActive = false
        remaining = 0
        endDate = nil
    }

    // MARK: - Read-only convenience
    var currentRemainingTime: TimeInterval { max(0, remaining) }

    /// Shim untuk kompatibilitas API lama (mengabaikan nama mix).
    @MainActor
    func setDuration(_ duration: TimeInterval, for _: String) {
        let mins = max(1, Int(ceil(duration / 60)))
        durationMinutes = mins
        if isActive {
            remaining = TimeInterval(mins * 60)
            endDate = nil
            stopTicking()
        }
    }

    // MARK: - Internal ticking
    private func startTicking() {
        stopTicking()

        if endDate == nil {
            endDate = Date().addingTimeInterval(remaining)
        }

        // Timer 1 Hz
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }

            if let end = self.endDate {
                self.remaining = max(0, end.timeIntervalSinceNow)
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
