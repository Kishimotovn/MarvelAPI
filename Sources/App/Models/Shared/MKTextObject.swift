//
//  MKTextObject.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKTextObject: Content {
    var type: String?
    var language: String?
    var text: String?
}

//type (string, optional): The canonical type of the text object (e.g. solicit text, preview text, etc.).,
//language (string, optional): The IETF language tag denoting the language the text object is written in.,
//text (string, optional): The text
