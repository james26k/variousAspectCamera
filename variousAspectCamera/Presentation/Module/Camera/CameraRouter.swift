//
//  CameraRouter.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

protocol CameraRouting {
    func openFolder(image: UIImage)
}

struct CameraRouter: CameraRouting {
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openFolder(image: UIImage) {
        let navigationController = UINavigationController(rootViewController: ImageFolderModule.setup(image: image))
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true)
    }
}
