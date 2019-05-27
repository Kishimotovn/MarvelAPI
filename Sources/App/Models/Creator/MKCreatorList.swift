//
//  MKCreatorList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKCreatorList: Content {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MKCreatorSummary]?
}

//available (int, optional): The number of total available creators in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of creators returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of creators in this collection.,
//items (Array[CreatorSummary], optional): The list of returned creators in this collection.
