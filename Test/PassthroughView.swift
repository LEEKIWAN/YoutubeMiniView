//
//  EventPassView.swift
//  Test
//
//  Created by kiwan on 2020/01/06.
//  Copyright © 2020 kiwan. All rights reserved.
//

import Foundation
import UIKit


class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
