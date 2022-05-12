//
//  DangNhap.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DangNhap: UIViewController {
    //MARK: Khai báo biến
    @IBOutlet weak var tfTaiKhoan: UITextField!
    @IBOutlet weak var tfMatKhau: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    //MARK: Nút Đăng Nhập
    @IBAction func btnDangNhap(_ sender: UIButton) {
        if(tfTaiKhoan.text == "" || tfMatKhau.text == "")
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
            let ref = Database.database().reference()
            ref.child("Account").observe(.value, with: {(snapshot) in
                if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for oSnap in oSnapshot {
                        let tk:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        let mk:String = oSnap.childSnapshot(forPath: "MatKhau").value as? String ?? ""
                        let pl:Int = oSnap.childSnapshot(forPath: "PhanLoai").value as? Int ?? 2
                        if(self.tfTaiKhoan.text == tk && self.tfMatKhau.text == mk)
                        {
                            ThongTinDangNhap.taiKhoan = tk
                            ThongTinDangNhap.phanLoai = pl
                        }
                    }
                    //MARK: Chuyển màn hình đăng nhập
                    if(ThongTinDangNhap.phanLoai != 0)
                    {
                        
                    }else
                    {
                        let alert = UIAlertController(title: "Thông Báo", message: "Tài khoản hoặc mật khẩu không đúng !", preferredStyle: .alert)
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
            })
        }
    }
    //MARK: Nút Quên Mật Khẩu
    @IBAction func btnQuenMatKhau(_ sender: UIButton) {
        let alert = UIAlertController(title: "Thông Báo", message: "Chức năng chưa xây dựng vì hơi khó !", preferredStyle: .alert)
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
