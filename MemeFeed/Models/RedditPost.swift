//
//  RedditPost.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

struct RedditPost {
  let id: String
  let images: [Image]
  let authorName: String
  let title: String
  let upvotes: Int
  let commentCount: Int
}

struct Image {
  let url: URL
  let height: Int
  let width: Int
}
