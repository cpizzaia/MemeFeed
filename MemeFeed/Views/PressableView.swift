//
//  PressableView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

protocol PressableViewDelegate: AnyObject {
  func pressableViewDidReceiveTap(_ view: PressableView)
}

class PressableView: UIButton {
  // MARK: Public Properties
  weak var delegate: PressableViewDelegate?

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)
    addTarget(self, action: #selector(touchedDown), for: .touchDown)
    addTarget(self, action: #selector(touchedUpInside), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func touchedDown() {
    animateSmaller {
      self.animateToOriginalSize()
    }
  }

  @objc func touchedUpInside() {
    delegate?.pressableViewDidReceiveTap(self)
  }

  // MARK: Private Methods
  private func animateSmaller(_ completion: @escaping () -> Void) {
    UIView.animate(withDuration: 0.1, delay: 0, animations: { [self] in
      transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }, completion: { _ in completion() })
  }

  private func animateToOriginalSize() {
    UIView.animate(withDuration: 0.1, delay: 0, animations: { [self] in
      transform = CGAffineTransform(scaleX: 1, y: 1)
    })
  }
}
