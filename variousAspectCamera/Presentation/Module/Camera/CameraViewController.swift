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
    // Device
    private var cameraDevice: AVCaptureDevice?

    override func loadView() {
        super.loadView()
        cameraDevice = viewModel.getCamera()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewLayer()
        viewModel.startCaptureSession()
    }
    // Preview用のLayer設定
    func setupPreviewLayer() {
        let previewLayer = viewModel.getCameraPreviewLayer()
        previewLayer.frame = captureView.frame
        captureView.layer.insertSublayer(previewLayer, at: 0)
    }

    @IBAction func takePhoto(_ sender: UIButton) {
        viewModel.takePhoto(delegate: self as AVCapturePhotoCaptureDelegate)
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

