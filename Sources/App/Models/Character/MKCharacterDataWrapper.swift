//
//  MKCharacterDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Foundation
import Vapor

final class MKCharacterDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKCharacterDataContainer?
    var etag: String?

    convenience init(withSingle character: MKCharacterData) {
        self.init()
        let dataContainer = MKCharacterDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [character]
        self.data = dataContainer
    }
}

//CharacterDataWrapper {
//    code (int, optional): The HTTP status code of the returned result.,
//    status (string, optional): A string description of the call status.,
//    copyright (string, optional): The copyright notice for the returned result.,
//    attributionText (string, optional): The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
//    attributionHTML (string, optional): An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
//    data (CharacterDataContainer, optional): The results returned by the call.,
//    etag (string, optional): A digest value of the content returned by the call.
//}
//CharacterDataContainer {
//    offset (int, optional): The requested offset (number of skipped results) of the call.,
//    limit (int, optional): The requested result limit.,
//    total (int, optional): The total number of resources available given the current filter set.,
//    count (int, optional): The total number of results returned by this call.,
//    results (Array[Character], optional): The list of characters returned by the call.
//}
//Character {
//    id (int, optional): The unique ID of the character resource.,
//    name (string, optional): The name of the character.,
//    description (string, optional): A short bio or description of the character.,
//    modified (Date, optional): The date the resource was most recently modified.,
//    resourceURI (string, optional): The canonical URL identifier for this resource.,
//        urls (Array[Url], optional): A set of public web site URLs for the resource.,
//    thumbnail (Image, optional): The representative image for this character.,
//        comics (ComicList, optional): A resource list containing comics which feature this character.,
//        stories (StoryList, optional): A resource list of stories in which this character appears.,
//        events (EventList, optional): A resource list of events in which this character appears.,
//        series (SeriesList, optional): A resource list of series in which this character appears.
//}
