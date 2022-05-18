//
//  DangKiTaiKhoan.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import FirebaseDatabase
import UIKit

class DangKiTaiKhoan: UIViewController {
    
    @IBOutlet weak var lbThongBao: UILabel!
    @IBOutlet weak var tfTaiKhoan: UITextField!
    @IBOutlet weak var tkMatKhau: UITextField!
    @IBOutlet weak var tfXacNhanMatKhau: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnDangKi(_ sender: UIButton) {
        //MARK: Kiểm tra các trường trong textfield
        if(tfTaiKhoan.text == "" || tkMatKhau.text == "" || tfXacNhanMatKhau.text == "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Nội dung không được để trống", preferredStyle: .alert)
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
        }else if(tkMatKhau.text != tfXacNhanMatKhau.text)
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Xác nhận mật khẩu không chính xác", preferredStyle: .alert)
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
        }else if(lbThongBao.text != "")
        {
            let alert = UIAlertController(title: "Thông Báo", message: "Tài khoản đã tồn tại", preferredStyle: .alert)
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
            //MARK: thêm accout vào firebase
            let ref = Database.database().reference()
            let idAccount:String = ref.child("Account").childByAutoId().key ?? "Lỗi"
            let idThongTinCaNhan:String = ref.child("ThongTinCaNhan").childByAutoId().key ?? "Lỗi"
            let object : [String : Any] = [
                "TaiKhoan" : "\(tfTaiKhoan.text ?? "loi")",
                "MatKhau" : "\(tkMatKhau.text ?? "loi")",
                "PhanLoai" : 2,
                "ID" : idAccount
            ]
            ref.child("Account").child(idAccount).setValue(object)
            //MARK: thêm thông tin vào firebase
            let object1 : [String : Any] = [
                "TaiKhoan" : "\(tfTaiKhoan.text ?? "loi")",
                "HoTen" : "Trống",
                "SoDienThoai" : "Trống",
                "DiaChi" : "Trống",
                "ID" : idThongTinCaNhan
            ]
            ref.child("ThongTinCaNhan").child(idThongTinCaNhan).setValue(object1)
            //MARK: làm mới các trường văn bản
            tfTaiKhoan.text = ""
            tkMatKhau.text = ""
            tfXacNhanMatKhau.text = ""
            
            //thông báo
            let alert = UIAlertController(title: "Thông Báo", message: "Đăng kí thành công", preferredStyle: .alert)
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
    
    //MARK: kiểm tra tài khoản đã tồn tại hay chưa
    @IBAction func KiemTraAccount(_ sender: Any) {
        let ref = Database.database().reference()
        ref.child("Account").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //let data = oSnap as? Account
                    if let taiKhoan = oSnap.childSnapshot(forPath: "TaiKhoan").value{
                        if(self.tfTaiKhoan.text == taiKhoan as? String)
                        {
                            self.lbThongBao.text = "Tài khoản đã tồn tại"
                            break
                        }else
                        {
                            self.lbThongBao.text = ""
                        }
                    }
                }
            }
        })
    }
    //MARK: Quay lại màn hình đăng nhập
    @IBAction func btnQuayLaiManHinhDangNhap(_ sender: Any) {
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhDangNhap") as! DangNhap
        present(scr, animated: true, completion: nil)
    }
}
