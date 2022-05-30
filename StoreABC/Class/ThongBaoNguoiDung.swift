//
//  ThongBaoNguoiDung.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
class ThongBaoNguoiDung {
    var ID:String
    var IdDonHang:String
    var LiDo:String
    var TaiKhoan:String
    var TinhTrang:String
    var TrangThai:String
    init(id:String,idDH:String,liDo:String,taiKhoan:String,tinhTrang:String,trangThai:String) {
        self.ID = id
        self.IdDonHang = idDH
        self.LiDo = liDo
        self.TaiKhoan = taiKhoan
        self.TinhTrang = tinhTrang
        self.TrangThai = trangThai
    }

}
