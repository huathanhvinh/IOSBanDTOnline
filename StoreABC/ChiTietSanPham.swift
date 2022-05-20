//
//  ChiTietSanPham.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/17/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//
import FirebaseDatabase
import UIKit

class ChiTietSanPham: UIViewController {
    //MARK: Khai báo
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lbTenSP: UILabel!
    @IBOutlet weak var lbHSX: UILabel!
    @IBOutlet weak var lbHDH: UILabel!
    @IBOutlet weak var lbManHinh: UILabel!
    @IBOutlet weak var lbCamSau: UILabel!
    @IBOutlet weak var lbRam: UILabel!
    @IBOutlet weak var lbRom: UILabel!
    @IBOutlet weak var lbPin: UILabel!
    @IBOutlet weak var lbGiaCa: UILabel!
    @IBOutlet weak var img2: UIButton!
    @IBOutlet weak var img3: UIButton!
    @IBOutlet weak var img4: UIButton!
    @IBOutlet weak var tfSoLuongMua: UITextField!
    
    var id = idSanPham
    var data2:Data!
    var data3:Data!
    var data4:Data!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: lấy thông tin sản phẩm
        let ref = Database.database().reference()
        ref.child("DanhSachSanPham").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let Anh1:String = oSnap.childSnapshot(forPath: "Anh1").value as? String ?? ""
                    let Anh2:String = oSnap.childSnapshot(forPath: "Anh2").value as? String ?? ""
                    let Anh3:String = oSnap.childSnapshot(forPath: "Anh3").value as? String ?? ""
                    let Anh4:String = oSnap.childSnapshot(forPath: "Anh4").value as? String ?? ""
                    let CamSau:String = oSnap.childSnapshot(forPath: "CamSau").value as? String ?? ""
                    let Gia:String = oSnap.childSnapshot(forPath: "Gia").value as? String ?? ""
                    let HDH:String = oSnap.childSnapshot(forPath: "HDH").value as? String ?? ""
                    let HSX:String = oSnap.childSnapshot(forPath: "HSX").value as? String ?? ""
                    let ManHinh:String = oSnap.childSnapshot(forPath: "ManHinh").value as? String ?? ""
                    let Pin:String = oSnap.childSnapshot(forPath: "Pin").value as? String ?? ""
                    let Ram:String = oSnap.childSnapshot(forPath: "Ram").value as? String ?? ""
                    let Rom:String = oSnap.childSnapshot(forPath: "Rom").value as? String ?? ""
                    let TenSanPham:String = oSnap.childSnapshot(forPath: "TenSanPham").value as? String ?? ""
                    if(ID == self.id)
                    {
                        //ảnh 1
                        let data1 = Data(base64Encoded: Anh1,
                                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        if let data1 = data1{
                            self.img1.image = UIImage(data: data1)
                            
                        }
                        //ảnh 2
                        self.data2 = Data(base64Encoded: Anh2,
                                          options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                        self.img2.setBackgroundImage(UIImage(data: self.data2!), for: .normal)
                        //ảnh 3
                        self.data3 = Data(base64Encoded: Anh3,
                                          options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                        self.img3.setBackgroundImage(UIImage(data: self.data3!), for: .normal)
                        //ảnh 4
                        self.data4 = Data(base64Encoded: Anh4,
                                          options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                        self.img4.setBackgroundImage(UIImage(data: self.data4!), for: .normal)
                        //thuộc tính khác
                        self.lbTenSP.text = TenSanPham
                        self.lbHSX.text = HSX
                        self.lbHDH.text = HDH
                        self.lbManHinh.text = ManHinh
                        self.lbCamSau.text = CamSau
                        self.lbRam.text = Ram
                        self.lbRom.text = Rom
                        self.lbPin.text = Pin
                        self.lbGiaCa.text = Gia
                        return
                    }
                }
            }
        })
        
    }
    //MARK:Đổi hình 1
    @IBAction func DoiHinh1(_ sender: UIButton) {
        img1.image = UIImage(data: data2)
    }
    //MARK:Đổi hình 2
    @IBAction func DoiHinh2(_ sender: UIButton) {
        img1.image = UIImage(data: data3)
    }
    //MARK:Đổi hình 3
    @IBAction func DoiHinh3(_ sender: UIButton) {
        img1.image = UIImage(data: data4)
    }
    //MARK: Thêm Vào Giỏ Hàng
    @IBAction func btnThemVaoGioHang(_ sender: Any) {
        if(ThongTinDangNhap.taiKhoan == ""){
            let alert = UIAlertController(title: "Thông Báo", message: "Bạn cần phải đăng nhập !", preferredStyle: .alert)
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
            let gia = Int(lbGiaCa.text!)
            let soLuong = Int(tfSoLuongMua.text!)
            let ThanhTien = gia!*soLuong!
            //MARK: Thêm vào firebase
            let ref = Database.database().reference()
            let idGioHang:String = ref.child("GioHang").childByAutoId().key ?? "Lỗi"
            let object : [String : Any] = [
                "TaiKhoan" : ThongTinDangNhap.taiKhoan,
                "maSanPham" : idSanPham,
                "soLuong" : soLuong as Any,
                "thanhTien" : ThanhTien,
                "ID" : idGioHang,
                ]
            //MARK: thông báo thêm vào giỏ hàng thành công
            ref.child("GioHang").child(idGioHang).setValue(object)
            let alert = UIAlertController(title: "Thông Báo", message: "Thêm thành công !", preferredStyle: .alert)
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
