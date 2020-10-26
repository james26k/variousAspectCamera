//
//  ImageFolderViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ImageFolderViewController: UIViewController {
    // dependency
    var viewModel: ImageFolderViewModelInterface!
    var router: ImageFolderRouting!
    // UI
    private let scrollView = UIScrollView()
    private let previewImageView = UIImageView()

    private let maxZoomScale: CGFloat = 8.0
    private let minZoomScale: CGFloat = 0.5

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .gray
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .stop,
                                                 target: self,
                                                 action: #selector(dismiss))
        // View Components
        scrollView.delegate = self
        scrollView.maximumZoomScale = maxZoomScale
        scrollView.minimumZoomScale = minZoomScale
        scrollView.backgroundColor = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        // ワンタップのイベント
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTapGesture)
        // ダブルタップのイベント
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
        // NOTE: doubleTapの認識に失敗したらsingleTapの扱いになる
        singleTapGesture.require(toFail: doubleTapGesture)

        previewImageView.backgroundColor = .red
        previewImageView.image = viewModel.pickerImage
        previewImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(previewImageView)
    }
    // レイアウト更新後に呼ばれる
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let size = previewImageView.image?.size {
            // imageViewのサイズがscrollView内に収まるように調整
            let widthRate = scrollView.frame.width / size.width
            let heightRate = scrollView.frame.height / size.height
            let rate = min(widthRate, heightRate, 1)
            previewImageView.frame.size = CGSize(width: size.width * rate,
                                                 height: size.height * rate)
            // contentSizeを画像サイズに設定
            scrollView.contentSize = previewImageView.frame.size
            // 初期表示のためcontentInsetを更新
            updateScrollInset()
        }
    }

    @objc private func dismiss(_ sender: UIBarButtonItem) {
        router.dismiss()
    }

    @objc private func onTap(gesture: UITapGestureRecognizer) {
        if gesture.numberOfTapsRequired == 1 {
            print(1)
        }
        else if gesture.numberOfTapsRequired == 2 {
            if scrollView.zoomScale < scrollView.maximumZoomScale {
                let newScale = scrollView.zoomScale * 2.0
                let zoomRect = zoomRectForScale(scale: newScale, center: gesture.location(in: gesture.view))
                scrollView.zoom(to: zoomRect, animated: true)
            } else {
                scrollView.setZoomScale(1.0, animated: true)
            }
        }
    }

    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        let size = CGSize(
            width: scrollView.frame.size.width / scale,
            height: scrollView.frame.size.height / scale
        )
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
}

extension ImageFolderViewController: UIScrollViewDelegate {
    // ズームに対応させたいViewを返す
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return previewImageView
    }
    // ズームしたタイミングでcontentInsetを更新
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateScrollInset()
    }
    // imageViewの大きさからcontentInsetを再計算
    private func updateScrollInset() {
        scrollView.contentInset = .init(
            top: max((scrollView.frame.height - previewImageView.frame.height)/2, 0),
            left: max((scrollView.frame.width - previewImageView.frame.width)/2, 0),
            bottom: 0,
            right: 0
        )
    }
}
