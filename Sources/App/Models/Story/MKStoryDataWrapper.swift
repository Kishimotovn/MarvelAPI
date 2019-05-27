//
//  MKStoryDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKStoryDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKStoryDataContainer?
    var etag: String?
    
    convenience init(withSingle story: MKStoryData) {
        self.init()
        let dataContainer = MKStoryDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [story]
        self.data = dataContainer
    }
}
