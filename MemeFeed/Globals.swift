//
//  Globals.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

func performOnMainThread(_ block: @escaping () -> Void) {
  if Thread.isMainThread {
    return block()
  }

  DispatchQueue.main.async {
    block()
  }
}
