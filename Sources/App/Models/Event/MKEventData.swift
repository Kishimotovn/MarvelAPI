//
//  MKEventData.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor
import FluentPostgreSQL

final class MKEventData: PostgreSQLModel {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var urls: [MKUrl]?
    var modified: Date?
    var start: Date?
    var end: Date?
    var thumbnail: MKImage?
    var comics: MKComicList?
    var stories: MKStoryList?
    var series: MKSeriesList?
    var characters: MKCharacterList?
    var creators: MKCreatorList?
    var next: MKEventSummary?
    var previous: MKEventSummary?
}

extension MKEventData: Content { }
extension MKEventData: Migration { }
extension MKEventData: Parameter { }
//Event {
//    id (int, optional): The unique ID of the event resource.,
//    title (string, optional): The title of the event.,
//    description (string, optional): A description of the event.,
//    resourceURI (string, optional): The canonical URL identifier for this resource.,
//        urls (Array[Url], optional): A set of public web site URLs for the event.,
//    modified (Date, optional): The date the resource was most recently modified.,
//    start (Date, optional): The date of publication of the first issue in this event.,
//    end (Date, optional): The date of publication of the last issue in this event.,
//    thumbnail (Image, optional): The representative image for this event.,
//        comics (ComicList, optional): A resource list containing the comics in this event.,
//        stories (StoryList, optional): A resource list containing the stories in this event.,
//        series (SeriesList, optional): A resource list containing the series in this event.,
//        characters (CharacterList, optional): A resource list containing the characters which appear in this event.,
//        creators (CreatorList, optional): A resource list containing creators whose work appears in this event.,
//        next (EventSummary, optional): A summary representation of the event which follows this event.,
//        previous (EventSummary, optional): A summary representation of the event which preceded this event.
//}
