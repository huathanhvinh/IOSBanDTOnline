//
//  Account.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class Account {
    var ID: String
    var TaiKhoan: String
    var MatKhau: String
    var PhanLoai: Int
    
    init(ID: String,TaiKhoan:String,MatKhau:String,PhanLoai:Int) {
        self.ID = ID
        self.TaiKhoan = TaiKhoan
        self.MatKhau = MatKhau
        self.PhanLoai = PhanLoai
    }
}
