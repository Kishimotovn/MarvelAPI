//
//  MKSeriesDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKSeriesDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKSeriesDataContainer?
    var etag: String?
    
    convenience init(withSingle series: MKSeriesData) {
        self.init()
        let dataContainer = MKSeriesDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [series]
        self.data = dataContainer
    }
}
