//
//  RedditResponses.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

enum RedditResponse {
  struct Root: Codable {
    let kind: String?
    let data: Data?
  }

  struct Data: Codable {
    let after: String?
    let before: String?
    let children: [PostResponse?]?
  }

  struct PostResponse: Codable {
    let data: PostResponseData?
  }

  struct PostResponseData: Codable {
    let id: String?
    let preview: PreviewImagesResponse?
    let author: String?
    let title: String?
    let ups: Int?
    let num_comments: Int?
  }

  struct PreviewImagesResponse: Codable {
    let images: [ImagesResponse?]?
  }

  struct ImagesResponse: Codable {
    let resolutions: [ImageResponse?]?
  }

  struct ImageResponse: Codable {
    let url: String?
    let width: Int?
    let height: Int?
  }
}
