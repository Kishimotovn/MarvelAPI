//
//  MKComicList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKComicList: Content {
    var availabel: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MKComicSummary]?
}

//available (int, optional): The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of issues returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of issues in this collection.,
//items (Array[ComicSummary], optional): The list of returned issues in this collection.
