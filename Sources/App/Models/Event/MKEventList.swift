//
//  MKEventList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKEventList: Content {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MKEventSummary]?
}

//available (int, optional): The number of total available events in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of events returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of events in this collection.,
//items (Array[EventSummary], optional): The list of returned events in this collection.
