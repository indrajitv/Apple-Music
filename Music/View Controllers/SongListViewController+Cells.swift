//
//  SongListViewController+Cells.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 21/12/20.
//

import UIKit

/// Cell which show top song details.
class TableViewCellSongDetails: BaseCellForTV {
    
    //MARK: Class properties
    
    /// Datasource item.
    var item:SongViewModel? {
        didSet{
            
            self.labelSongDetails.attributedText = item?.listDetails
            self.labelDownLoading.text = item?.downloadStatus.getDisplayValue()
            self.labelDownLoading.text = item?.downloadStatus.getDisplayValue()
            setThumbImage()
            
            item?.downloadStatusChanged = {[weak self] (status) in
                self?.labelDownLoading.text = status.getDisplayValue()
            }
            
        }
    }

    /// UI: Imageview to show song icon.
    lazy var imageViewSongIcon:URLImageView={
        let imageView = URLImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    /// UI: Label to show song details on cell.
    let labelSongDetails:UILabel={
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    /// UI: Label  to show downloading.
    let labelDownLoading:UILabel={
        let label = UILabel()
        label.font = AppFont.get(font: .regular, size: .h7)
        label.textColor = AppColor.theme.color1
        return label
    }()
    
    //MARK: Class methods
    
    /// Sets view on screen and assigns autolayout constraints.
    override func setUpViews() {
        
        super.setUpViews()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubviews(views: [imageViewSongIcon,labelSongDetails,labelDownLoading])
        
        let padding:CGFloat = Helper.isPad ? 20 : 10
        let imageSize:CGFloat = Helper.isPad ? 100 : 70
        
        imageViewSongIcon.setHeightAndWidth(height: imageSize, width: imageSize)
        imageViewSongIcon.setCenterY()
        imageViewSongIcon.setLeft(with: leftAnchor, constant: padding)
        
        labelSongDetails.setAnchors(top: topAnchor, bottom: bottomAnchor, left: imageViewSongIcon.rightAnchor, right: rightAnchor, topConstant: padding, bottomConstant: -padding, leftConstant: padding, rightConstant: -padding)
        labelSongDetails.heightAnchor.constraint(greaterThanOrEqualToConstant: imageSize).isActive = true
        
        labelDownLoading.setBottom(with: bottomAnchor, constant: 0)
        labelDownLoading.setRight(with: rightAnchor, constant: Helper.isPad ? -10 : -5)
  
    }
    
    /// Loads thumb for song.
    func setThumbImage(){
        if let imageIcon = item?.cachedIcon,
           let image = UIImage(data: imageIcon){
            
            self.imageViewSongIcon.image = image
            
        }else if let url = item?.thumbURL {
            
            self.imageViewSongIcon.loadImage(from: url) { [weak self] (loadedImage) in
                self?.imageViewSongIcon.image = loadedImage
                self?.imageViewSongIcon.contentMode = .scaleAspectFill
                CoreDBManager.updateSongDetails(id: self?.item?.id ?? "", data: nil, status: self?.item?.downloadStatus ?? .none, cachedIcon: loadedImage?.pngData())
            }
            
        }else {
            self.imageViewSongIcon.showPlaceholder()
        }
    }
}
