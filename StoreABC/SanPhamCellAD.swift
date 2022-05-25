//
//  SanPhamCellAD.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/24/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class SanPhamCellAD: UITableViewCell {

    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var lbTen: UILabel!
    @IBOutlet weak var lbHSX: UILabel!
    @IBOutlet weak var lbGia: UILabel!
    var id:String = ""
    
    func setDataCell(ten:String,gia:String,hsx:String,anh:String,id:String){
        self.lbTen.text = ten
        self.lbHSX.text = "HSX: \(hsx)"
        self.lbGia.text = "Giá: \(gia) VND"
        let data1 = Data(base64Encoded: anh,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        if let data1 = data1{
            self.imgHinh.image = UIImage(data: data1)
        }
        self.id = id
    }
}
