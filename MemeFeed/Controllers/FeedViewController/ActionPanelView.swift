//
//  ActionPanelView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

protocol ActionPanelViewDelegate: AnyObject {
  func actionPanelViewDidTapComments(_ view: ActionPanelView, forPost post: RedditPost)
}

class ActionPanelView: UIView, ActionItemDelegate {
  // MARK: Public Properties
  weak var delegate: ActionPanelViewDelegate?

  // MARK: Private Properties
  private let stackView = UIStackView()
  private let upvoteItem = ActionItem(imageString: "UpArrow", title: "", imageSize: .init(width: 28, height: 31))
  private let messageItem = ActionItem(imageString: "Message", title: "", imageSize: .init(width: 40, height: 40))
  private let shareItem = ActionItem(imageString: "Share", title: "Share", imageSize: .init(width: 40, height: 35))
  private var currentPost: RedditPost?

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()

    messageItem.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPost post: RedditPost) {
    upvoteItem.update(title: "\(post.upvotes)")
    messageItem.update(title: "\(post.commentCount)")
    currentPost = post
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

  // MARK: ActionItemDelegate Methods
  func actionItemReceivedTap(_ view: ActionItem) {
    guard let post = currentPost, view === messageItem else { return }

    delegate?.actionPanelViewDidTapComments(self, forPost: post)
  }
}

protocol ActionItemDelegate: AnyObject {
  func actionItemReceivedTap(_ view: ActionItem)
}

class ActionItem: ExpandedHitAreaView, PressableViewDelegate {
  // MARK: Public Properties
  weak var delegate: ActionItemDelegate?

  // MARK: Private Properties
  private let imageView = PressableImageView()
  private let title = UILabel()

  // MARK: Public Methods
  init(imageString: String, title: String, imageSize: CGSize) {
    super.init(expandedHitAreaDistance: 16)

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

  @objc func tap() {
    delegate?.actionItemReceivedTap(self)
  }

  // MARK: Private Methods
  private func setupViews(withImage image: UIImage, title: String, imageSize: CGSize) {
    setupImageView(withImage: image, imageSize: imageSize)
    setupTitle(title)

    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
  }

  private func setupImageView(withImage image: UIImage, imageSize: CGSize) {
    addSubview(imageView)

    imageView.snp.makeConstraints { make in
      make.left.right.top.equalToSuperview()
      make.size.equalTo(imageSize)
    }

    imageView.contentMode = .scaleAspectFit
    imageView.set(image: image)

    imageView.delegate = self
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

  // MARK: PressableViewDelegate Methods
  func pressableViewDidReceiveTap(_ view: PressableView) {
    tap()
  }
}
