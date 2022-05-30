//
//  ChiTietLichSuCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class ChiTietLichSuCell: UITableViewCell {

    @IBOutlet weak var lbTenSanPham: UILabel!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var lbThanhTien: UILabel!
    @IBOutlet weak var imgHinh: UIImageView!
    var id:String = ""
    
    func setDataChiTietLichSuCell(Anh:String,tenSanPham:String,soLuong:Int,thanhTien:Int,id:String){
        
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
