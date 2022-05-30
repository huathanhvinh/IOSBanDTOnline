//
//  DanhSachDonHangCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class DanhSachDonHangCell: UITableViewCell {
    @IBOutlet weak var lbMaDonHang: UILabel!
    @IBOutlet weak var lbHoTen: UILabel!
    @IBOutlet weak var lbSDT: UILabel!
    @IBOutlet weak var lbThanhTien: UILabel!
    func setDataDoanhSo(maDonHang:String,hoTen:String,sdt:String,thanhTien:String){
        self.lbMaDonHang.text = "Mã đơn hàng: \(maDonHang)"
        self.lbHoTen.text = "Họ tên: \(hoTen)"
        self.lbSDT.text = "Số điện thoại: \(sdt)"
        self.lbThanhTien.text = "Tổng tiền: \(thanhTien) VNĐ"
    }
}
