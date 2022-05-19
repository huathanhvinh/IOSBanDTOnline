//
//  ViewController.swift
//  StoreABC
//
//  Created by CNTT on 4/20/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import FirebaseDatabase
import UIKit

class ViewController:UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var listSanPham: UITableView!{
        didSet{
            listSanPham.dataSource = self
        }
    }
    
    
    var DanhSachSanPham = [SanPham]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("DanhSachSanPham").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //
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
                    //MARK: kiểm tra NSX
                    if(HSX == "Apple"){
                        let sanPham = SanPham(ID: ID, HDH: HDH, tenSanPham: TenSanPham, HSX: HSX, ManHinh: ManHinh, CamSau: CamSau, Ram: Ram, Rom: Rom, Pin: Pin, GiaCa: Gia, Anh1: Anh1, Anh2: Anh2, Anh3: Anh3, Anh4: Anh4)
                        self.DanhSachSanPham.append(sanPham)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.listSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
        
    }
    //MARK: Phân loại Sản Phẩm
    @IBAction func btnApple(_ sender: UIButton) {
        print("1")
        
    }

    @IBAction func btnXiaomi(_ sender: UIButton) {
        listSanPham.reloadData()
        let ref = Database.database().reference()
        ref.child("DanhSachSanPham").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //
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
                    //MARK: kiểm tra NSX
                    if(HSX == "Vivo"){
                        let sanPham = SanPham(ID: ID, HDH: HDH, tenSanPham: TenSanPham, HSX: HSX, ManHinh: ManHinh, CamSau: CamSau, Ram: Ram, Rom: Rom, Pin: Pin, GiaCa: Gia, Anh1: Anh1, Anh2: Anh2, Anh3: Anh3, Anh4: Anh4)
                        self.DanhSachSanPham.append(sanPham)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.listSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
    }
    
    @IBAction func btnSamSung(_ sender: UIButton) {
        print("3")
    }
    
    @IBAction func btnOppo(_ sender: UIButton) {
        print("4")
    }
    
    @IBAction func btnAll(_ sender: UIButton) {
        print("5")
    }
    //MARK: Get cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SanPhamNSXCell") as! SanPhamNSXCell
        cell.setDataCell(ten: sanPham.tenSanPham, gia: sanPham.GiaCa, anh: sanPham.Anh1, id: sanPham.ID)
        
        return cell
    }
    //MARK: Phân loại trang
    
}



