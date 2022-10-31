//
//  FeedViewControllerContentView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class FeedViewControllerContentView: UIView, RedditPostsViewDelegate, CommentsViewDelegate {
  // MARK: Public Properties
  var actionPanelViewDelegate: ActionPanelViewDelegate? {
    get {
      actionPanel.delegate
    } set {
      actionPanel.delegate = newValue
    }
  }

  // MARK: Private Properties
  private let postsView = RedditPostsView()
  private let titleLabel = UILabel()
  private let actionPanel = ActionPanelView()
  private let commentsView = CommentsView()

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

  func configure(withComments comments: [RedditComment]) {
    commentsView.configure(withComments: comments)
  }

  func showCommentsView() {
    performOnMainThread {
      UIView.animate(withDuration: 0.2, animations: {
        self.commentsView.snp.updateConstraints { update in
          update.height.equalTo(300)
        }

        self.layoutIfNeeded()
      })
    }
  }

  func hideCommentsView() {
    performOnMainThread {
      UIView.animate(withDuration: 0.2, animations: {
        self.commentsView.snp.updateConstraints { update in
          update.height.equalTo(0)
        }

        self.layoutIfNeeded()
      })
    }
  }

  // MARK: Private Methods
  private func setupViews() {
    setupPostsView()
    setupTitleLabel()
    setupActionPanel()
    setupCommentsView()
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

  private func setupCommentsView() {
    addSubview(commentsView)

    commentsView.snp.makeConstraints { make in
      make.height.equalTo(0)
      make.width.equalToSuperview()
      make.bottom.equalToSuperview()
    }

    commentsView.delegate = self
  }

  // MARK: RedditPostsViewDelegate Methods
  func redditPostsView(_ view: RedditPostsView, didDisplayPost post: RedditPost) {
    actionPanel.configure(withPost: post)

    hideCommentsView()
  }

  // MARK: CommentsViewDelegate Methods
  func didTapDismissInCommentsView(_ view: CommentsView) {
    hideCommentsView()
  }
}
