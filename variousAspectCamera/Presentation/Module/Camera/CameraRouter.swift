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
    func openFolder()
}

struct CameraRouter: CameraRouting {
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openFolder() {
        let navigationController = UINavigationController(rootViewController: ImageFolderModule.setup())
        viewController.present(navigationController, animated: true)
    }
}
