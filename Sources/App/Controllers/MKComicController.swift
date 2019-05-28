//
//  MKComicController.swift
//  App
//
//  Created by Anh Phan Tran on 07/05/2019.
//

import Vapor

final class MKComicController {
    let signer = MKSigner()
    let paramsExtractor = MKParamsExtractor()

    func one(_ req: Request) throws -> Future<MKComicDataWrapper> {
        let comicId = try req.parameters.next(Int.self)
        return MKComicData.find(comicId, on: req).unwrap(or: Abort(.notFound)).map(to: MKComicDataWrapper.self) { comic in
            return MKComicDataWrapper(withSingle: comic)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/comics/\(comicId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
                return try response.content.decode(MKComicDataWrapper.self)
            }.map { wrapper in
                if let comic = wrapper.data?.results?.first {
                    comic.create(on: req)
                }
                return wrapper
            }
        }
    }

    func index(_ req: Request) throws -> Future<MKComicDataWrapper> {
        print("params: \(req.query)")
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/comics?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
            return try response.content.decode(MKComicDataWrapper.self)
        }
    }
}
