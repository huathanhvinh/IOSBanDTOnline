//
//  DonHangCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class DonHangCell: UITableViewCell {

    @IBOutlet weak var lbHoTenKhachHang: UILabel!
    @IBOutlet weak var lbSDT: UILabel!
    @IBOutlet weak var lbGiaTriDonHang: UILabel!
    var id:String = ""
    func setDaTaDonHang(hoTen:String,sdt:String,giaTri:String,id:String) {
        self.lbHoTenKhachHang.text = "Họ Tên KH: \(hoTen)"
        self.lbSDT.text = "Số điện thoại: \(sdt)"
        self.lbGiaTriDonHang.text = "Giá trị đơn hàng: \(giaTri) VNĐ"
        self.id = id
    }
    
}
