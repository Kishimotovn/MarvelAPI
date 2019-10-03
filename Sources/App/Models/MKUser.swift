//
//  MKUser.swift
//  App
//
//  Created by Anh Phan Tran on 02/10/2019.
//

import Foundation
import Vapor
import FluentPostgreSQL
import Authentication

final class MKUser: PostgreSQLUUIDModel {
  var id: UUID?
  var name: String
  var username: String
  var email: String
  var passwordHash: String
  var profilePicture: String?

  var tokens: Children<MKUser, UserToken> {
    return children(\.userID)
  }

  init(name: String, username: String, password: String, email: String, profilePicture: String? = nil) {
    self.name = name
    self.username = username
    self.passwordHash = password
    self.email = email
    self.profilePicture = profilePicture
  }

  final class Public: Codable {
    var id: UUID?
    var name: String
    var username: String

    init(id: UUID?, name: String, username: String) {
      self.id = id
      self.name = name
      self.username = username
    }
  }
}

extension MKUser: TokenAuthenticatable {
  typealias TokenType = UserToken
}

extension MKUser: Content { }
extension MKUser: Migration {
  static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
    return Database.create(self, on: connection) { builder in
      try addProperties(to: builder)
      builder.unique(on: \.username)
      builder.unique(on: \.email)
    }
  }
}
extension MKUser: Parameter { }
extension MKUser.Public: Content {}

extension MKUser {
  func convertToPublic() -> MKUser.Public {
    return MKUser.Public(id: id, name: name, username: username)
  }
}

extension Future where T: MKUser {
  func convertToPublic() -> Future<MKUser.Public> {
    return self.map(to: MKUser.Public.self) { user in
      return user.convertToPublic()
    }
  }
}

extension MKUser: BasicAuthenticatable {
  static let usernameKey: UsernameKey = \MKUser.username
  static let passwordKey: PasswordKey = \MKUser.passwordHash
}

extension MKUser: PasswordAuthenticatable {}
extension MKUser: SessionAuthenticatable {}
