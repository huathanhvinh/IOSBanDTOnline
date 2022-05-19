//
//  SanPhamCell.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/19/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class SanPhamCell: UITableViewCell {
    
    
    @IBOutlet weak var tenSanPham: UILabel!
    @IBOutlet weak var HSX: UILabel!
    @IBOutlet weak var giaBan: UILabel!
    @IBOutlet weak var imgHinh: UIImageView!
    var id:String = ""
    
    func setDataCell(ten:String,gia:String,hsx:String,anh:String,id:String){
        self.tenSanPham.text = ten
        self.HSX.text = "HSX: \(hsx)"
        self.giaBan.text = "Giá: \(gia) VND"
        let data1 = Data(base64Encoded: anh,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        if let data1 = data1{
            self.imgHinh.image = UIImage(data: data1)
        }
        self.id = id
    }
    
}
