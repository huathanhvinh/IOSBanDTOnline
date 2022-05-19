//
//  SanPham.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/18/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
class SanPham {
    var ID : String
    var HDH : String
    var tenSanPham : String
    var HSX : String
    var ManHinh : String
    var CamSau : String
    var Ram : String
    var Rom : String
    var Pin : String
    var GiaCa : String
    var Anh1 : String
    var Anh2 : String
    var Anh3 : String
    var Anh4 : String
    
    init(ID : String, HDH : String, tenSanPham : String, HSX : String, ManHinh : String, CamSau : String, Ram : String, Rom : String, Pin : String, GiaCa : String, Anh1 : String, Anh2 : String, Anh3 : String, Anh4 : String) {
        self.ID = ID
        self.HDH = HDH
        self.tenSanPham = tenSanPham
        self.HSX = HSX
        self.ManHinh = ManHinh
        self.CamSau = CamSau
        self.Ram = Ram
        self.Rom = Rom
        self.Pin = Pin
        self.GiaCa = GiaCa
        self.Anh1 = Anh1
        self.Anh2 = Anh2
        self.Anh3 = Anh3
        self.Anh4 = Anh4
    }
    
}
