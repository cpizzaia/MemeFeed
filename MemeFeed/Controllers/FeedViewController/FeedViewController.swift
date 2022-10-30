//
//  FeedViewController.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
  // MARK: Private Properties
  private let contentView = FeedViewControllerContentView()
  private let client: RedditAPIClient

  // MARK: Public Methods
  init(client: RedditAPIClient = .init()) {
    self.client = client

    super.init(nibName: nil, bundle: nil)

    view.addSubview(contentView)

    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    view.backgroundColor = .green
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    Task {
      let result = await client.getMemesPosts()

      switch result {
      case .success(let posts):
        contentView.configure(withPosts: posts)
      case .failure(_):
        print("errored")
      }
    }
  }

  // MARK: Private Methods
  private func test() async {
    let result = await RedditAPIClient().getMemesPosts()

    switch result {
    case .success(let response):
      print(response)
    case .failure(let error):
      print(error)
    }
  }
}

