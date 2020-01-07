//
//  VideoContainerView.swift
//  Test
//
//  Created by kiwan on 2020/01/07.
//  Copyright © 2020 kiwan. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoContainerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
