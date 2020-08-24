//
//  TakePhotoUseCase.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/24.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

protocol TakePhotoUseCaseType {
    func callAsFunction(delegate: AVCapturePhotoCaptureDelegate)
}

struct TakePhotoUseCase: TakePhotoUseCaseType {
    func callAsFunction(delegate: AVCapturePhotoCaptureDelegate) {
        CameraDeviceManager.shared.takePhoto(delegate: delegate)
    }
}
