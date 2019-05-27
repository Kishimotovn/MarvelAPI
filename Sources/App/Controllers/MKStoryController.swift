//
//  MKStoryController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKStoryController {
    let signer = MKSigner()
    
    func one(_ req: Request) throws -> Future<MKStoryDataWrapper> {
        return try req.parameters.next(MKStoryData.self).map(to: MKStoryDataWrapper.self) { story in
            return MKStoryDataWrapper(withSingle: story)
        }.catchFlatMap { error in
            let storyId = 0
            let params = try self.signer.signedParams()
            let endpoint = "http://gateway.marvel.com/v1/public/stories/\(storyId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKStoryDataWrapper.self) { response in
                return try response.content.decode(MKStoryDataWrapper.self)
            }
        }
    }
    
    func index(_ req: Request) throws -> Future<MKStoryDataWrapper> {
        let params = try self.signer.signedParams()
        let endpoint = "http://gateway.marvel.com/v1/public/stories?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKStoryDataWrapper.self) { response in
            return try response.content.decode(MKStoryDataWrapper.self)
        }
    }
}
