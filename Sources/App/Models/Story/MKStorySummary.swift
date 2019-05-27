//
//  MKStorySummary.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKStorySummary: Content {
    var resourceURI: String?
    var name: String?
    var type: String?
}
//
//resourceURI (string, optional): The path to the individual story resource.,
//name (string, optional): The canonical name of the story.,
//type (string, optional): The type of the story (interior or cover).
