//
//  FeedViewControllerContentView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class FeedViewControllerContentView: UIView, RedditPostsViewDelegate {
  // MARK: Private Properties
  private let postsView = RedditPostsView()
  private let titleLabel = UILabel()
  private let actionPanel = ActionPanelView()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()

    postsView.delegate = self
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
    setupActionPanel()
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

    titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    titleLabel.text = "r/Memes"
  }

  private func setupActionPanel() {
    addSubview(actionPanel)

    actionPanel.snp.makeConstraints { make in
      make.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-20)
      make.width.equalTo(80)
    }
  }

  // MARK: RedditPostsViewDelegate Methods
  func redditPostsView(_ view: RedditPostsView, didDisplayPost post: RedditPost) {
    actionPanel.configure(withPost: post)
  }
}
