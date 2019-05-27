//
//  MKEventController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKEventController {
    let signer = MKSigner()
    
    func one(_ req: Request) throws -> Future<MKEventDataWrapper> {
        return try req.parameters.next(MKEventData.self).map(to: MKEventDataWrapper.self) { event in
            return MKEventDataWrapper(withSingle: event)
        }.catchFlatMap { error in
            let eventId = 0
            let params = try self.signer.signedParams()
            let endpoint = "http://gateway.marvel.com/v1/public/events/\(eventId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
                return try response.content.decode(MKEventDataWrapper.self)
            }
        }
    }

    func index(_ req: Request) throws -> Future<MKEventDataWrapper> {
        let params = try self.signer.signedParams()
        let endpoint = "http://gateway.marvel.com/v1/public/events?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKEventDataWrapper.self) { response in
            return try response.content.decode(MKEventDataWrapper.self)
        }
    }
}
