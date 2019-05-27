//
//  MKImage.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKImage: Content {
    var path: String?
    var imageExtension: String?

    private enum CodingKeys : String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
