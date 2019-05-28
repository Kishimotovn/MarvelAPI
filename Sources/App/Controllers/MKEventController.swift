//
//  MKEventController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKEventController {
    let signer = MKSigner()
    let paramsExtractor = MKParamsExtractor()
    
    func one(_ req: Request) throws -> Future<MKEventDataWrapper> {
        let eventId = try req.parameters.next(Int.self)
        return MKEventData.find(eventId, on: req).unwrap(or: Abort(.notFound)).map(to: MKEventDataWrapper.self) { event in
            return MKEventDataWrapper(withSingle: event)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/events/\(eventId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
                return try response.content.decode(MKEventDataWrapper.self)
            }
        }
    }

    func index(_ req: Request) throws -> Future<MKEventDataWrapper> {
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/events?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
            return try response.content.decode(MKEventDataWrapper.self)
        }
    }
}
