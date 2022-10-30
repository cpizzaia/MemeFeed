//
//  ArrayExtensions.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation

extension Array {
  subscript (safe index: Index) -> Element? {
    if index >= count { return nil }

    return self[index]
  }
}
