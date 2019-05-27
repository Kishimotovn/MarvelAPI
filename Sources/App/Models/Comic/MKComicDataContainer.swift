//
//  MKComicDataContainer.swift
//  App
//
//  Created by Anh Phan Tran on 12/05/2019.
//

import Foundation
import Vapor

final class MKComicDataContainer: Content {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MKComicData]?
}

//offset (int, optional): The requested offset (number of skipped results) of the call.,
//limit (int, optional): The requested result limit.,
//total (int, optional): The total number of resources available given the current filter set.,
//count (int, optional): The total number of results returned by this call.,
//results (Array[Comic], optional): The list of comics returned by the call
