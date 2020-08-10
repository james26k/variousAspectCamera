//
//  CameraModule.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/10.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

enum CameraModule {
    static func setup() -> CameraViewController {
        let storyboard = UIStoryboard(name: "Camera", bundle: nil)
        guard
            let initialVC = storyboard.instantiateInitialViewController() as? CameraViewController
        else {
            fatalError("missing initialVC")
        }
        let viewModel = CameraViewModel()
        let router = CameraRouter(viewController: initialVC)
        initialVC.viewModel = viewModel
        initialVC.router = router
        return initialVC
    }
}
