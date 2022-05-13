//
//  ThemSanPham.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/13/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ThemSanPham: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tfGia: UITextField!
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var tfRom: UITextField!
    @IBOutlet weak var tfRam: UITextField!
    @IBOutlet weak var tfCamSau: UITextField!
    @IBOutlet weak var tfHeDieuHanh: UITextField!
    @IBOutlet weak var tfManHinh: UITextField!
    @IBOutlet weak var tfTenSanPham: UITextField!
    @IBOutlet weak var tfHSX: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    var selectImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Thêm ảnh chính
    @IBAction func ThemAnhChinh(_ sender: UIButton) {
        selectImage = 0
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        if(selectImage == 0){
            imgView.image = image
        }else if(selectImage == 1)
        {
            imgView1.image = image
        }else if(selectImage == 2)
        {
            imgView2.image = image
        }else if(selectImage == 3)
        {
            imgView3.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Thêm ảnh phụ 1
    @IBAction func ThemAnhPhu1(_ sender: Any) {
        selectImage = 1
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Thêm ảnh phụ 2
    
    @IBAction func ThemAnhPhu2(_ sender: Any) {
        selectImage = 2
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: Thêm ảnh phụ 3
    
    @IBAction func ThemAnhPhu3(_ sender: Any) {
        selectImage = 3
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
    }
    //MARK: thêm sản phẩm
    @IBAction func btnThemSanPham(_ sender: UIButton) {
        let ref = Database.database().reference()
        //MARK: Tạo ID cho Sản Phẩm
        let idSanPham:String = ref.child("DanhSachSanPham").childByAutoId().key ?? "Lỗi"
        //MARK: Convert ảnh sang Base 64
        let imgData1 = imgView.image?.pngData()!
        let imgConvert1 = imgData1!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        // 2
        let imgData2 = imgView1.image?.pngData()!
        let imgConvert2 = imgData2!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        // 3
        let imgData3 = imgView2.image?.pngData()!
        let imgConvert3 = imgData3!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        // 4
        let imgData4 = imgView3.image?.pngData()!
        let imgConvert4 = imgData4!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        //MARK: thêm thông tin vào firebase
        let object : [String : Any] = [
            "ID" : idSanPham,
            "HSX" : tfHSX.text ?? "",
            "TenSanPham" : tfTenSanPham.text ?? "",
            "ManHinh" : tfManHinh.text ?? "",
            "HDH" : tfHeDieuHanh.text ?? "",
            "CamSau" : tfCamSau.text ?? "",
            "Ram" : tfRam.text ?? "",
            "Rom" : tfRom.text ?? "",
            "Pin" : tfPin.text ?? "",
            "Gia" : tfGia.text ?? "",
            "Anh1" : imgConvert1,
            "Anh2" : imgConvert2,
            "Anh3" : imgConvert3,
            "Anh4" : imgConvert4,
            
        ]
        ref.child("DanhSachSanPham").child(idSanPham).setValue(object)
        //MARK: làm mới các trường văn bản
        tfHSX.text = ""
        tfTenSanPham.text = ""
        tfManHinh.text = ""
        tfHeDieuHanh.text = ""
        tfCamSau.text = ""
        tfRam.text = ""
        tfRom.text = ""
        tfPin.text = ""
        tfGia.text = ""
        //MARK: Thông báo thêm thành công
        let alert = UIAlertController(title: "Thông Báo", message: "Thêm Thành Công", preferredStyle: .alert)
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

