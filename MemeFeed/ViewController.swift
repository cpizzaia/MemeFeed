//
//  ViewController.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .green

    Task {
      await test()
    }
  }

  func test() async {
    let result = await RedditAPIClient().getMemesPosts()

    switch result {
    case .success(let response):
      print(response)
    case .failure(let error):
      print(error)
    }
  }
}

