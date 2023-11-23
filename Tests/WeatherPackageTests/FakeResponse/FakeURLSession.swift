//
//  File.swift
//  
//
//  Created by renaud on 23/11/2023.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}

class FakeURLSession: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return MockURLSessionDataTask()
    }
}
