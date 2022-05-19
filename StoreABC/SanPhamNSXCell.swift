//
//  SanPhamNSXCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/20/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class SanPhamNSXCell: UITableViewCell {
    
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var lbTenSanPham: UILabel!
    @IBOutlet weak var lbGia: UILabel!
    var id:String = ""
    
    func setDataCell(ten:String,gia:String,anh:String,id:String){
        self.lbTenSanPham.text = ten
        self.lbGia.text = "Giá: \(gia) VND"
        let data1 = Data(base64Encoded: anh,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        if let data1 = data1{
            self.imgHinh.image = UIImage(data: data1)
        }
        self.id = id
    }
}
