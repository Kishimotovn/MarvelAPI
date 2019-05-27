//
//  MKCreatorData.swift
//  App
//
//  Created by Anh Phan Tran on 26/05/2019.
//

import Vapor
import FluentPostgreSQL

final class MKCreatorData: PostgreSQLModel {
    var id: Int?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var suffix: String?
    var fullName: String?
    var modified: Date?
    var resourceURI: String?
    var urls: [MKUrl]?
    var thumbnail: MKImage?
    var series: MKSeriesList?
    var stories: MKStoryList?
    var comics: MKComicList?
    var events: MKEventList?
}

extension MKCreatorData: Content { }
extension MKCreatorData: Migration { }
extension MKCreatorData: Parameter { }
