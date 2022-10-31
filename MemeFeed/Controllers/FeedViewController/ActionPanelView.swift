//
//  ActionPanelView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class ActionPanelView: UIView {
  // MARK: Private Properties
  private let stackView = UIStackView()
  private let upvoteItem = ActionItem(imageString: "UpArrow", title: "", imageSize: .init(width: 28, height: 31))
  private let messageItem = ActionItem(imageString: "Message", title: "", imageSize: .init(width: 40, height: 40))
  private let shareItem = ActionItem(imageString: "Share", title: "Share", imageSize: .init(width: 40, height: 35))

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPost post: RedditPost) {
    upvoteItem.update(title: "\(post.upvotes)")
    messageItem.update(title: "\(post.commentCount)")
  }

  // MARK: Private Properties
  private func setupViews() {
    setupStackView()
    setupActionItems()

    backgroundColor = .black.withAlphaComponent(0.5)

    clipsToBounds = true
    layer.cornerRadius = 8
    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
  }

  private func setupStackView() {
    addSubview(stackView)

    stackView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.equalToSuperview().offset(12)
      make.bottom.equalToSuperview().offset(-12)
    }

    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 23
  }

  private func setupActionItems() {
    stackView.addArrangedSubview(upvoteItem)
    stackView.addArrangedSubview(messageItem)
    stackView.addArrangedSubview(shareItem)
  }
}

class ActionItem: UIView {
  // MARK: Private Properties
  private let imageView = UIImageView()
  private let title = UILabel()

  // MARK: Public Methods
  init(imageString: String, title: String, imageSize: CGSize) {
    super.init(frame: .zero)

    if let image = UIImage(named: imageString) {
      setupViews(withImage: image, title: title, imageSize: imageSize)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(title: String) {
    performOnMainThread {
      self.title.text = title
    }
  }

  // MARK: Private Methods
  private func setupViews(withImage image: UIImage, title: String, imageSize: CGSize) {
    setupImageView(withImage: image, imageSize: imageSize)
    setupTitle(title)
  }

  private func setupImageView(withImage image: UIImage, imageSize: CGSize) {
    addSubview(imageView)

    imageView.snp.makeConstraints { make in
      make.left.right.top.equalToSuperview()
      make.size.equalTo(imageSize)
    }

    imageView.contentMode = .scaleAspectFit
    imageView.image = image
  }

  private func setupTitle(_ text: String) {
    addSubview(title)

    title.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(5)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
    }

    title.font = .systemFont(ofSize: 16, weight: .semibold)
    title.textColor = .white
    title.text = text
  }
}
