//
//  CameraViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/06/13.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var shutterView: UIView!
    @IBOutlet weak var shutterButton: ShutterButton!
    // CaptureSession
    private var captureSession = AVCaptureSession()
    // Device
    private var mainCamera: AVCaptureDevice?
    private var innerCamera: AVCaptureDevice?
    private var currentCamera: AVCaptureDevice?
    // OutPut
    private var photoOutput: AVCapturePhotoOutput?
    // PreviewLayer
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    override func loadView() {
        super.loadView()
        setupCaptureSession()
        setupDevice()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
    }
    // カメラの画質設定
    private func setupCaptureSession() {
        captureSession.sessionPreset = .photo
    }
    // 利用できるデバイスの取得、設定
    private func setupDevice() {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .unspecified)
        let devices = discoverySession.devices

        mainCamera = devices.first { $0.position == .back }
        innerCamera = devices.first { $0.position == .front }

        currentCamera = mainCamera
    }
    // 入出力データの設定
    private func setupInputOutput() {
        guard let currentCamera = currentCamera else { return }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])],
                                                       completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }
        catch {
            let alert = UIAlertController(title: "error", message: "デバイスの設定に失敗しました。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .cancel))
            present(alert, animated: true)
        }
    }
    // Preview用のLayer設定
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = .resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = .portrait
        cameraPreviewLayer?.frame = captureView.frame
        captureView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }

    @IBAction func takePicture(_ sender: UIButton) {
        print("shot")
    }
}

