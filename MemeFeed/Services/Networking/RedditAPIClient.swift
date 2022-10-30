//
//  RedditAPIClient.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import Alamofire

struct RedditAPIClient {
  // MARK: Private Static Properties
  static let baseURL = "https://www.reddit.com/"

  // MARK: Private Properties
  private let client: RemoteAPIJSONClient
  private let decoder: JSONDecoder
  private let postFactory: RedditPostFactory

  // MARK: Public Methods
  init(
    client: RemoteAPIJSONClient = .init(),
    decoder: JSONDecoder = .init(),
    postFactory: RedditPostFactory = .init()
  ) {
    self.client = client
    self.decoder = decoder
    self.postFactory = postFactory
  }

  func getMemesPosts() async -> Result<[RedditPost], RemoteAPIJSONClient.ErrorResponse> {
    let result = await makeRequest(endpoint: "r/memes.json", method: .get)

    switch result {
    case .success(let response):
      guard let root = response else { return .success([])}
      return .success(postFactory.create(fromResponse: root))
    case .failure(let error):
      return .failure(error)
    }
  }

  // MARK: Private Methods
  private func makeRequest(endpoint: String, method: HTTPMethod) async -> Result<RedditResponse.Root?, RemoteAPIJSONClient.ErrorResponse> {
    let result = await client.makeRequest(
      urlString: Self.baseURL + endpoint,
      method: method
    )

    switch result {
    case .success(let response):
      do {
        let root = try decoder.decode(
          RedditResponse.Root.self,
          from: response.body?.data(using: .utf8) ?? Data()
        )

        return .success(root)
      } catch {
        return .success(nil)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
