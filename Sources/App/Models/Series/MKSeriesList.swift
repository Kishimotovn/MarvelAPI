//
//  MKSeriesList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKSeriesList: Content {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MKSeriesSummary]?
}

//available (int, optional): The number of total available series in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of series returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of series in this collection.,
//items (Array[SeriesSummary], optional): The list of returned series in this collection.
