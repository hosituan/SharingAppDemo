//
//  UIScreen+.swift
//  StarCheckIn
//
//  Created by Tuan Si Ho (3406) on 02/12/2022.
//

import Foundation
import UIKit
import SnapKit

extension UIScreen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let designHeight: CGFloat = 1200
    static let desiginWidth: CGFloat = 1920
}

extension ConstraintMakerEditable {
    
    private func getWidthRatio(value: CGFloat) -> CGFloat {
        return value / UIScreen.desiginWidth * UIScreen.width
    }
    
    private func getHeightRatio(value: CGFloat) -> CGFloat {
        return value / UIScreen.designHeight * UIScreen.height
    }
    
    func offsetWidthRatio(_ designOffset: CGFloat) {
        self.offset(getWidthRatio(value: designOffset))
    }
    
    func offsetHeightRatio(_ designOffset: CGFloat) {
        self.offset(getHeightRatio(value: designOffset))
    }
    
    func insetWidthRatio(_ designOffset: CGFloat) {
        self.inset(getWidthRatio(value: designOffset))
    }
    
    func insetHeightRatio(_ designOffset: CGFloat) {
        self.inset(getHeightRatio(value: designOffset))
    }
}


