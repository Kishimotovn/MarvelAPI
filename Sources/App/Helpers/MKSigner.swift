//
//  MKSigner.swift
//  App
//
//  Created by Anh Phan Tran on 17/05/2019.
//

import Foundation
import Crypto

final class MKSigner {
    func signedParams() throws -> String {
        let timestamp = Date().timeIntervalSince1970
        let publicAPIKey = "8da2e7269fff32817c0f81f419db00ce"
        let privateAPIKey = "e06e48a05a4c410c56c8d10bd360c4c0aa8f9e7b"
        
        let hash = try MD5.hash("\(timestamp)\(privateAPIKey)\(publicAPIKey)")
        return "apikey=\(publicAPIKey)&ts=\(timestamp)&hash=\(hash.hexEncodedString())"
    }
}
