//
//  MKUrl.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKUrl: Content {
    var type: String?
    var url: String?
}

//type (string, optional): A text identifier for the URL.,
//url (string, optional): A full URL (including scheme, domain, and path).
