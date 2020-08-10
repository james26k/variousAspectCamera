//
//  ImageFolderModule.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation

enum ImageFolderModule {
    static func setup() -> ImageFolderViewController {
        let viewController = ImageFolderViewController()
        let viewModel = ImageFolderViewModel()
        let router = ImageFolderRouter(viewController: viewController)
        viewController.viewModel = viewModel
        viewController.router = router
        return viewController
    }
}
