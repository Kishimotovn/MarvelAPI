//
//  MKParamsExtractor.swift
//  App
//
//  Created by Anh Phan Tran on 28/05/2019.
//

import Foundation

class MKParamsExtractor {
    func extractParams(from url: URL) -> String {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        var queryParams = [String]()

        components?.queryItems?.forEach { queryItem in
            switch queryItem.name {
            case "apikey", "ts", "hash":
                break
            default:
                queryParams.append("\(queryItem.name)=\(queryItem.value ?? "")")
            }
        }

        return queryParams.joined(separator: "&")
    }
}
