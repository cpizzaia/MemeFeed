//
//  ExpandedHitAreaImageView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation
import UIKit

class ExpandedHitAreaImageView: ExpandedHitAreaView {
  // MARK: Public Properties
  let internalImageView = UIImageView()

  var image: UIImage? {
    didSet {
      performOnMainThread {
        self.internalImageView.image = self.image
      }
    }
  }

  // MARK: Public Methods
  override init(expandedHitAreaDistance: CGFloat) {
    super.init(expandedHitAreaDistance: expandedHitAreaDistance)

    setUpViews()
  }

  override init(expandedHitAreaInsets: UIEdgeInsets) {
    super.init(expandedHitAreaInsets: expandedHitAreaInsets)

    setUpViews()
  }

  convenience init(
    expandedHitAreaDistance: CGFloat,
    image: UIImage?
  ) {
    self.init(expandedHitAreaDistance: expandedHitAreaDistance)
    self.internalImageView.image = image
  }

  convenience init(
    expandedHitAreaInsets: UIEdgeInsets,
    image: UIImage?
    ) {
    self.init(expandedHitAreaInsets: expandedHitAreaInsets)
    self.internalImageView.image = image
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpViews() {
    addSubview(internalImageView)

    internalImageView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }
  }
}
