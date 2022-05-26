//
//  ThongBaoAdmin.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ThongBaoAdmin: UIViewController {

    @IBOutlet weak var lbSoLuongDonHang: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var soLuong = 0
        let ref = Database.database().reference()
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    let TrangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                    if(TrangThai == "False"){
                        soLuong = soLuong + 1
                    }
                }
                self.lbSoLuongDonHang.text = "Đơn hàng chưa xử lý: \(soLuong)"
            }
        })
        soLuong = 0
    }

}
