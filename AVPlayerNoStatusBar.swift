//
//  AVPlayerNoStatusBar.swift
//  Instructional Apps to Promote Financial Literacy
//
//  Created by Ed Silkworth on 1/15/19.
//  Copyright © 2019 Ed Silkworth. All rights reserved.
//

import AVKit

class AVPlayerNoStatusBar: AVPlayerViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
