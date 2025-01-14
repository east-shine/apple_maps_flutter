//
//  AnnotationIcon.swift
//  apple_maps_flutter
//
//  Created by Luis Thein on 07.03.20.
//

import Foundation

enum IconType {
    case PIN, MARKER, CUSTOM_FROM_ASSET, CUSTOM_FROM_BYTES
}

class AnnotationIcon: Equatable {
    
    var iconType: IconType
    var id: String
    var image: UIImage?
    var hueColor: Double?
    
    public init(id: String, iconType: IconType) {
        self.iconType = iconType
        self.id = id
    }
    
    public init(id: String, iconType: IconType, hueColor: Double) {
        self.iconType = iconType
        self.id = id
        self.hueColor = hueColor
    }
    
    public init(withAsset name: String, id: String, iconScale: CGFloat? = 1.0) {
        self.iconType = .CUSTOM_FROM_ASSET
        self.id = id
        if let uiImage: UIImage =  UIImage.init(named: name) {
            self.image = self.scaleImage(image: uiImage, scale: iconScale!)
        }
    }
    
    public init(fromBytes bytes: FlutterStandardTypedData, id: String, width: CGFloat? = nil, height: CGFloat? = nil) {
        let screenScale = UIScreen.main.scale
        var image = UIImage(data: bytes.data, scale: screenScale)
        
        // Resize the image if width and height are provided
        if let width = width, let height = height, let originalImage = image {
            let size = CGSize(width: width, height: height)
            image = UIGraphicsImageRenderer(size: size).image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: size))
            }
        }
        
        self.image = image
        self.iconType = .CUSTOM_FROM_BYTES
        self.id = id
    }
    
    public convenience init() {
        self.init(id: "", iconType: .PIN)
    }
    
    private func scaleImage(image: UIImage, scale: CGFloat) -> UIImage {
        guard let cgImage = image.cgImage else {
            return image
        }
        guard abs(scale - 1) >= 0 else {
            return image
        }
        return UIImage.init(cgImage: cgImage, scale: 4.0, orientation: image.imageOrientation)
    }
    
    static func == (lhs: AnnotationIcon, rhs: AnnotationIcon) -> Bool {
        return lhs.iconType == rhs.iconType && lhs.id == rhs.id && lhs.image == rhs.image
    }
    
    static func != (lhs: AnnotationIcon, rhs: AnnotationIcon) -> Bool {
        return !(lhs == rhs)
    }
}
