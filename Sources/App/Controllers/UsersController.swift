//
//  AuthController.swift
//  App
//
//  Created by Anh Phan Tran on 02/10/2019.
//

import Vapor
import Crypto

struct UsersController: RouteCollection {
  func boot(router: Router) throws {
    let usersRoute = router.grouped("api", "users")
    usersRoute.get(use: getAllHandler)
    usersRoute.get(MKUser.parameter, use: getHandler)
    usersRoute.post(RegisterData.self, at: "register", use: registerPostHandler)

    let basicAuthMiddleware = MKUser.basicAuthMiddleware(using: BCryptDigest())
    let basicAuthGroup = usersRoute.grouped(basicAuthMiddleware)
    basicAuthGroup.post("login", use: loginHandler)

    let tokenAuthMiddleware = MKUser.tokenAuthMiddleware()
    let guardAuthMiddleware = MKUser.guardAuthMiddleware()
    let tokenAuthGroup = usersRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
    tokenAuthGroup.get("me", use: getMeHandler)
  }

  func getMeHandler(_ req: Request) throws -> MKUser.Public {
    return try req.requireAuthenticated(MKUser.self).convertToPublic()
  }

  func createHandler(_ req: Request, user: MKUser) throws -> Future<MKUser.Public> {
    user.passwordHash = try BCrypt.hash(user.passwordHash)
    return user.save(on: req).convertToPublic()
  }

  func getAllHandler(_ req: Request) throws -> Future<[MKUser.Public]> {
    return MKUser.query(on: req).decode(data: MKUser.Public.self).all()
  }

  func getHandler(_ req: Request) throws -> Future<MKUser.Public> {
    return try req.parameters.next(MKUser.self).convertToPublic()
  }

  func loginHandler(_ req: Request) throws -> Future<UserToken> {
    let user = try req.requireAuthenticated(MKUser.self)
    let token = try UserToken.generate(for: user)
    return token.save(on: req)
  }

  func registerPostHandler(_ req: Request, data: RegisterData) throws -> Future<HTTPResponse> {
    try data.validate()
    let password = try BCrypt.hash(data.password)
    let user = MKUser(name: data.name, username: data.username, password: password, email: data.emailAddress)
    return user.save(on: req).map(to: HTTPResponse.self) { user in
      return HTTPResponse(status: .ok)
    }
  }
}

struct RegisterData: Content {
  let name: String
  let username: String
  let password: String
  let confirmPassword: String
  let emailAddress: String
}

extension RegisterData: Validatable, Reflectable {
  static func validations() throws -> Validations<RegisterData> {
    var validations = Validations(RegisterData.self)
    try validations.add(\.name, .ascii)
    try validations.add(\.username, .alphanumeric && .count(3...))
    try validations.add(\.password, .count(8...))
    try validations.add(\.emailAddress, .email)
    validations.add("passwords match") { model in
      guard model.password == model.confirmPassword else {
        throw BasicValidationError("passwords don’t match")
      }
    }
    return validations
  }
}
