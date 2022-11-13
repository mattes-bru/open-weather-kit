//
//  Client.swift
//  
//
//  Created by Jeremy Greenwood on 11/9/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
import NIOCore
#endif

protocol Client: Sendable {
#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse

    func shutdown() async throws
#else
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
#endif
}

#if os(Linux)
extension HTTPClient: Client {
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {
        try await execute(request, timeout: timeout, logger: nil)
    }
}
#else
extension URLSession: Client {}
#endif
