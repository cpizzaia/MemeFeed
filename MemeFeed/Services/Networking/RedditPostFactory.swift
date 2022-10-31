//
//  RedditPostFactory.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

struct RedditPostFactory {
  // MARK: Public Methods
  func create(fromResponse response: RedditResponse.Root<RedditResponse.PostResponse>) -> [RedditPost] {
    return (response.data?.children ?? []).compactMap { child -> RedditPost? in
      guard let postResponse = child?.data else { return nil }

      guard
        let id = postResponse.id,
        let authorName = postResponse.author,
        let upvotes = postResponse.ups,
        let title = postResponse.title,
        let commentCount = postResponse.num_comments
      else { return nil }

      let images = (postResponse.preview?.images ?? []).flatMap { imagesResponse -> [Image] in
        (imagesResponse?.resolutions ?? []).compactMap { imageResponse in
          guard let imageResponse = imageResponse else { return nil }

          return createImage(fromResponse: imageResponse)
        }
      }

      return .init(
        id: id,
        images: images,
        authorName: authorName,
        title: title,
        upvotes: upvotes,
        commentCount: commentCount
      )
    }
  }

  // MARK: Private Methods
  private func createImage(fromResponse response: RedditResponse.ImageResponse) -> Image? {
    guard
      let urlString = response.url,
      let url = URL(string: urlString.replacingOccurrences(of: "amp;", with: "")),
      let height = response.height,
      let width = response.width
    else { return nil }

    return .init(url: url, height: height, width: width)
  }
}
