//
//  ExpandedHitAreaView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation
import UIKit

class ExpandedHitAreaView: UIView {
  // MARK: Public Properties
  var expandedHitAreaInsets: UIEdgeInsets?

  // MARK: Private Properties
  private let expandedHitAreaDistance: CGFloat?

  // MARK: Public Methods
  init(expandedHitAreaDistance: CGFloat) {
    self.expandedHitAreaDistance = -expandedHitAreaDistance
    self.expandedHitAreaInsets = nil
    super.init(frame: .zero)
  }

  init(expandedHitAreaInsets: UIEdgeInsets) {
    self.expandedHitAreaInsets = expandedHitAreaInsets
    self.expandedHitAreaDistance = nil
    super.init(frame: .zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let insetBounds: CGRect? = {
      if let expandedHitAreaDistance = expandedHitAreaDistance {
        return self.bounds.insetBy(dx: expandedHitAreaDistance, dy: expandedHitAreaDistance)
      } else if let expandedHitAreaInsets = expandedHitAreaInsets {
        return self.bounds.inset(by: expandedHitAreaInsets)
      } else {
        return nil
      }
    }()

    return insetBounds?.contains(point) == true
  }
}
