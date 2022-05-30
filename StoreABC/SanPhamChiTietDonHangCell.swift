//
//  SanPhamChiTietDonHangCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class SanPhamChiTietDonHangCell: UITableViewCell {
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var lbTenSanPham: UILabel!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var lbThanhTien: UILabel!
    var id:String = ""
    
    func setDataSanPhamDonHangCell(Anh:String,tenSanPham:String,soLuong:Int,thanhTien:Int,id:String){
        
        self.lbTenSanPham.text = tenSanPham
        self.lbSoLuong.text = "SL: \(soLuong)"
        self.lbThanhTien.text = "TTiền: \(thanhTien) VNĐ"
        let data1 = Data(base64Encoded: Anh,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        if let data1 = data1{
            self.imgHinh.image = UIImage(data: data1)
        }
        self.id = id
    }

    
}
