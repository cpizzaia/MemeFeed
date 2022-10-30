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
  private let titleLabel = UILabel()

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
    setupTitleLabel()
  }

  private func setupPostsView() {
    addSubview(postsView)

    postsView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func setupTitleLabel() {
    addSubview(titleLabel)

    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview()
    }

    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    titleLabel.text = "r/Memes"
  }
}
