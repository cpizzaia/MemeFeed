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
  private let accountImageView = UIImageView()
  private let accountNameLabel = UILabel()
  private let textLabel = UILabel()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private Methods
  private func setupViews() {
    setupAccountImageView()
    setupAccountNameLabel()
    setupTextLabel()
  }

  private func setupAccountImageView() {
    addSubview(accountImageView)

    accountImageView.snp.makeConstraints { make in
      make.height.width.equalTo(32)
      make.top.equalToSuperview()
      make.left.equalToSuperview().offset(16)
    }

    accountImageView.clipsToBounds = true
    accountImageView.layer.cornerRadius = 32 / 2
    accountImageView.contentMode = .scaleToFill
  }

  private func setupAccountNameLabel() {
    addSubview(accountNameLabel)

    accountNameLabel.snp.makeConstraints { make in
      make.top.equalTo(accountImageView.snp.top)
      make.left.equalTo(accountImageView.snp.right)
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
    }

    textLabel.font = .systemFont(ofSize: 15, weight: .regular)
    textLabel.textColor = .black
    textLabel.numberOfLines = 0
    textLabel.lineBreakMode = .byWordWrapping
  }
}
