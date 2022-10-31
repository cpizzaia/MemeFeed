//
//  RedditPostView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit
import SDWebImage

class RedditPostView: UIView {
  // MARK: Private Properties
  private let imageView = UIImageView()
  private let authorLabel = UILabel()
  private let titleLabel = UILabel()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPost post: RedditPost) {
    performOnMainThread { [self] in
      imageView.sd_setImage(with: post.images.last?.url)

      titleLabel.text = post.title
      authorLabel.text = "u/\(post.authorName)"
    }
  }

  // MARK: Private Methods
  private func setupViews() {
    setupImageView()
    setupTitleLabel()
    setupAuthorLabel()

    backgroundColor = .black
  }

  private func setupImageView() {
    addSubview(imageView)

    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    imageView.contentMode = .scaleAspectFit
  }

  private func setupTitleLabel() {
    addSubview(titleLabel)

    titleLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-20)
      make.left.equalToSuperview().offset(16)
    }

    titleLabel.textColor = .white
    titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
  }

  private func setupAuthorLabel() {
    addSubview(authorLabel)

    authorLabel.snp.makeConstraints { make in
      make.bottom.equalTo(titleLabel.snp.top)
      make.left.equalTo(titleLabel.snp.left)
    }

    authorLabel.textColor = .white
    authorLabel.font = .systemFont(ofSize: 17, weight: .semibold)
  }
}

class RedditPostTableViewCell: UITableViewCell {
  // MARK: Private Properties
  private let postView = RedditPostView()

  // MARK: Public Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPost post: RedditPost) {
    postView.configure(withPost: post)
  }

  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(postView)

    postView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
