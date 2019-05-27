//
//  MKStoryData.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor
import FluentPostgreSQL

final class MKStoryData: PostgreSQLModel {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var type: String?
    var modified: Date?
    var thumbnail: MKImage?
    var comics: MKComicList?
    var series: MKSeriesList?
    var events: MKEventList?
    var characters: MKCreatorList?
    var creators: MKCreatorList?
    var originalissue: MKComicSummary?
}

extension MKStoryData: Content { }
extension MKStoryData: Migration { }
extension MKStoryData: Parameter { }
//id (int, optional): The unique ID of the story resource.,
//title (string, optional): The story title.,
//description (string, optional): A short description of the story.,
//resourceURI (string, optional): The canonical URL identifier for this resource. ,
//    type (string, optional): The story type e.g. interior story, cover, text story.,
//    modified (Date, optional): The date the resource was most recently modified.,
//    thumbnail (Image, optional): The representative image for this story.,
//comics (ComicList, optional): A resource list containing comics in which this story takes place.,
//series (SeriesList, optional): A resource list containing series in which this story appears.,
//events (EventList, optional): A resource list of the events in which this story appears.,
//characters (CharacterList, optional): A resource list of characters which appear in this story.,
//creators (CreatorList, optional): A resource list of creators who worked on this story.,
//originalissue (ComicSummary, optional): A summary representation of the issue in which this story was originally published.
