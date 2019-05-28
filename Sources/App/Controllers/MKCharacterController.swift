//
//  MKCharacterController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKCharacterController {
    let signer = MKSigner()
    
    func one(_ req: Request) throws -> Future<MKCharacterDataWrapper> {
        let characterId = try req.parameters.next(Int.self)

        return MKCharacterData.find(characterId, on: req).unwrap(or: Abort(.notFound)).map(to: MKCharacterDataWrapper.self) { character in
            return MKCharacterDataWrapper(withSingle: character)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKCharacterDataWrapper.self) { response in
                return try response.content.decode(MKCharacterDataWrapper.self)
            }.map { dataWrapper in
                if let character = dataWrapper.data?.results?.first {
                    character.create(on: req)
                }
                return dataWrapper
            }
        }
    }

    func index(_ req: Request) throws -> Future<MKCharacterDataWrapper> {
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/characters?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKCharacterDataWrapper.self) { response in
            return try response.content.decode(MKCharacterDataWrapper.self)
        }
    }

    func comics(_ req: Request) throws -> Future<MKComicDataWrapper> {
        let characterId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)/comics?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
            return try response.content.decode(MKComicDataWrapper.self)
        }
    }

    func series(_ req: Request) throws -> Future<MKSeriesDataWrapper> {
        let characterId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)/series?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKSeriesDataWrapper.self) { response in
            return try response.content.decode(MKSeriesDataWrapper.self)
        }
    }

    func stories(_ req: Request) throws -> Future<MKStoryDataWrapper> {
        let characterId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)/stories?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKStoryDataWrapper.self) { response in
            return try response.content.decode(MKStoryDataWrapper.self)
        }
    }

    func events(_ req: Request) throws -> Future<MKEventDataWrapper> {
        let characterId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)/events?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
            return try response.content.decode(MKEventDataWrapper.self)
        }
    }
}
