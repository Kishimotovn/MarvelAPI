//
//  MKComicDataWrapper.swift
//  App
//
//  Created by Anh Phan Tran on 12/05/2019.
//

import Foundation
import Vapor

final class MKComicDataWrapper: Content {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionHTML: String?
    var data: MKComicDataContainer?
    var etag: String?

    convenience init(withSingle comic: MKComicData) {
        self.init()
        let dataContainer = MKComicDataContainer()
        dataContainer.count = 1
        dataContainer.limit = 1
        dataContainer.offset = 0
        dataContainer.results = [comic]
        self.data = dataContainer
    }
}


//copyright (string, optional): The copyright notice for the returned result.,
//attributionText (string, optional): The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
//attributionHTML (string, optional): An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
//data (ComicDataContainer, optional): The results returned by the call.,
//etag (string, optional): A digest value of the content returned by the call.
