//
//  FeedViewControllerContentView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class FeedViewControllerContentView: UIView {
  // MARK: Private Properties
  private let postsView = RedditPostsView()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPosts posts: [RedditPost]) {
    postsView.configure(withPosts: posts)
  }

  // MARK: Private Methods
  private func setupViews() {
    setupPostsView()
  }

  private func setupPostsView() {
    addSubview(postsView)

    postsView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
