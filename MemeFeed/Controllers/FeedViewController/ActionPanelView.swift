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

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private Properties
  private func setupViews() {
    setupStackView()

    backgroundColor = .black.withAlphaComponent(0.5)

    clipsToBounds = true
    layer.cornerRadius = 8
    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
  }

  private func setupStackView() {
    addSubview(stackView)

    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    stackView.axis = .vertical
    stackView.alignment = .center
  }
}

class ActionItem: UIView {
  // MARK: Private Properties
  private let imageView = UIImageView()
  private let title = UILabel()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private Methods
  private func setupViews() {
    setupImageView()
  }

  private func setupImageView() {
    addSubview(imageView)

    imageView.snp.makeConstraints { make in
      make.left.right.top.equalToSuperview()
      make.height.equalTo(50)
    }

    imageView.contentMode = .scaleAspectFit
  }

  private func setupTitle() {
    addSubview(title)

    title.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(5)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
    }

    title.font = .systemFont(ofSize: 14, weight: .regular)
    title.textColor = .white
  }
}
