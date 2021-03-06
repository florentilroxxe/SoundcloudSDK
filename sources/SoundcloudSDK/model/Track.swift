//
//  Track.swift
//  SoundcloudSDK
//
//  Created by Kevin DELANNOY on 24/02/15.
//  Copyright (c) 2015 Kevin Delannoy. All rights reserved.
//

import Foundation

// MARK: - TrackType
////////////////////////////////////////////////////////////////////////////

public enum TrackType: String {
    case Original = "original"
    case Remix = "remix"
    case Live = "live"
    case Recording = "recording"
    case Spoken = "spoken"
    case Podcast = "podcast"
    case Demo = "demo"
    case InProgress = "in progress"
    case Stem = "stem"
    case Loop = "loop"
    case SoundEffect = "sound effect"
    case Sample = "sample"
    case Other = "other"
}

////////////////////////////////////////////////////////////////////////////


// MARK: - Track definition
////////////////////////////////////////////////////////////////////////////

public struct Track {
    internal init(identifier: Int = 0, createdAt: NSDate = NSDate(), createdBy: User = User(),
        createdWith: App? = nil, duration: NSTimeInterval = 0, commentable: Bool = false,
        streamable: Bool = false, downloadable: Bool = false, streamURL: NSURL? = nil,
        downloadURL: NSURL? = nil, permalinkURL: NSURL? = nil,
        releaseYear: Int? = nil, releaseMonth: Int? = 0, releaseDay: Int? = 0,
        tags: [String]? = nil, description: String? = nil, genre: String? = nil,
        trackType: TrackType? = nil, title: String = "", format: String? = nil,
        contentSize: UInt64? = nil, artworkImageURL: ImageURLs = ImageURLs(baseURL: nil),
        waveformImageURL: ImageURLs = ImageURLs(baseURL: nil), playbackCount: Int? = nil,
        downloadCount: Int? = nil, favoriteCount: Int? = nil, commentCount: Int? = nil) {
            self.identifier = identifier

            self.createdAt = createdAt
            self.createdBy = createdBy
            self.createdWith = createdWith

            self.duration = duration

            self.commentable = commentable
            self.streamable = streamable
            self.downloadable = downloadable

            self.streamURL = streamURL
            self.downloadURL = downloadURL
            self.permalinkURL = permalinkURL

            self.releaseYear = releaseYear
            self.releaseMonth = releaseMonth
            self.releaseDay = releaseDay

            self.tags = tags

            self.description = description
            self.genre = genre
            self.trackType = trackType
            self.title = title
            self.format = format
            self.contentSize = contentSize

            self.artworkImageURL = artworkImageURL
            self.waveformImageURL = waveformImageURL

            self.playbackCount = playbackCount
            self.downloadCount = downloadCount
            self.favoriteCount = favoriteCount
            self.commentCount = commentCount
    }

    ///Track's identifier
    public let identifier: Int


    ///Creation date of the track
    public let createdAt: NSDate

    ///User that created the track (not a full user)
    public let createdBy: User

    ///App used to create the track
    public let createdWith: App?


    ///Track duration
    public let duration: NSTimeInterval


    ///Is commentable
    public let commentable: Bool

    ///Is streamable
    public let streamable: Bool

    ///Is downloadable
    public let downloadable: Bool


    ///Streaming URL
    public let streamURL: NSURL?

    ///Downloading URL
    public let downloadURL: NSURL?

    ///Permalink URL (website)
    public let permalinkURL: NSURL?


    ///Release year
    public let releaseYear: Int?

    ///Release month
    public let releaseMonth: Int?

    ///Release day
    public let releaseDay: Int?


    ///Tags
    public let tags: [String]? /// "tag_list": "soundcloud:source=iphone-record",

    ///Track's description
    public let description: String?

    ///Genre
    public let genre: String?

    ///Type of the track
    public let trackType: TrackType?

    ///Track title
    public let title: String

    ///File format (m4a, mp3, ...)
    public let format: String?

    ///File size (in bytes)
    public let contentSize: UInt64?


    ///Image URL to artwork
    public let artworkImageURL: ImageURLs

    ///Image URL to waveform
    public let waveformImageURL: ImageURLs


    ///Playback count
    public let playbackCount: Int?

    ///Download count
    public let downloadCount: Int?

    ///Favorite count
    public let favoriteCount: Int?

    ///Comment count
    public let commentCount: Int?
}

////////////////////////////////////////////////////////////////////////////


// MARK: - Track Extensions
////////////////////////////////////////////////////////////////////////////

// MARK: Parsing
////////////////////////////////////////////////////////////////////////////

internal extension Track {
    init?(JSON: JSONObject) {
        if let identifier = JSON["id"].intValue, user = User(JSON: JSON["user"]) {
            self.init(
                identifier: identifier,
                createdAt: JSON["created_at"].dateValue("yyyy/MM/dd HH:mm:ss VVVV") ?? NSDate(),
                createdBy: user,
                createdWith: App(JSON: JSON["created_with"]),
                duration: JSON["duration"].doubleValue ?? 0,
                commentable: JSON["commentable"].boolValue ?? false,
                streamable: JSON["streamable"].boolValue ?? false,
                downloadable: JSON["downloadable"].boolValue ?? false,
                streamURL: JSON["stream_url"].URLValue,
                downloadURL: JSON["download_url"].URLValue,
                permalinkURL: JSON["permalink_url"].URLValue,
                releaseYear: JSON["release_year"].intValue,
                releaseMonth: JSON["release_month"].intValue,
                releaseDay: JSON["release_day"].intValue,
                tags: JSON["tag_list"].stringValue.map { return [$0] }, //TODO: check this
                description: JSON["description"].stringValue,
                genre: JSON["genre"].stringValue,
                trackType: TrackType(rawValue: JSON["track_type"].stringValue ?? ""),
                title: JSON["title"].stringValue ?? "",
                format: JSON["original_format"].stringValue,
                contentSize: JSON["original_content_size"].uint64Value,
                artworkImageURL: ImageURLs(baseURL: JSON["artwork_url"].URLValue),
                waveformImageURL: ImageURLs(baseURL: JSON["waveform_url"].URLValue),
                playbackCount: JSON["playback_count"].intValue,
                downloadCount: JSON["download_count"].intValue,
                favoriteCount: JSON["favoritings_count"].intValue,
                commentCount: JSON["comment_count"].intValue
            )
        }
        else {
            return nil
        }
    }
}

////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
