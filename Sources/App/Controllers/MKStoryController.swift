//
//  MKStoryController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKStoryController {
    let signer = MKSigner()
    let paramsExtractor = MKParamsExtractor()
    
    func one(_ req: Request) throws -> Future<MKStoryDataWrapper> {
        let storyId = try req.parameters.next(Int.self)
        return MKStoryData.find(storyId, on: req).unwrap(or: Abort(.notFound)).map(to: MKStoryDataWrapper.self) { story in
            return MKStoryDataWrapper(withSingle: story)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/stories/\(storyId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKStoryDataWrapper.self) { response in
                return try response.content.decode(MKStoryDataWrapper.self)
            }
        }
    }
    
    func index(_ req: Request) throws -> Future<MKStoryDataWrapper> {
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/stories?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKStoryDataWrapper.self) { response in
            return try response.content.decode(MKStoryDataWrapper.self)
        }
    }
}
