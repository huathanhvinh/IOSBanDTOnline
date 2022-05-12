//
//  ViewController.swift
//  StoreABC
//
//  Created by CNTT on 4/20/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import FirebaseDatabase
import UIKit

class ViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        let object : [String : Any] = [
            "Email" : "vinh.huathanh@gmail.com",
            "MatKhau" : "123456"
        ]
        ref.child("Account").childByAutoId().setValue(object)
    }
    //MARK: Phân loại Sản Phẩm
    @IBAction func btnApple(_ sender: UIButton) {
        print("1")
        
    }

    @IBAction func btnXiaomi(_ sender: UIButton) {
        print("2")
    }
    
    @IBAction func btnSamSung(_ sender: UIButton) {
        print("3")
    }
    
    @IBAction func btnOppo(_ sender: UIButton) {
        print("4")
    }
    
    @IBAction func btnAll(_ sender: UIButton) {
        print("5")
    }
    //MARK: Phân loại trang
    
}



