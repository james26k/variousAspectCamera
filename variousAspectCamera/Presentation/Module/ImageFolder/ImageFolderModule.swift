//
//  ImageFolderModule.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

enum ImageFolderModule {
    static func setup(image: UIImage) -> ImageFolderViewController {
        let viewController = ImageFolderViewController()
        let viewModel = ImageFolderViewModel(image: image)
        let router = ImageFolderRouter(viewController: viewController)
        viewController.viewModel = viewModel
        viewController.router = router
        viewController.isModalInPresentation = true
        return viewController
    }
}
