//
//  ChiTietHoaDonCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class ChiTietHoaDonCell: UITableViewCell {
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var imgTenSanPham: UILabel!
    @IBOutlet weak var imgSoLuong: UILabel!
    @IBOutlet weak var imgThanhTien: UILabel!
    
    var id:String = ""
    
    func setDataSanPhamDonHangCell(Anh:String,tenSanPham:String,soLuong:Int,thanhTien:Int,id:String){
        
        self.imgTenSanPham.text = tenSanPham
        self.imgSoLuong.text = "SL: \(soLuong)"
        self.imgThanhTien.text = "TTiền: \(thanhTien) VNĐ"
        let data1 = Data(base64Encoded: Anh,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        if let data1 = data1{
            self.imgHinh.image = UIImage(data: data1)
        }
        self.id = id
    }
}
