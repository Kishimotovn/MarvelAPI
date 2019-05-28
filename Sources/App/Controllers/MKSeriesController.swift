//
//  MKSeriesController.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Vapor

final class MKSeriesController {
    let signer = MKSigner()
    let paramsExtractor = MKParamsExtractor()
    
    func one(_ req: Request) throws -> Future<MKSeriesDataWrapper> {
        let seriesId = try req.parameters.next(Int.self)
        return MKSeriesData.find(seriesId, on: req).unwrap(or: Abort(.notFound)).map(to: MKSeriesDataWrapper.self) { series in
            return MKSeriesDataWrapper(withSingle: series)
        }.catchFlatMap { error in
            let signs = try self.signer.signedParams()
            let query = self.paramsExtractor.extractParams(from: req.http.url)
            let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
            let endpoint = "http://gateway.marvel.com/v1/public/series/\(seriesId)?\(params)"
            return try req.client().get(endpoint).flatMap(to: MKSeriesDataWrapper.self) { response in
                return try response.content.decode(MKSeriesDataWrapper.self)
            }.map { wrapper in
                if let series = wrapper.data?.results?.first {
                    series.create(on: req)
                }
                return wrapper
            }
        }
    }
    
    func index(_ req: Request) throws -> Future<MKSeriesDataWrapper> {
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/series?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKSeriesDataWrapper.self) { response in
            return try response.content.decode(MKSeriesDataWrapper.self)
        }
    }

    func comics(_ req: Request) throws -> Future<MKComicDataWrapper> {
        let seriesId = try req.parameters.next(Int.self)
        let signs = try self.signer.signedParams()
        let query = self.paramsExtractor.extractParams(from: req.http.url)
        let params = [signs, query].filter { return !$0.isEmpty }.joined(separator: "&")
        let endpoint = "http://gateway.marvel.com/v1/public/series/\(seriesId)/comics?\(params)"
        return try req.client().get(endpoint).flatMap(to: MKComicDataWrapper.self) { response in
            return try response.content.decode(MKComicDataWrapper.self)
        }
    }
}

