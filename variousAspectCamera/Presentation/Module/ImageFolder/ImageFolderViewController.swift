//
//  ImageFolderViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ImageFolderViewController: UIViewController {
    // dependency
    var viewModel: ImageFolderViewModelInterface!
    var router: ImageFolderRouting!
    // UI
    private let tableView = UITableView()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .stop,
                                                 target: self,
                                                 action: #selector(dismiss))
    }

    private func setupViews() {
        // tableView config
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.readableContentGuide)
        }
    }

    @objc private func dismiss(_ sender: UIBarButtonItem) {
        router.dismiss()
    }
}
