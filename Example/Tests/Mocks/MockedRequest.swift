//
//  MockedRequest.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 02/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Cara

class MockedRequest: Request {
    var url: URL?
    var method: RequestMethod
    var query: RequestQuery?
    var headers: RequestHeaders?
    var body: Any?
    var cachePolicy: URLRequest.CachePolicy
    
    init(url: URL?,
         method: RequestMethod = .get,
         query: RequestQuery? = nil,
         headers: RequestHeaders? = nil,
         body: Any? = nil,
         cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) {
        self.url = url
        self.method = method
        self.query = query
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
    }
}
