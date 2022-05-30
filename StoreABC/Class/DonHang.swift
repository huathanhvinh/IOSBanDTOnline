//
//  DonHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
class DonHang {
    var ID : String
    var TaiKhoan : String
    var TongTien : String
    var TrangThai: String
    init(ID:String, taiKhoan : String, TongTien:String, TrangThai:String) {
        self.ID = ID
        self.TaiKhoan = taiKhoan
        self.TongTien = TongTien
        self.TrangThai = TrangThai
    }
}
