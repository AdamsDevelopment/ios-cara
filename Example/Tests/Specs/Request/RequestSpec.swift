//
//  RequestSpec.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 02/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble

@testable import Cara

class RequestSpec: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        var configuration: MockedConfiguration!
        beforeEach {
            configuration = MockedConfiguration(baseURL: URL(string: "https://relative.com")!)
        }
        
        context("url") {
            it("should have a absolute url") {
                let request = MockedRequest(url: URL(string: "https://absolute.com/request"))
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.url) == URL(string: "https://absolute.com/request")
            }
            
            it("should have a relative url") {
                let request = MockedRequest(url: URL(string: "request"))
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.url) == URL(string: "https://relative.com/request")
            }
            
            it("should throw an invalid url error") {
                let request = MockedRequest(url: nil)
                expect {
                    _ = try request.makeURLRequest(with: configuration)
                }.to(throwError(ResponseError.invalidURL))
            }
        }
        
        context("method") {
            it("should have the correct GET method") {
                let request = MockedRequest(url: URL(string: "request"), method: .get)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "GET"
            }
            
            it("should have the correct HEAD method") {
                let request = MockedRequest(url: URL(string: "request"), method: .head)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "HEAD"
            }
            
            it("should have the correct POST method") {
                let request = MockedRequest(url: URL(string: "request"), method: .post)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "POST"
            }
            
            it("should have the correct PATCH method") {
                let request = MockedRequest(url: URL(string: "request"), method: .patch)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "PATCH"
            }
            
            it("should have the correct PUT method") {
                let request = MockedRequest(url: URL(string: "request"), method: .put)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "PUT"
            }
            
            it("should have the correct DELETE method") {
                let request = MockedRequest(url: URL(string: "request"), method: .delete)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.httpMethod) == "DELETE"
            }
        }
        
        context("headers") {
            it("should have no headers") {
                let request = MockedRequest(url: URL(string: "request"))
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.allHTTPHeaderFields?.count) == 0
            }
            
            it("should have a key value header") {
                let request = MockedRequest(url: URL(string: "request"), headers: ["key": "value"])
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.allHTTPHeaderFields?["key"]) == "value"
                expect(urlRequest?.allHTTPHeaderFields?.count) == 1
            }
            
            it("should have a key value header from the configuration") {
                let configuration = MockedConfiguration(baseURL: URL(string: "https://relative.com")!,
                                                        headers: ["key": "value"])
                let request = MockedRequest(url: URL(string: "request"))
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.allHTTPHeaderFields?["key"]) == "value"
                expect(urlRequest?.allHTTPHeaderFields?.count) == 1
            }
            
            it("should have a key value header from both the request ast the configuration") {
                let configuration = MockedConfiguration(baseURL: URL(string: "https://relative.com")!,
                                                        headers: ["key": "value"])
                let headers = ["key": "other_value", "second_key": "second_value"]
                let request = MockedRequest(url: URL(string: "request"), headers: headers)
                let urlRequest = try? request.makeURLRequest(with: configuration)
                expect(urlRequest?.allHTTPHeaderFields?["key"]) == "other_value"
                expect(urlRequest?.allHTTPHeaderFields?["second_key"]) == "second_value"
                expect(urlRequest?.allHTTPHeaderFields?.count) == 2
            }
        }
    }
}
