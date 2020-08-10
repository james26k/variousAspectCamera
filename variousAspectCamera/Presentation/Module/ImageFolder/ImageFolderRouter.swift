//
//  ImageFolderRouter.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/09.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

protocol ImageFolderRouting {
    func dismiss()
}

struct ImageFolderRouter: ImageFolderRouting {
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
