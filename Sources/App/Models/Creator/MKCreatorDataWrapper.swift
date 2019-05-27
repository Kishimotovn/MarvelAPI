//
//  MKCreatorDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKCreatorDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKCreatorDataContainer?
    var etag: String?
    
    convenience init(withSingle creator: MKCreatorData) {
        self.init()
        let dataContainer = MKCreatorDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [creator]
        self.data = dataContainer
    }
}
