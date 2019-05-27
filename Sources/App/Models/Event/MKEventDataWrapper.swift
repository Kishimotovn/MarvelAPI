//
//  MKEventDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKEventDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKEventDataContainer?
    var etag: String?

    convenience init(withSingle event: MKEventData) {
        self.init()
        let dataContainer = MKEventDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [event]
        self.data = dataContainer
    }
}
