//
//  RedditResponses.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

enum RedditResponse {
  struct Root<ChildrenType: Codable>: Codable {
    let kind: String?
    let data: Data<ChildrenType>?
  }

  struct Data<ChildrenType: Codable>: Codable {
    let after: String?
    let before: String?
    let children: [ChildrenType?]?
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

  struct CommentsResponse: Codable {
    let data: CommentResponseData?
  }

  struct CommentResponseData: Codable {
    let author: String?
    let body: String?
  }
}
