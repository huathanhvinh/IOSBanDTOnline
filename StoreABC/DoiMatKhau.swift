//
//  DoiMatKhau.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/24/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DoiMatKhau: UIViewController {

    @IBOutlet weak var lbTaiKhoan: UILabel!
    @IBOutlet weak var lbMatKhauHienTai: UITextField!
    @IBOutlet weak var tfMatKhauMoi: UITextField!
    @IBOutlet weak var tfXacNhanMatKhau: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTaiKhoan.text = "Xin Chào: \(ThongTinDangNhap.taiKhoan)"

        // Do any additional setup after loading the view.
    }
    //MARK: Đổi mật khẩu
    @IBAction func btnDoiMatKhau(_ sender: Any) {
        if(self.tfXacNhanMatKhau.text != tfMatKhauMoi.text){
            let alert = UIAlertController(title: "Thông Báo", message: "Xác nhận mật khẩu không đúng !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                default:
                    break
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let ref = Database.database().reference()
            ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
                if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for oSnap in oSnapshot {
                        let hoTen:String = oSnap.childSnapshot(forPath: "HoTen").value as? String ?? ""
                        let sdt:String = oSnap.childSnapshot(forPath: "SoDienThoai").value as? String ?? ""
                        let diaChi:String = oSnap.childSnapshot(forPath: "DiaChi").value as? String ?? ""
                        let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        if(ThongTinDangNhap.taiKhoan == taiKhoan)
                        {
                            self.tfHoTen.text = hoTen
                            self.tfSoDienThoai.text = sdt
                            self.tfDiaChi.text = diaChi
                        }
                    }
                }
            })
        }
    }
    
}
