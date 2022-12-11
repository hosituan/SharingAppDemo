//
//  UIImage+.swift
//  HR-Checkin
//
//  Created by Ho Si Tuan on 13/03/2022.
//

import Foundation
import UIKit


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
extension UIImage {
    
    class func imageWithColor(color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom),
            false,
            self.scale)
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
    
    func scaleToSize(size: CGSize) -> UIImage {
        if self.size.equalTo(size) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func scaleToWith(width: CGFloat) -> UIImage {
        if width < self.size.width {
            let height = width*self.size.height/self.size.width
            return scaleToSize(size: CGSize(width: width, height: height))
        } else {
            return self
        }
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: floor(newWidth),
                                           height: floor(newHeight)))
        self.draw(in: CGRect(x: 0,
                             y: 0,
                             width: newWidth,
                             height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension CIImage {
    func resizeImage(newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        return UIImage(ciImage: self).resizeImage(newWidth: newWidth,
                                                  newHeight: newHeight)
    }
}

extension UIImage {
    func resized(smallestSide: Int) -> UIImage? {
        let smallestSide = CGFloat(smallestSide)
        let newSize: CGSize
        if size.width > size.height {
            newSize = CGSize(width: size.width / size.height * smallestSide, height: smallestSide)
        } else {
            newSize = CGSize(width: smallestSide, height: size.height / size.width * smallestSide)
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func resized(targetSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
    
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        context.rotate(by: CGFloat(radians))
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func changeBrightness(value: Int) -> UIImage? {
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(Float(value) / 100, forKey: kCIInputBrightnessKey)
        let rawimgData = CIImage(image: self)
        filter?.setValue(rawimgData, forKey: "inputImage")
        let outpuImage = filter?.value(forKey: "outputImage")
        return UIImage(ciImage: outpuImage as! CIImage)
    }
    func changeConstrast(value: Int) -> UIImage? {
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(Float(value) / 100, forKey: kCIInputContrastKey)
        let rawimgData = CIImage(image: self)
        filter?.setValue(rawimgData, forKey: "inputImage")
        let outpuImage = filter?.value(forKey: "outputImage")
        return UIImage(ciImage: outpuImage as! CIImage)
    }
    
    func createImageList() -> [UIImage?] {
        var list: [UIImage] = []
        list.append(changeBrightness(value: 20)!)
        list.append(changeBrightness(value: -5)!)
        //list.append(rotate(radians: .pi / 8)!)
        //list.append(rotate(radians: -(.pi / 8))!)
        list.append(self)
        return list
    }
}
extension UIImage {
    func flipHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: self.size.width/2, y: self.size.height/2)
        context.scaleBy(x: -1.0, y: 1.0)
        context.translateBy(x: -self.size.width/2, y: -self.size.height/2)
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


