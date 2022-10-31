//
//  PressableImageView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation
import UIKit

class PressableImageView: PresseableView {
  // MARK: Private Properties
  private let contentImageView = UIImageView()

  // MARK: Public Methods
  override init() {
    super.init()

    setupContentImageView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(image: UIImage) {
    performOnMainThread { [self] in
      contentImageView.image = image
    }
  }

  // MARK: Private Properties
  private func setupContentImageView() {
    addSubview(contentImageView)

    contentImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
