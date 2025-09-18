import Foundation
import SwiftData

@Model
final class SoundModel {
    @Attribute(.unique) var id: UUID
    var key: String           // e.g., "waterfall", "birds"
    var displayName: String   // Human-readable name
    var createdAt: Date

    init(key: String, displayName: String) {
        self.id = UUID()
        self.key = key
        self.displayName = displayName
        self.createdAt = Date()
    }
}
