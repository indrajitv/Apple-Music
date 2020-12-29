//
//  ViewAnchors.swift
//  Indrajit
//
//  Created by Indrajit Chavda on 20/12/20.
//

import UIKit

/// This utility extension allows to layout view programatically.
extension UIView{
    
    func addSubviews(views:[UIView]){
        views.forEach { (_view) in
            addSubview(_view)
        }
    }
    
    func setAnchors(top:NSLayoutYAxisAnchor? = nil,bottom:NSLayoutYAxisAnchor? = nil,left:NSLayoutXAxisAnchor? = nil,right:NSLayoutXAxisAnchor? = nil,topConstant:CGFloat = 0,bottomConstant:CGFloat = 0,leftConstant:CGFloat = 0,rightConstant:CGFloat = 0){
        if let value = left{
            setLeft(with: value, constant: leftConstant)
        }
        if let value = right{
            setRight(with: value, constant: rightConstant)
        }
        if let value = top{
            setTop(with: value, constant: topConstant)
        }
        if let value = bottom{
            setBottom(with: value, constant: bottomConstant)
        }
    }
    
    func setAnchors(top:NSLayoutYAxisAnchor? = nil,bottom:NSLayoutYAxisAnchor? = nil,left:NSLayoutXAxisAnchor? = nil,right:NSLayoutXAxisAnchor? = nil){
        if let value = left{
            setLeft(with: value, constant: 0)
        }
        if let value = right{
            setRight(with: value, constant: 0)
        }
        if let value = top{
            setTop(with: value, constant: 0)
        }
        if let value = bottom{
            setBottom(with: value, constant: 0)
        }
    }
    
    func setHeight(height:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setHeight(height:NSLayoutDimension){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: height, multiplier: 1).isActive = true
    }
    
    func setWidth(width:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidth(width:NSLayoutDimension){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: width, multiplier: 1).isActive = true
    }
    
    func setHeightAndWidth(height:CGFloat,width:CGFloat){
        setHeight(height: height)
        setWidth(width: width)
    }
    
    func setRight(with:NSLayoutXAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: with).isActive = true
    }
    
    func setRight(with:NSLayoutXAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setLeft(with:NSLayoutXAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: with).isActive = true
    }
    
    func setLeft(with:NSLayoutXAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setTop(with:NSLayoutYAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: with).isActive = true
    }
    
    func setTop(with:NSLayoutYAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setBottom(with:NSLayoutYAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with).isActive = true
    }
    
    func setBottom(with:NSLayoutYAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    func setFullOnSuperView(){
        if let superViewOfThis = superview{
            self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor)
            self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor)
            self.setLeft(with: superViewOfThis.safeAreaLayoutGuide.leftAnchor)
            self.setRight(with: superViewOfThis.safeAreaLayoutGuide.rightAnchor)
        }
    }
    
    func setFullOnSuperView(withTopBottomSpacing:CGFloat){
        if let superViewOfThis = superview{
            self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor,constant: withTopBottomSpacing)
            self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor,constant: -withTopBottomSpacing)
            self.setLeft(with: superViewOfThis.safeAreaLayoutGuide.leftAnchor)
            self.setRight(with: superViewOfThis.safeAreaLayoutGuide.rightAnchor)
        }
    }
    
    func setFullOnSuperView(withLeftRightSpacing:CGFloat){
        if let superViewOfThis = superview{
            self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor)
            self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor)
            self.setLeft(with: superViewOfThis.safeAreaLayoutGuide.leftAnchor,constant: withLeftRightSpacing)
            self.setRight(with: superViewOfThis.safeAreaLayoutGuide.rightAnchor,constant: -withLeftRightSpacing)
        }
    }
    
    func setFullOnSuperView(withSpacing:CGFloat){
        if let superViewOfThis = superview{
            self.setTop(with: superViewOfThis.safeAreaLayoutGuide.topAnchor,constant: withSpacing)
            self.setBottom(with: superViewOfThis.safeAreaLayoutGuide.bottomAnchor,constant: -withSpacing)
            self.setLeft(with: superViewOfThis.safeAreaLayoutGuide.leftAnchor,constant: withSpacing)
            self.setRight(with: superViewOfThis.safeAreaLayoutGuide.rightAnchor,constant: -withSpacing)
        }
    }
    
    func setCenterY(){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerYAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        }
    }
    
    func setCenterY(constant:CGFloat){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerYAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerYAnchor, constant: constant).isActive = true
        }
    }
    
    func setCenterX(){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        }
    }
    
    func setCenterX(constant:CGFloat){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(equalTo: superViewOfThis.safeAreaLayoutGuide.centerXAnchor, constant: constant).isActive = true
        }
    }
    
    func setCenterXto(xAnachor:NSLayoutXAxisAnchor,constant:CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: xAnachor, constant: constant).isActive = true
    }
    
    func setCenterYto(yAnchor:NSLayoutYAxisAnchor,constant:CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: yAnchor, constant: constant).isActive = true
    }
    
    func setCenter(){
        setCenterX()
        setCenterY()
    }
    
    func setCenter(xConstant:CGFloat,yConstant:CGFloat){
        setCenterX(constant: xConstant)
        setCenterY(constant: yConstant)
    }
    
}
