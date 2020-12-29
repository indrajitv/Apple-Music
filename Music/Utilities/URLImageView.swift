//
//  URLImageView.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// Cache to hold image data temporary.
private let AppImageCache = NSCache<NSString, NSData>()

/// Custom class to load image from URL.
class URLImageView:UIImageView {
    
    //MARK: Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        layer.borderColor = AppColor.theme.color3.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Class methods
    
    /// Loads image from URL.
    func loadImage(from url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {
        
        showPlaceholder()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            if let data = AppImageCache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }

            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }

            AppImageCache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
    }
    
    /// To show placeholder image.
    func showPlaceholder(){
        contentMode = .scaleAspectFit
        self.image = UIImage(named: "placeholder")
    }
}
