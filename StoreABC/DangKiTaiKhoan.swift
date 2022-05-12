//
//  DangKiTaiKhoan.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import FirebaseDatabase
import UIKit

class DangKiTaiKhoan: UIViewController {

    @IBOutlet weak var lbThongBao: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = Database.database().reference()
        let object : [String : Any] = [
            "Email" : "vinh.huathanh@gmail.com",
            "MatKhau" : "123456"
        ]
        ref.child("Account").childByAutoId().setValue(object)
    }

    @IBAction func btnDangKi(_ sender: UIButton) {
    }
    
}
