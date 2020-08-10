//
//  ShutterButton.swift
//  variousAspectCamera
//
//  Created by Kohei Hayashi on 2020/07/02.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

final class ShutterButton: UIButton {
    override var isHighlighted: Bool {
        willSet {
            backgroundColor = newValue ? .systemGray4 : .white
        }
    }
}
