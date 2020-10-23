import Foundation


/**
 A [Recommendation Seed Object][1]. Part of the response returned by
 `SpotifyAPI.recommendations(_:limit:market:)`. See also
 `RecommendationsResponse`.
 
 [1]: https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/#recommendation-seed-object
 */
public struct RecommendationSeed: Codable, Hashable {
    
    /// The number of tracks available after the minimun and maximum filters
    /// have been applied.
    public let afterFilteringSize: Int
    
    /// The number of tracks available after relinking for regional
    /// availability.
    public let afterRelinkingSize: Int
    
    /**
     A link to the full track or artist data for this seed.
     
     For tracks this will be a link to a Track Object. For artists a link to
     an Artist Object. For genre seeds, this value will be `nil`.
     
     Use `SpotifyAPI.getFromHref(_:responseType:)` to retrieve the results.
     */
    public let href: String?
    
    /// The artist, track, or genre id used to select this seed.
    public let id: String
    
    /// The number of recommended tracks available for this seed.
    public let initialPoolSize: Int
    
    /// The entity type of this seed. Either `artist`, `track` or `genre`.
    public let type: IDCategory
    
    /**
     Creates a [Recommendation Seed Object][1]. Returned by
     `SpotifyAPI.recommendations(_:limit:market:)`. See also
     `RecommendationsResponse`.
     
     - Parameters:
       - afterFilteringSize: The number of tracks available after the minimun
             and maximum filters have been applied.
       - afterRelinkingSize: The number of tracks available after relinking
             for regional availability.
       - href: A link to the full track or artist data for this seed.
             For tracks this will be a link to a Track Object. For artists
             a link to an Artist Object. For genre seeds, this value will be
             `nil`. Use `SpotifyAPI.getFromHref(_:responseType:)` to retrieve
             the results.
       - id: The artist, track, or genre id used to select this seed.
       - initialPoolSize: The number of recommended tracks available for
             this seed.
       - type: The entity type of this seed. Either `artist`, `track`
             or `genre`.
     
     [1]: https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/#recommendation-seed-object
     */
    public init(
        afterFilteringSize: Int,
        afterRelinkingSize: Int,
        href: String?,
        id: String,
        initialPoolSize: Int,
        type: IDCategory
    ) {
        self.afterFilteringSize = afterFilteringSize
        self.afterRelinkingSize = afterRelinkingSize
        self.href = href
        self.id = id
        self.initialPoolSize = initialPoolSize
        self.type = type
    }

}
