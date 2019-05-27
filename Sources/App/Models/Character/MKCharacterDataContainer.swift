//
//  MKCharacterDataContainer.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Foundation
import Vapor

final class MKCharacterDataContainer: Content {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MKCharacterData]?
}
