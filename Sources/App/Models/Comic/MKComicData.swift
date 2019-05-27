//
//  MKComicData.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor
import FluentPostgreSQL

final class MKComicData: PostgreSQLModel {
    var id: Int?
    var digitalId: Int?
    var issueNumber: Double?
    var variantDescription: String?
    var description: String?
    var modified: Date?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [MKTextObject]?
    var resourceURI: String?
    var urls: [MKUrl]?
    var series: MKSeriesSummary?
    var variants: [MKComicSummary]?
    var collections: [MKComicSummary]?
    var collectedIssues: [MKComicSummary]?
    var dates: [MKComicDate]?
    var prices: [MKComicPrice]?
    var thumbnail: MKImage?
    var images: [MKImage]?
    var creators: MKCharacterList?
    var characters: MKCharacterList?
    var stories: MKStoryList?
    var events: MKEventList?
}

extension MKComicData: Content { }
extension MKComicData: Migration { }
extension MKComicData: Parameter { }
//
//textObjects (Array[TextObject], optional): A set of descriptive text blurbs for the comic.,
//    resourceURI (string, optional): The canonical URL identifier for this resource.,
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
//    series (SeriesSummary, optional): A summary representation of the series to which this comic belongs.,
//    variants (Array[ComicSummary], optional): A list of variant issues for this comic (includes the "original" issue if the current issue is a variant).,
//collections (Array[ComicSummary], optional): A list of collections which include this comic (will generally be empty if the comic's format is a collection).,
//collectedIssues (Array[ComicSummary], optional): A list of issues collected in this comic (will generally be empty for periodical formats such as "comic" or "magazine").,
//dates (Array[ComicDate], optional): A list of key dates for this comic.,
//prices (Array[ComicPrice], optional): A list of prices for this comic.,
//thumbnail (Image, optional): The representative image for this comic.,
//images (Array[Image], optional): A list of promotional images associated with this comic.,
//creators (CreatorList, optional): A resource list containing the creators associated with this comic.,
//characters (CharacterList, optional): A resource list containing the characters which appear in this comic.,
//stories (StoryList, optional): A resource list containing the stories which appear in this comic.,
//events (EventList, optional): A resource list containing the events in which this comic appears.
