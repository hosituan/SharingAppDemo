//
//  UIButton+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 13/03/2022.
//

import Foundation
import Foundation
import UIKit

extension UIButton {
    func leftImage(image: UIImage?) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (image?.size.width ?? 0) + 10)
    }
    
    func addCharacterSpacing(_ space: CGFloat = 1.15) {
        if let labelText = self.titleLabel?.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: space, range: NSRange(location: 0, length: attributedString.length - 1))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func spacingTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    @IBInspectable var letterSpacing: CGFloat {
        get {
            return 1
        }
        set {
            self.addCharacterSpacing(newValue / 10)
        }
    }
    
    func setBackgroundColor(color: UIColor, forUIControlState state: UIControl.State) {
        self.setBackgroundImage(UIImage.imageWithColor(color: color), for: state)
    }
}
