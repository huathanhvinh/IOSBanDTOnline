//
//  KhachHangMainMenu.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class KhachHangMainMenu: UIViewController {
    @IBOutlet weak var btnThongBao: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: load thông báo
        ThongBaoMuaHang()
        
    }
    //MARK: nút đăng xuất
    @IBAction func btnDangXuat(_ sender: UIButton) {
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
    //MARK: Nút giỏ hàng
    @IBAction func btnGioHang(_ sender: UIButton) {
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhGioHang") as! GioHang
        present(scr, animated: true, completion: nil)
    }
    //MARK: func Chuyển màn hình đến màn hình trang chủ
    func DiDenTrangChu(){
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhTrangChu") as! ViewController
        present(scr, animated: true, completion: nil)
    }
    //MARK: thông báo mua hàng
    func ThongBaoMuaHang() {
        let ref = Database.database().reference()
        ref.child("ThongBaoNguoiDung").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for _ in oSnapshot {
                    var soLuong = 0
                    for oSnap in oSnapshot {
                        let trangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                        let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        if(trangThai == "False" && taiKhoan == ThongTinDangNhap.taiKhoan){
                            soLuong = soLuong + 1
                        }
                    }
                    self.btnThongBao.setTitle("Thông Báo (\(soLuong))", for: .normal)
                }
            }
        })
    }
    //MARK: nút mua hàng
    @IBAction func btnMuaHang(_ sender: Any) {
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhTrangChu") as! ViewController
        present(scr, animated: true, completion: nil)
    }
    
}
