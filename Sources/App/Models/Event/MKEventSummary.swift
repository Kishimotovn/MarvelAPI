//
//  MKEventSummary.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKEventSummary: Content {
    var resourceURI: String?
    var name: String?
}

//resourceURI (string, optional): The path to the individual event resource.,
//name (string, optional): The name of the event.
