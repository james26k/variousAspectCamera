//
//  GetCameraPreviewLayerUseCase.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/15.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

protocol GetCameraPreviewLayerUseCaseType {
    func callAsFunction() -> AVCaptureVideoPreviewLayer
}

struct GetCameraPreviewLayerUseCase: GetCameraPreviewLayerUseCaseType {
    func callAsFunction() -> AVCaptureVideoPreviewLayer {
        CameraDeviceManager.shared.getPreviewLayer(gravity: .resizeAspectFill,
                                                   orientation: .portrait)
    }
}
