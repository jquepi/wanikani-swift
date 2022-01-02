import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum Users {
    /// Returns a summary of user information for the currently authenticated user.
    public struct Me: Resource {
        public typealias Content = User

        public let path = "user"
    }

    /// Returns an updated summary of user information.
    public struct Update: Resource {
        public typealias Content = User

        public var body: Body

        /// Only the values under `preferences` are allowed to be updated.
        public struct Body: Codable {
            var defaultVoiceActorID: Int?
            var lessonsAutoplayAudio: Bool?
            var lessonsBatchSize: Int?
            var lessonsPresentationOrder: String?
            var reviewsAutoplayAudio: Bool?
            var reviewsDisplaySRSIndicator: Bool?

            public init(
                defaultVoiceActorID: Int? = nil,
                lessonsAutoplayAudio: Bool? = nil,
                lessonsBatchSize: Int? = nil,
                lessonsPresentationOrder: String? = nil,
                reviewsAutoplayAudio: Bool? = nil,
                reviewsDisplaySRSIndicator: Bool? = nil
            ) {
                self.defaultVoiceActorID = defaultVoiceActorID
                self.lessonsAutoplayAudio = lessonsAutoplayAudio
                self.lessonsBatchSize = lessonsBatchSize
                self.lessonsPresentationOrder = lessonsPresentationOrder
                self.reviewsAutoplayAudio = reviewsAutoplayAudio
                self.reviewsDisplaySRSIndicator = reviewsDisplaySRSIndicator
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let body = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
                defaultVoiceActorID = try body.decodeIfPresent(Int.self, forKey: .defaultVoiceActorID)
                lessonsAutoplayAudio = try body.decodeIfPresent(Bool.self, forKey: .lessonsAutoplayAudio)
                lessonsBatchSize = try body.decodeIfPresent(Int.self, forKey: .lessonsBatchSize)
                lessonsPresentationOrder = try body.decodeIfPresent(String.self, forKey: .lessonsPresentationOrder)
                reviewsAutoplayAudio = try body.decodeIfPresent(Bool.self, forKey: .reviewsAutoplayAudio)
                reviewsDisplaySRSIndicator = try body.decodeIfPresent(Bool.self, forKey: .reviewsDisplaySRSIndicator)
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                var body = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
                try body.encodeIfPresent(defaultVoiceActorID, forKey: .defaultVoiceActorID)
                try body.encodeIfPresent(lessonsAutoplayAudio, forKey: .lessonsAutoplayAudio)
                try body.encodeIfPresent(lessonsBatchSize, forKey: .lessonsBatchSize)
                try body.encodeIfPresent(lessonsPresentationOrder, forKey: .lessonsPresentationOrder)
                try body.encodeIfPresent(reviewsAutoplayAudio, forKey: .reviewsAutoplayAudio)
                try body.encodeIfPresent(reviewsDisplaySRSIndicator, forKey: .reviewsDisplaySRSIndicator)
            }

            private enum CodingKeys: String, CodingKey {
                case user
                case defaultVoiceActorID = "default_voice_actor_id"
                case lessonsAutoplayAudio = "lessons_autoplay_audio"
                case lessonsBatchSize = "lessons_batch_size"
                case lessonsPresentationOrder = "lessons_presentation_order"
                case reviewsAutoplayAudio = "reviews_autoplay_audio"
                case reviewsDisplaySRSIndicator = "reviews_display_srs_indicator"
            }
        }

        public let path = "user"

        public func transformRequest(_ request: inout URLRequest) {
            request.httpMethod = "PUT"
        }
    }
}

extension Resource where Self == Users.Me {
    /// Returns a summary of user information for the currently authenticated user.
    public static var me: Self {
        Self()
    }
}

extension Resource where Self == Users.Update {
    /// Returns an updated summary of user information.
    public static func updateUser(
        defaultVoiceActorID: Int? = nil,
        lessonsAutoplayAudio: Bool? = nil,
        lessonsBatchSize: Int? = nil,
        lessonsPresentationOrder: String? = nil,
        reviewsAutoplayAudio: Bool? = nil,
        reviewsDisplaySRSIndicator: Bool? = nil
    ) -> Self {
        Self(body: Self.Body(defaultVoiceActorID: defaultVoiceActorID,
                             lessonsAutoplayAudio: lessonsAutoplayAudio,
                             lessonsBatchSize: lessonsBatchSize,
                             lessonsPresentationOrder: lessonsPresentationOrder,
                             reviewsAutoplayAudio: reviewsAutoplayAudio,
                             reviewsDisplaySRSIndicator: reviewsDisplaySRSIndicator))
    }
}