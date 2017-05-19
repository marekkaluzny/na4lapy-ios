//
//  File.swift
//  Na4Łapy
//
//  Created by Marek Kaluzny on 14.05.2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import UIKit
import SwiftyOnboard

class OnboardingPage: SwiftyOnboardPage {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "OnboardingPage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
