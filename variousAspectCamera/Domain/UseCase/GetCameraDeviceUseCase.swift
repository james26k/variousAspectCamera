//
//  GetCameraDeviceUseCase.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/15.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

protocol GetCameraDeviceUseCaseType {
    func callAsFunction() -> AVCaptureDevice?
}

struct GetCameraDeviceUseCase: GetCameraDeviceUseCaseType {
    func callAsFunction() -> AVCaptureDevice? {
        CameraDeviceManager.shared.getCamera(deviceTypes: [.builtInDualCamera],
                                             position: .back)
    }
}
