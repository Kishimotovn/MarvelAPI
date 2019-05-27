//
//  MKComicDate.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKComicDate: Content {
    var type: String?
    var date: Date?
}

//type (string, optional): A description of the date (e.g. onsale date, FOC date).,
//date (Date, optional): The date.
