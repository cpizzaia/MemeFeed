//
//  CommentsView.swift
//  MemeFeed
//
//  Created by Cody Pizzaia on 10/31/22.
//

import Foundation
import UIKit

protocol CommentsViewDelegate: AnyObject {
  func didTapDismissInCommentsView(_ view: CommentsView)
}

class CommentsView: UIView, UITableViewDelegate, UITableViewDataSource {
  // MARK: Private Static Properties
  private static let cellReuseId = "cell"

  // MARK: Public Properties
  weak var delegate: CommentsViewDelegate?

  // MARK: Private Properties
  private let dismissButton = UIImageView()
  private let headerLabel = UILabel()
  private let tableView = UITableView()
  private var comments = [RedditComment]()

  // MARK: Public Methods
  init() {
    super.init(frame: .zero)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(withComments comments: [RedditComment]) {
    performOnMainThread {
      self.comments = comments
      self.tableView.reloadData()

      if comments.isEmpty { return }

      self.tableView.scrollToRow(
        at: .init(row: 0, section: 0),
        at: .top,
        animated: false
      )
    }
  }

  @objc func dismissButtonTapped() {
    delegate?.didTapDismissInCommentsView(self)
  }

  // MARK: Private Methods
  private func setupViews() {
    setupDismissButton()
    setupHeaderLabel()
    setupTableView()

    backgroundColor = .init(rgb: 0xF5F5F4)
  }

  private func setupDismissButton() {
    addSubview(dismissButton)

    dismissButton.snp.makeConstraints { make in
      make.height.width.equalTo(20)
      make.top.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-16)
    }

    dismissButton.contentMode = .scaleAspectFit
    dismissButton.image = UIImage(named: "Dismiss")
    dismissButton.isUserInteractionEnabled = true

    dismissButton.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(dismissButtonTapped))
    )
  }

  private func setupHeaderLabel() {
    addSubview(headerLabel)

    headerLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(12)
    }

    headerLabel.font = .systemFont(ofSize: 13, weight: .semibold)
    headerLabel.textColor = .init(rgb: 0x161722)
    headerLabel.text = "61 comments"
  }

  private func setupTableView() {
    addSubview(tableView)

    tableView.snp.makeConstraints { make in
      make.top.equalTo(headerLabel.snp.bottom).offset(15)
      make.left.right.equalToSuperview()
      make.bottom.equalToSuperview().priority(999)
    }

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      CommentTableViewCell.self,
      forCellReuseIdentifier: Self.cellReuseId
    )
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
  }

  // MARK: UITableViewDelegate Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    comments.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseId, for: indexPath)

    if let cell = cell as? CommentTableViewCell, let comment = comments[safe: indexPath.row] {
      cell.configure(withComment: comment)
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
}
