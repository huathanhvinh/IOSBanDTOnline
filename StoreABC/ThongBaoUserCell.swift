//
//  ThongBaoUserCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class ThongBaoUserCell: UITableViewCell {
    @IBOutlet weak var lbMaDonHang: UILabel!
    @IBOutlet weak var lbGiaTri: UILabel!
    @IBOutlet weak var lbTinhTrang: UILabel!
    func setDataThongBaoUser(maDH:String,giaTri:String,tinhTrang:String) {
        self.lbMaDonHang.text = maDH
        self.lbGiaTri.text = giaTri
        self.lbTinhTrang.text = tinhTrang
    }
}
