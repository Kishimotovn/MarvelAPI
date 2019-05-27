//
//  MKComicController.swift
//  App
//
//  Created by Anh Phan Tran on 07/05/2019.
//

import Vapor

final class MKComicController {
    let signer = MKSigner()

    func one(_ req: Request) throws -> Future<MKComicDataWrapper> {
        return try req.parameters.next(MKComicData.self).map(to: MKComicDataWrapper.self) { comic in
            return MKComicDataWrapper(withSingle: comic)
        }.catchFlatMap { error in
            let comicId = 0
            let params = try self.signer.signedParams()
            let endpoint = "http://gateway.marvel.com/v1/public/comics/\(comicId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
                return try response.content.decode(MKComicDataWrapper.self)
            }
        }
    }

    func index(_ req: Request) throws -> Future<MKComicDataWrapper> {
        print("params: \(req.query)")
        let params = try self.signer.signedParams()
        let endpoint = "http://gateway.marvel.com/v1/public/comics?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
            return try response.content.decode(MKComicDataWrapper.self)
        }
    }
}
