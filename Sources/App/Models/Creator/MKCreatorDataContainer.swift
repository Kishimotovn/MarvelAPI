//
//  MKCreatorDataContainer.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKCreatorDataContainer: Content {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MKCreatorData]?
}

