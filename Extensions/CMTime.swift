//
//  CMTime.swift
//  frog
//
//  Created by Lili on 06/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import AVKit



extension CMTime  {
func toDisplayString() -> String  {
    
    if CMTimeGetSeconds(self).isNaN {
        return "--:--"
    }
    let totalSeconds = Int (CMTimeGetSeconds(self))
    
    let seconds = totalSeconds % 60
    let minutes = totalSeconds / 60
    let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
    
    return timeFormatString
    
  }

}
