//
//  RedditPostsView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/30/22.
//

import Foundation
import UIKit

class RedditPostsView: UIView, UITableViewDelegate, UITableViewDataSource {
  // MARK: Private Static Properties
  private static let cellReuseIdentifier = "cell"

  // MARK: Private Properties
  private let tableView = UITableView.init(frame: .zero)
  private var posts = [RedditPost]()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupTableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withPosts posts: [RedditPost]) {
    performOnMainThread { [self] in
      self.posts = posts
      tableView.reloadData()
    }
  }

  // MARK: Private Methods
  private func setupTableView() {
    addSubview(tableView)

    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    tableView.register(
      RedditPostTableViewCell.self,
      forCellReuseIdentifier: Self.cellReuseIdentifier
    )

    tableView.delegate = self
    tableView.dataSource = self

    tableView.isPagingEnabled = true
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.separatorStyle = .none
  }

  // MARK: UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseIdentifier, for: indexPath)

    if let postCell = cell as? RedditPostTableViewCell, let post = posts[safe: indexPath.row] {
      postCell.configure(withPost: post)
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    frame.height
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    posts.count
  }
}
