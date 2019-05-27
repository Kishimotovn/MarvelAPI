//
//  MKCharacterSummary.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKCharacterSummary: Content {
    var resourceURI: String?
    var name: String?
    var role: String?
}

//resourceURI (string, optional): The path to the individual character resource.,
//name (string, optional): The full name of the character.,
//role (string, optional): The role of the creator in the parent entity.
