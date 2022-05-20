//
//  KhachHangMainMenu.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/12/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class KhachHangMainMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
