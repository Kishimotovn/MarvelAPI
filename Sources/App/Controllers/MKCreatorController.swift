//
//  MKCreatorController.swift
//  App
//
//  Created by Anh Phan Tran on 19/05/2019.
//

import Vapor

final class MKCreatorController {
    let signer = MKSigner()
    let paramsExtractor = MKParamsExtractor()
    
    func one(_ req: Request) throws -> Future<MKCreatorDataWrapper> {
        let creatorId = try req.parameters.next(Int.self)
        return MKCreatorData.find(creatorId, on: req).unwrap(or: Abort(.notFound)).map(to: MKCreatorDataWrapper.self) { creator in
            return MKCreatorDataWrapper(withSingle: creator)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/creators/\(creatorId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKCreatorDataWrapper.self) { response in
                return try response.content.decode(MKCreatorDataWrapper.self)
            }.map { wrapper in
                if let creator = wrapper.data?.results?.first {
                    creator.create(on: req)
                }
                return wrapper
            }
        }
    }
    
    func index(_ req: Request) throws -> Future<MKCreatorDataWrapper> {
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/creators?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKCreatorDataWrapper.self) { response in
            return try response.content.decode(MKCreatorDataWrapper.self)
        }
    }

    func comics(_ req: Request) throws -> Future<MKComicDataWrapper> {
        let creatorId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/creators/\(creatorId)/comics?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
            return try response.content.decode(MKComicDataWrapper.self)
        }
    }

    func series(_ req: Request) throws -> Future<MKSeriesDataWrapper> {
        let creatorId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/creators/\(creatorId)/series?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKSeriesDataWrapper.self) { response in
            return try response.content.decode(MKSeriesDataWrapper.self)
        }
    }

    func events(_ req: Request) throws -> Future<MKEventDataWrapper> {
        let creatorId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/creators/\(creatorId)/events?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
            return try response.content.decode(MKEventDataWrapper.self)
        }
    }
}


