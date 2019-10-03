//
//  Token.swift
//  App
//
//  Created by Anh Phan Tran on 02/10/2019.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Authentication

struct UserToken: PostgreSQLUUIDModel {
  var id: UUID?
  var token: String
  var userID: MKUser.ID

  init(token: String, userID: MKUser.ID) {
    self.token = token
    self.userID = userID
  }

  var user: Parent<UserToken, MKUser> {
    return parent(\.userID)
  }
}

extension UserToken: Token {
  typealias UserType = MKUser

  static var tokenKey: WritableKeyPath<UserToken, String> {
    return \.token
  }

  static var userIDKey: WritableKeyPath<UserToken, UserToken.UserIDType> {
    return \.userID
  }
}

extension UserToken: Migration {
  static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
    return Database.create(self, on: connection) { builder in
      try addProperties(to: builder)
      builder.reference(from: \.userID, to: \MKUser.id)
    }
  }
}

extension UserToken: Content {}

extension UserToken {
  static func generate(for user: MKUser) throws -> UserToken {
    let random = try CryptoRandom().generateData(count: 16)
    return try UserToken(token: random.base64EncodedString(), userID: user.requireID())
  }
}
