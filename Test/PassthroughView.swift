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
    weak var touchDelegate: UIView? = nil
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {
            return nil
        }
        
        guard view === self, let point = touchDelegate?.convert(point, from: self) else {
            return view
        }
        
        return touchDelegate?.hitTest(point, with: event)
    }
}
