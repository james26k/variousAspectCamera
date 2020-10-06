//
//  CameraViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/06/13.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import UIKit
import AVFoundation

private typealias AspectRatio = (width: CGFloat, height: CGFloat)

class CameraViewController: UIViewController {
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var folderButton: UIButton!
    // dependency
    var viewModel: CameraViewModelInterface!
    var router: CameraRouting!
    // Device
    private var cameraDevice: AVCaptureDevice?
    // Property
    private var aspectRatio: AspectRatio = (width: 1.0, height: 2.35)

    override var prefersStatusBarHidden: Bool { true }

    override func loadView() {
        super.loadView()
        setNeedsStatusBarAppearanceUpdate()
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
        let screenMainBounds = UIScreen.main.bounds
        let previewWidth = screenMainBounds.maxY / aspectRatio.height
        let previewHeight = screenMainBounds.maxY
        let previewPositionX = screenMainBounds.maxX - previewWidth
        let previewPositionY: CGFloat = 0.0
        previewLayer.frame = .init(x: previewPositionX,
                                   y: previewPositionY,
                                   width: previewWidth,
                                   height: previewHeight)
        previewLayer.backgroundColor = .init(red: 180, green: 180, blue: 180, alpha: 1)
        captureView.layer.insertSublayer(previewLayer, at: 0)
    }

    @IBAction func takePhoto(_ sender: UIButton) {
        let tmpColor = captureView.layer.backgroundColor
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .autoreverse,
                       animations: { [captureView] in
                        captureView?.layer.backgroundColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                       },
                       completion: { [captureView] _ in
                        captureView?.layer.backgroundColor = tmpColor
                       }
        )
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
            let resizedImage = image.resizeTo(aspectRatio: aspectRatio)
            UIImageWriteToSavedPhotosAlbum(resizedImage, nil, nil, nil)
        }
    }
}

private extension UIImage {
    func resizeTo(aspectRatio: AspectRatio) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        var width: CGFloat = .init(cgImage.width)
        var height: CGFloat = .init(cgImage.height)

        if (height * aspectRatio.height) > (width * aspectRatio.width) {
            height = width * aspectRatio.width / aspectRatio.height
        }
        else {
            width = height * aspectRatio.height / aspectRatio.width
        }
        let rect = CGRect(
            x: (CGFloat(cgImage.width) - width) * 0.5,
            y: (CGFloat(cgImage.height) - height) * 0.5,
            width: width,
            height: height
        )
        if let newCgImage = cgImage.cropping(to: rect) {
            let croppedUIImage = UIImage(cgImage: newCgImage,
                                         scale: self.scale,
                                         orientation: self.imageOrientation.adjustForSaving())
            return croppedUIImage
        }
        return self
    }
}
// outputで出力されるimageOrientationがいち
extension UIImage.Orientation {
    func adjustForSaving() -> Self {
        switch UIDevice.current.orientation {
        case .portrait:
            return self
        case .portraitUpsideDown:
            return .left
        case .landscapeLeft:
            return .up
        case .landscapeRight:
            return .down
        default:
            return self
        }
    }
}
