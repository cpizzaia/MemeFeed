//
//  RedditAPIClient.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import Alamofire

struct RedditAPIClient {
  // MARK: Private Types
  typealias RedditAPIClientResult<ResponseType: Codable> = Result<ResponseType, RemoteAPIJSONClient.ErrorResponse>

  // MARK: Private Static Properties
  static let baseURL = "https://www.reddit.com/"

  // MARK: Private Properties
  private let client: RemoteAPIJSONClient
  private let decoder: JSONDecoder
  private let postFactory: RedditPostFactory
  private let commentFactory: RedditCommentFactory

  // MARK: Public Methods
  init(
    client: RemoteAPIJSONClient = .init(),
    decoder: JSONDecoder = .init(),
    postFactory: RedditPostFactory = .init(),
    commentFactory: RedditCommentFactory = .init()
  ) {
    self.client = client
    self.decoder = decoder
    self.postFactory = postFactory
    self.commentFactory = commentFactory
  }

  func getComments(forPostId postId: String, inSubreddit subreddit: String) async -> Result<[RedditComment], RemoteAPIJSONClient.ErrorResponse> {
    let result: RedditAPIClientResult<[RedditResponse.Root<RedditResponse.CommentsResponse>?]?> = await makeRequest(
      endpoint: "r/\(subreddit)/comments/\(postId).json",
      method: .get
    )

    switch result {
    case .success(let response):
      guard let root = response else { return .success([]) }
      return .success(commentFactory.create(fromResponse: root))
    case .failure(let error):
      return .failure(error)
    }
  }

  func getMemesPosts() async -> Result<[RedditPost], RemoteAPIJSONClient.ErrorResponse> {
    let result: RedditAPIClientResult<RedditResponse.Root<RedditResponse.PostResponse>?> = await makeRequest(
      endpoint: "r/memes.json",
      method: .get
    )

    switch result {
    case .success(let response):
      guard let root = response else { return .success([])}
      return .success(postFactory.create(fromResponse: root))
    case .failure(let error):
      return .failure(error)
    }
  }

  // MARK: Private Methods
  private func makeRequest<ResponseType: Codable>(endpoint: String, method: HTTPMethod) async -> Result<ResponseType?, RemoteAPIJSONClient.ErrorResponse> {
    let result = await client.makeRequest(
      urlString: Self.baseURL + endpoint,
      method: method
    )

    switch result {
    case .success(let response):
      do {
        let root = try decoder.decode(
          ResponseType.self,
          from: response.body?.data(using: .utf8) ?? Data()
        )

        return .success(root)
      } catch let error {
        print(error)
        return .success(nil)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
