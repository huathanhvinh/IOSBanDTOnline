//
//  AdminMainMenu.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdminMainMenu: UIViewController {

    @IBOutlet weak var btnThongBao: UIButton!
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
                self.btnThongBao.setTitle("Thông Báo (\(soLuong))", for: .normal)
            }
        })
        soLuong = 0
    }
    //MARK: Nút Đăng xuất
    @IBAction func btnDangXuat(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn có muốn đăng xuất không !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { action in
            switch action.style{
            case .default:
                ThongTinDangNhap.taiKhoan = ""
                ThongTinDangNhap.phanLoai = 0
                self.DiDenTrangChu()
                
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
    //func đăng xuất
    func DiDenTrangChu(){
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhTrangChu") as! ViewController
        present(scr, animated: true, completion: nil)
    }
}
