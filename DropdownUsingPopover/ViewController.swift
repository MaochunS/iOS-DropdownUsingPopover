//
//  ViewController.swift
//  DropdownUsingPopover
//
//  Created by Maochun Sun on 2020/7/2.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var theSelView: SelectItemView = {
        let theView = SelectItemView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        //theView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selItemViewTappedAction(_:)))
        theView.isUserInteractionEnabled = true
        theView.addGestureRecognizer(tap)
        
        self.view.addSubview(theView)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                theView.widthAnchor.constraint(equalToConstant: 400),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                theView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(26)),
                theView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(-26)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
        
        return theView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.theSelView.setup(icon:UIImage(named: "btc"), itemTxt:"Test item 1", txtColor: .darkGray, borderColor: .gray, triangleColor: .orange)
    }


    
    @objc func selItemViewTappedAction(_ sender: UITapGestureRecognizer){
        

        self.theSelView.dropdownToggle()
        
        let vc = SelectItemListViewController()
        
        for i in 0..<10{
            vc.theItemArray.append("Item \(i+1)")
        }
        
        
        
        let vcHeight = 300
        let vcWidth = 320
        vc.preferredContentSize = CGSize(width: vcWidth, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.theSelView //self.coinTokenSelView
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        //popoverPresentationController?.sourceRect = CGRect(x: self.theSelView.frame.origin.x + self.theSelView.frame.width / 2 , y: self.theSelView.frame.origin.y, width: 0, height: 0)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .gray
    
        
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate{
    
    @available(iOS 13.0, *)
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController){
        print("popup menu dismissed")
        
        DispatchQueue.main.async {
            self.theSelView.dropdownToggle()
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        
        print("popup menu dismissed")
        
        DispatchQueue.main.async {
            self.theSelView.dropdownToggle()
        }
        
        if let vc = popoverPresentationController.presentedViewController as? SelectItemListViewController, vc.selItemText.count > 0{
            
            DispatchQueue.main.async {
                self.theSelView.setup(icon:UIImage(named: "btc"), itemTxt:vc.selItemText, txtColor: .darkGray, borderColor: .gray, triangleColor: .orange)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
