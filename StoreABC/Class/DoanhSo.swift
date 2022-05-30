//
//  DoanhSo.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
class DoanhSo{
    
    var GiaTri:String
    var ID:String
    var IdDonHang:String
    var TaiKhoan:String
    var TinhTrang:String
    init(GiaTri:String, ID:String, IdDonHang:String, TaiKhoan:String, TinhTrang:String) {
        self.GiaTri = GiaTri
        self.ID = ID
        self.IdDonHang = IdDonHang
        self.TaiKhoan = TaiKhoan
        self.TinhTrang = TinhTrang
    }

}
