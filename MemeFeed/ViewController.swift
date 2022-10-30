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
      await [test(), test(), test()]
    }
  }

  func test() async {
    let result = await RemoteAPIJSONClient().makeRequest(
      urlString: "https://api.spotify.com/v1/browse/new-releases",
      method: .get,
      headers: ["Authorization": "Bearer BQBWcfmXuwZEpKtGTavUVHo2mUEkY8ZlI3Al3vUe77Yv8tDE6j3ToDk-87XG7eQWGJ6jeWEmyUx_XyhDN12VGhI5xZ_E8i468KIdrAgACkVnD0heJkj-289IZgZDbq7YgXQkDiAxWyzUjNuemMRHu6vaJW2owSFwS5aDeR6B8wQu068c83pT0QHfUQi2ljjfpTapko8WmrzuQ1CnypJBbC0jS8kaHi8s19_yfVcdp_K9EJqUol3npSqAz7XJiA4LBQYa1iZ7mktK81CcKLBLDmlUAFDZuXYKRkMwulg"]
    )

    switch result {
    case .failure(let errorResponse):
      print(errorResponse)
    case .success(let response):
      print(response)
    }
  }
}

