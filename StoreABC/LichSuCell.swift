//
//  LichSuCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class LichSuCell: UITableViewCell {
    @IBOutlet weak var lbMaDonHang: UILabel!
    @IBOutlet weak var lbThanhTien: UILabel!
    var id:String = ""
    
    func setDataLichSuCell(id:String,maDH:String,thanhTien:String){
        self.id = id
        self.lbMaDonHang.text = "Mã ĐH: \(maDH)"
        self.lbThanhTien.text = "Tổng tiền: \(thanhTien)"
    }

}
