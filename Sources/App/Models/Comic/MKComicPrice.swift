//
//  MKComicPrice.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKComicPrice: Content {
    var type: String?
    var price: Double?
}
//type (string, optional): A description of the price (e.g. print price, digital price).,
//price (float, optional): The price (all prices in USD).
