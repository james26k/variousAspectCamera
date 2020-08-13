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
    @IBOutlet weak var folderButton: UIButton!
    // dependency
    var viewModel: CameraViewModelInterface!
    var router: CameraRouting!
    // CaptureSession
    private let captureSession = AVCaptureSession()
    // Device
    private var currentCamera: AVCaptureDevice?
    // OutPut
    private var photoOutput: AVCapturePhotoOutput?
    // PreviewLayer(Viewに描画する内容を管理するオブジェクト)
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
        // sessionの起動
        captureSession.startRunning()
    }
    // カメラの画質設定
    private func setupCaptureSession() {
        captureSession.sessionPreset = .photo
    }
    // 利用できるデバイスの取得、設定
    private func setupDevice() {
        // カメラデバイスのプロパティ設定
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .unspecified)
        // 設定を満たしたデバイスを取得
        let devices = discoverySession.devices
        // 取得したデバイスから条件に合うものをcaptureDeviceに設定
        currentCamera = devices.first { $0.position == .back }
    }
    // 入出力データの設定
    private func setupInputOutput() {
        guard let currentCamera = currentCamera else { return }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera)
            guard captureSession.canAddInput(captureDeviceInput) else { throw NSError() }
            photoOutput = AVCapturePhotoOutput()
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])],
                                                       completionHandler: nil)
            // 上記の入出力の設定を適用
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(photoOutput!)
        }
        catch {
            let alert = UIAlertController(title: "error", message: "missing capture device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "close", style: .cancel))
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

    @IBAction func takePhoto(_ sender: UITapGestureRecognizer) {
        // 撮影の設定を管理するオブジェクト(１回につき１設定)
        let photoSettings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: photoSettings, delegate: self)
    }

    @IBAction func openFolder(_ sender: UIButton) {
        router.openFolder()
    }
}
// 画像データをハンドリングする
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            guard let image = UIImage(data: imageData) else { return }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}

