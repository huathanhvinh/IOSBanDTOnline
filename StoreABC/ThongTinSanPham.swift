//
//  ThongTinSanPham.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/14/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ThongTinSanPham: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Khai báo
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var tfHSX: UITextField!
    @IBOutlet weak var tfTenSanPham: UITextField!
    @IBOutlet weak var tfManHinh: UITextField!
    @IBOutlet weak var tfHDH: UITextField!
    @IBOutlet weak var tfCamSau: UITextField!
    @IBOutlet weak var tfRam: UITextField!
    @IBOutlet weak var tfRom: UITextField!
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var tfGiaBan: UITextField!
    var idSanPham = "-N2-QdxfJp5SZzZXDYtS"
    var selectImage = 0
    //MARK: Main
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
                    if(ID == self.idSanPham)
                    {
                        //ảnh 1
                        let data1 = Data(base64Encoded: Anh1,
                                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        if let data1 = data1{
                            self.imageView1.image = UIImage(data: data1)
                            
                        }
                        //ảnh 2
                        let data2 = Data(base64Encoded: Anh2,
                                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        if let data2 = data2{
                            self.imageView2.image = UIImage(data: data2)
                            
                        }
                        //ảnh 3
                        let data3 = Data(base64Encoded: Anh3,
                                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        if let data3 = data3{
                            self.imageView3.image = UIImage(data: data3)
                            
                        }
                        //ảnh 4
                        let data4 = Data(base64Encoded: Anh4,
                                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        if let data4 = data4{
                            self.imageView4.image = UIImage(data: data4)
                            
                        }
                        //thuộc tính khác
                        self.tfHSX.text = HSX
                        self.tfTenSanPham.text = TenSanPham
                        self.tfManHinh.text = ManHinh
                        self.tfHDH.text = HDH
                        self.tfCamSau.text = CamSau
                        self.tfRam.text = Ram
                        self.tfRom.text = Rom
                        self.tfPin.text = Pin
                        self.tfGiaBan.text = Gia
                        return
                        
                    }
                }
            }
        })
        
    }
    //MARK: Thêm Ảnh chính
    @IBAction func ThemAnhChinh(_ sender: Any) {
        selectImage = 0
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Thêm Ảnh phụ 1
    @IBAction func ThemAnhPhu1(_ sender: Any) {
        selectImage = 1
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Thêm Ảnh Phụ 2
    @IBAction func ThemAnhPhu2(_ sender: Any) {
        selectImage = 2
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Thêm Ảnh Phụ 3
    @IBAction func ThemAnhPhu3(_ sender: Any) {
        selectImage = 3
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Cấu hình mở photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        if(selectImage == 0){
            imageView1.image = image
        }else if(selectImage == 1)
        {
            imageView2.image = image
        }else if(selectImage == 2)
        {
            imageView3.image = image
        }else if(selectImage == 3)
        {
            imageView4.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Nút Xóa Sản Phẩm
    @IBAction func XoaSanPham(_ sender: Any) {
        //Thông Báo
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn có muốn xóa không ?", preferredStyle: .alert)
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
                //MARK: Xóa Sản Phẩm
                let ref = Database.database().reference()
                ref.child("DanhSachSanPham").child(self.idSanPham).removeValue()
                //MARK: thông báo xóa thành công
                let alert = UIAlertController(title: "Thông Báo", message: "Xóa Thành Công ?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OKE", style: .default, handler: { action in
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
                //MARK: Code Chuyển màn hình tại đây !!!
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
    
    //MARK: Nút Lưu Sản Phẩm
    @IBAction func btnLuuSanPham(_ sender: Any) {
    }
    
}
