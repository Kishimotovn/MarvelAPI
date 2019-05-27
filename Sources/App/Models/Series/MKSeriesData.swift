//
//  MKSeriesData.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor
import FluentPostgreSQL

final class MKSeriesData: PostgreSQLModel {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var urls: [MKUrl]?
    var startYear: Int?
    var endYear: Int?
    var rating: String?
    var modified: Date?
    var thumbnail: MKImage?
    var comics: MKComicList?
    var stories: MKStoryList?
    var events: MKEventList?
    var characters: MKCharacterList?
    var creators: MKCreatorList?
    var next: MKSeriesSummary?
    var previous: MKSeriesSummary?
}

extension MKSeriesData: Content { }
extension MKSeriesData: Migration { }
extension MKSeriesData: Parameter { }
//
//id (int, optional): The unique ID of the series resource.,
//title (string, optional): The canonical title of the series.,
//description (string, optional): A description of the series.,
//resourceURI (string, optional): The canonical URL identifier for this resource.,
//    urls (Array[Url], optional): A set of public web site URLs for the resource.,
//startYear (int, optional): The first year of publication for the series.,
//    endYear (int, optional): The last year of publication for the series (conventionally, 2099 for ongoing series) .,
//rating (string, optional): The age-appropriateness rating for the series.,
//    modified (Date, optional): The date the resource was most recently modified.,
//    thumbnail (Image, optional): The representative image for this series.,
//comics (ComicList, optional): A resource list containing comics in this series.,
//stories (StoryList, optional): A resource list containing stories which occur in comics in this series.,
//events (EventList, optional): A resource list containing events which take place in comics in this series.,
//characters (CharacterList, optional): A resource list containing characters which appear in comics in this series.,
//creators (CreatorList, optional): A resource list of creators whose work appears in comics in this series.,
//next (SeriesSummary, optional): A summary representation of the series which follows this series.,
//previous (SeriesSummary, optional): A summary representation of the series which preceded this series.
