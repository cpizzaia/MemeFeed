//
//  PressableView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class PresseableView: UIButton {
  // MARK: Public Methods
  init() {
    super.init(frame: .zero)
    addTarget(self, action: #selector(touchedDown), for: .touchDown)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func touchedDown() {
    animateSmaller {
      self.animateToOriginalSize()
    }
  }

  // MARK: Private Methods
  private func animateSmaller(_ completion: @escaping () -> Void) {
    UIView.animate(withDuration: 0.3, delay: 0, animations: { [self] in
      transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }, completion: { _ in completion() })
  }

  private func animateToOriginalSize() {
    UIView.animate(withDuration: 0.3, delay: 0, animations: { [self] in
      transform = CGAffineTransform(scaleX: 1, y: 1)
    })
  }
}
