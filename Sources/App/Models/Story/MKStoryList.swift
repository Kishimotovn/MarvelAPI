//
//  MKStoryList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKStoryList: Content {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MKStorySummary]?
}

//available (int, optional): The number of total available stories in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of stories returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of stories in this collection.,
//items (Array[StorySummary], optional): The list of returned stories in this collection.
