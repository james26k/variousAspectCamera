//
//  CameraViewController.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/06/13.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var shutterView: UIView!
    @IBOutlet weak var shutterButton: ShutterButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func takePicture(_ sender: UIButton) {
        print("shot")
    }
}

