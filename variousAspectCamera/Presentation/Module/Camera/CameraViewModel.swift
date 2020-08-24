//
//  CameraViewModel.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

protocol CameraViewModelInterface {
    func getCamera() -> AVCaptureDevice
    func getCameraPreviewLayer() -> AVCaptureVideoPreviewLayer
    func startCaptureSession()
    func takePhoto(delegate: AVCapturePhotoCaptureDelegate)
}

struct CameraViewModel: CameraViewModelInterface {
    private let getCameraDeviceUseCase: GetCameraDeviceUseCaseType
    private let configureCameraDeviceUseCase: ConfigureCameraDeviceUseCaseType
    private let getCameraPreviewLayerUseCase: GetCameraPreviewLayerUseCaseType
    private let launchCaptureSessionUseCase: LaunchCaptureSessionUseCaseType
    private let takePhotoUseCase: TakePhotoUseCaseType

    init(getCameraDeviceUseCase: GetCameraDeviceUseCaseType = GetCameraDeviceUseCase(),
         configureCameraDeviceUseCase: ConfigureCameraDeviceUseCaseType = ConfigureCameraDeviceUseCase(),
         getCameraPreviewLayerUseCase: GetCameraPreviewLayerUseCaseType = GetCameraPreviewLayerUseCase(),
         launchCaptureSessionUseCase: LaunchCaptureSessionUseCaseType = LaunchCaptureSessionUseCase(),
         takePhotoUseCase: TakePhotoUseCaseType = TakePhotoUseCase()) {
        self.getCameraDeviceUseCase = getCameraDeviceUseCase
        self.configureCameraDeviceUseCase = configureCameraDeviceUseCase
        self.getCameraPreviewLayerUseCase = getCameraPreviewLayerUseCase
        self.launchCaptureSessionUseCase = launchCaptureSessionUseCase
        self.takePhotoUseCase = takePhotoUseCase
    }

    func getCamera() -> AVCaptureDevice {
        guard let cameraDevice = getCameraDeviceUseCase() else { fatalError() }
        configureCameraDeviceUseCase(camera: cameraDevice)
        return cameraDevice
    }

    func getCameraPreviewLayer() -> AVCaptureVideoPreviewLayer {
        getCameraPreviewLayerUseCase()
    }
    func startCaptureSession() {
        launchCaptureSessionUseCase()
    }

    func takePhoto(delegate: AVCapturePhotoCaptureDelegate) {
        takePhotoUseCase(delegate: delegate)
    }
}
