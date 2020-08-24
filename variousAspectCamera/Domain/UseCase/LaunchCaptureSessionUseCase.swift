//
//  LaunchCaptureSessionUseCase.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/15.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation

protocol LaunchCaptureSessionUseCaseType {
    func callAsFunction()
}

struct LaunchCaptureSessionUseCase: LaunchCaptureSessionUseCaseType {
    func callAsFunction() {
        CameraDeviceManager.shared.startSession()
    }
}
