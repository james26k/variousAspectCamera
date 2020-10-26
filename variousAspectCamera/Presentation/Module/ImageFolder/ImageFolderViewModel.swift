//
//  ImageFolderViewModel.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/08/06.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

protocol ImageFolderViewModelInterface {
    var pickerImage: UIImage { get }
}

struct ImageFolderViewModel: ImageFolderViewModelInterface {
    let pickerImage: UIImage

    init(image: UIImage) {
        pickerImage = image
    }
}
