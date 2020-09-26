//
//  CameraDeviceManager.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/15.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import AVFoundation

final class CameraDeviceManager {
    static let shared = CameraDeviceManager()
    // required value
    private var captureSession: AVCaptureSession!
    //TODO: 単一プロパティを用意

    private init() {
        captureSession = AVCaptureSession()
    }

    func getCamera(deviceTypes: [AVCaptureDevice.DeviceType],
                   position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                                mediaType: .video,
                                                                position: position)
        let availableDevices = discoverySession.devices
        let availableCamera = availableDevices.first { $0.position == position }
        return availableCamera
    }

    func configure(camera: AVCaptureDevice) {
        setupImageQuality()
        setupInputOutput(camera: camera, codecType: .jpeg)
    }

    func getPreviewLayer(gravity: AVLayerVideoGravity,
                         orientation: AVCaptureVideoOrientation) -> AVCaptureVideoPreviewLayer {
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = gravity
        cameraPreviewLayer.connection?.videoOrientation = orientation
        return cameraPreviewLayer
    }

    func startSession() {
        captureSession.startRunning()
    }

    func takePhoto(delegate: AVCapturePhotoCaptureDelegate) {
        let photoSetting = AVCapturePhotoSettings()
        guard let output = captureSession.outputs.first as? AVCapturePhotoOutput else { fatalError() }
        output.capturePhoto(with: photoSetting, delegate: delegate)
    }
    // カメラの画質設定
    private func setupImageQuality() {
        captureSession.sessionPreset = .photo
    }
    // 入出力情報の設定
    private func setupInputOutput(camera: AVCaptureDevice, codecType: AVVideoCodecType) {
        do {
            let photoInput = try AVCaptureDeviceInput(device: camera)
            let photoOutput: AVCapturePhotoOutput = {
                let photoOutput = AVCapturePhotoOutput()
                let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: codecType])
                photoOutput.setPreparedPhotoSettingsArray([photoSettings])
                return photoOutput
            }()
            captureSession.addInput(photoInput)
            captureSession.addOutput(photoOutput)
        }
        catch {
            fatalError("missing device input") // TODO: throw error
        }
    }
}
