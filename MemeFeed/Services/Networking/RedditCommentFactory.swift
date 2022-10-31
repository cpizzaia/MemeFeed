//
//  RedditCommentFactory.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation

struct RedditCommentFactory {
  func create(fromResponse responses: [RedditResponse.Root<RedditResponse.CommentsResponse>?]) -> [RedditComment] {
    return responses.flatMap { response in
      return (response?.data?.children ?? []).compactMap { child -> RedditComment? in
        guard let commentResponse = child?.data else { return nil }

        guard
          let author = commentResponse.author,
          let body = commentResponse.body
        else {
          return nil
        }

        return .init(author: author, body: body)
      }
    }
  }
}
