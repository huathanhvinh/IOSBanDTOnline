//
//  dsGioHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/20/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
class dsGioHang {
    var ID : String
    var TaiKhoan : String
    var idSanPham : String
    var soLuong: Int
    var thanhTien: Int
    init(ID:String, taiKhoan : String, idSanpham:String, soLuong:Int, thanhTien:Int) {
        self.ID = ID
        self.TaiKhoan = taiKhoan
        self.idSanPham = idSanpham
        self.soLuong = soLuong
        self.thanhTien = thanhTien
    }
}
