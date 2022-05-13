//
//  ThongTinCaNhan.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//
import FirebaseDatabase
import UIKit

class ThongTinCaNhan: UIViewController {
    @IBOutlet weak var tfHoTen: UITextField!
    @IBOutlet weak var tfSoDienThoai: UITextField!
    @IBOutlet weak var tfDiaChi: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Load thông tin từ Firebase
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
    //MARK: Nút Lưu thông tin
    @IBAction func btnLuu(_ sender: UIButton) {
        if(tfHoTen.text == "" || tfSoDienThoai.text == "" || tfDiaChi.text == "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Thông tin không được bỏ trống !", preferredStyle: .alert)
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
        }else
        {
            //MARK: lưu thông tin
            let ref = Database.database().reference()
            ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
                if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for oSnap in oSnapshot {
                        let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                        if(ThongTinDangNhap.taiKhoan == taiKhoan)
                        {
                            let object : [String : String] = [
                                "TaiKhoan" : "\(ThongTinDangNhap.taiKhoan)",
                                "HoTen" : "\(self.tfHoTen.text ?? "")",
                                "SoDienThoai" : "\(self.tfSoDienThoai.text ?? "")",
                                "DiaChi" : "\(self.tfDiaChi.text ?? "")",
                                "ID" : ID
                                
                            ]
                            ref.child("ThongTinCaNhan").child(ID).setValue(object)
                        }
                    }
                }
            })
            let alert = UIAlertController(title: "Thông Báo", message: "Lưu Thành Công !", preferredStyle: .alert)
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
        }
    }
}
