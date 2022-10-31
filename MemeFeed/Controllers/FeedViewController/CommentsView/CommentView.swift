//
//  CommentView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation
import UIKit

class CommentView: UIView {
  // MARK: Private Properties
  private let accountNameLabel = UILabel()
  private let textLabel = UILabel()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withComment comment: RedditComment) {
    performOnMainThread { [self] in
      accountNameLabel.text = comment.author
      textLabel.text = comment.body
    }
  }

  // MARK: Private Methods
  private func setupViews() {
    setupAccountNameLabel()
    setupTextLabel()
  }

  private func setupAccountNameLabel() {
    addSubview(accountNameLabel)

    accountNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview().offset(16)
    }

    accountNameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
    accountNameLabel.textColor = UIColor(rgb: 0x86878B)
  }

  private func setupTextLabel() {
    addSubview(textLabel)

    textLabel.snp.makeConstraints { make in
      make.left.equalTo(accountNameLabel.snp.left)
      make.top.equalTo(accountNameLabel.snp.bottom).offset(5)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-20)
    }

    textLabel.font = .systemFont(ofSize: 15, weight: .regular)
    textLabel.textColor = .black
    textLabel.numberOfLines = 0
    textLabel.lineBreakMode = .byWordWrapping
  }
}

class CommentTableViewCell: UITableViewCell {
  // MARK: Private Properties
  private let commentView = CommentView()

  // MARK: Public Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(commentView)

    commentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    contentView.backgroundColor = .clear
    backgroundColor = .clear
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withComment comment: RedditComment) {
    commentView.configure(withComment: comment)
  }
}
