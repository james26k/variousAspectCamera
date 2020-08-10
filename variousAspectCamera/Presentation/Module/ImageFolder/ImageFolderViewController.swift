//
//  ImageFolderViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

final class ImageFolderViewController: UIViewController {
    // dependency
    var viewModel: ImageFolderViewModelInterface!
    var router: ImageFolderRouting!

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .stop,
                                                 target: self,
                                                 action: #selector(dismiss))
    }

    @objc private func dismiss(_ sender: UIBarButtonItem) {
        router.dismiss()
    }
}
