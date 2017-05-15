//
//  File.swift
//  Na4Łapy
//
//  Created by Marek Kaluzny on 14.05.2017.
//  Copyright © 2017 Koduj dla Polski. All rights reserved.
//

import Foundation
import SwiftyOnboard

class OnboardingViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var swiftyOnboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        let appWasLaunchedBefore = UserDefaults.standard.bool(forKey:"launchedBefore")
//        if appWasLaunchedBefore {
//            self.performSegue(withIdentifier: OnboardingContinueSegue, sender: self)
//        }
//    }
    func handleSkip() {
        self.swiftyOnboard.goToPage(index: 4, animated: true)
    }
    
    func handleContinue(sender: UIButton) {
        let index = sender.tag
        if index == 4 {
            self.performSegue(withIdentifier: OnboardingContinueSegue, sender: self)
            return
        } else {
            self.swiftyOnboard.goToPage(index: index + 1, animated: true)
        }
    }
}

extension OnboardingViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(swiftyOnboard: SwiftyOnboard) -> Int {
        return 5
    }
    
    func swiftyOnboardPageForIndex(swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        switch index {
        case 0:
            page.title.isHidden = true
            page.subTitle.text = "Poszukiwanie czworonożnego przyjaciela bywa trudne"
            page.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            break;
        case 1:
            page.title.isHidden = true
            page.subTitle.text = "Określ swoje potrzeby"
            page.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            break;
        case 2:
            page.title.isHidden = true
            page.subTitle.text = "Przeszukaj listę zwierząt poszukujących człowieka"
            page.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            break;
        case 3:
            page.title.isHidden = true
            page.subTitle.text = "Zabierz szczęśliwca do domu..."
            page.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            break;
        default:
            page.title.isHidden = true
            page.subTitle.text = "...albo daj mu się zaprowadzić"
            page.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        
        return page
    }
    
    func swiftyOnboardViewForOverlay(swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        overlay.continueButton.setTitle("Dalej", for: .normal)
        overlay.skipButton.setTitle("Pomiń", for: .normal)
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)
        if currentPage >= 0 && currentPage < 4{
            overlay.continueButton.setTitle("Dalej", for: .normal)
            overlay.skipButton.setTitle("Pomiń", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Zrobione", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
}
