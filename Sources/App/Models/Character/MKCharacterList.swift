//
//  MKCharacterList.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor

final class MKCharacterList: Content {
    var available: Int
    var returned: Int
    var collectionURI: String?
    var items: [MKCharacterSummary]?
}

//available (int, optional): The number of total available characters in this list. Will always be greater than or equal to the "returned" value.,
//returned (int, optional): The number of characters returned in this collection (up to 20).,
//collectionURI (string, optional): The path to the full list of characters in this collection.,
//items (Array[CharacterSummary], optional): The list of returned characters in this collection.
