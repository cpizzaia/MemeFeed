//
//  RemoteAPIJSONClient.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import Alamofire
import SwiftyJSON


struct RemoteAPIJSONClient {
  // MARK: Public Types
  struct Response {
    let body: JSON
    let headers: JSON
    let status: Int
  }

  struct ErrorResponse: Error {
    let body: JSON
    let headers: JSON
    let status: Int
  }

  // MARK: Private Properties
  private let session = Session()

  // MARK: Public Methods
  func makeRequest(urlString: String, method: HTTPMethod, body: Parameters? = nil, headers: HTTPHeaders? = nil) async -> Result<Response, ErrorResponse> {
    guard let url = URL(string: urlString) else {
      return Result.failure(.init(body: JSON(), headers: JSON(), status: 400))
    }

    return await withCheckedContinuation { continuation in
      session.request(
        url,
        method: method,
        parameters: body,
        encoding: JSONEncoding.default,
        headers: headers,
        interceptor: nil,
        requestModifier: nil
      ).validate().response(queue: .global()) { response in
        let responseBody: JSON = {
          do {
            return try JSON(data: response.data ?? Data())
          } catch {
            if let string = String(data: response.data ?? Data(), encoding: .utf8) {
              return JSON(stringLiteral: string)
            }
            return JSON()
          }
        }()

        let headers = JSON((response.response?.allHeaderFields ?? [:]).reduce(into: [String: String]()) { currentResult, element in
          guard let valueString = element.value as? String else { return }
          guard let keyString = element.key as? String else { return }

          currentResult[keyString.lowercased()] = valueString
        })

        let status = response.response?.statusCode ?? 400


        if status > 399 {
          return continuation.resume(
            returning: Result.failure(.init(body: responseBody, headers: headers, status: status))
          )
        }

        continuation.resume(
          returning: Result.success(.init(body: responseBody, headers: headers, status: status))
        )
      }
    }
  }
}
