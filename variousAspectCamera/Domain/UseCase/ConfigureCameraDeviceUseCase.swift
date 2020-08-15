//
//  ConfigureCameraDeviceUseCase.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/15.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

protocol ConfigureCameraDeviceUseCaseType {
    func callAsFunction(camera: AVCaptureDevice)
}

struct ConfigureCameraDeviceUseCase: ConfigureCameraDeviceUseCaseType {
    func callAsFunction(camera: AVCaptureDevice) {
        CameraDeviceManager.shared.configure(camera: camera)
    }
}
