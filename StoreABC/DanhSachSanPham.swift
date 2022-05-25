//
//  DanhSachSanPham.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/24/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

var idSanPhamAD:String = ""

class DanhSachSanPham: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    
    @IBOutlet weak var lbTimKiem: UITextField!
    @IBOutlet weak var ListSanPham: UITableView!{
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [SanPham]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListSanPham.delegate = self
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
                    //
                    let sanPham = SanPham(ID: ID, HDH: HDH, tenSanPham: TenSanPham, HSX: HSX, ManHinh: ManHinh, CamSau: CamSau, Ram: Ram, Rom: Rom, Pin: Pin, GiaCa: Gia, Anh1: Anh1, Anh2: Anh2, Anh3: Anh3, Anh4: Anh4)
                    self.DanhSachSanPham.append(sanPham)
                    let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                    self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                }
            }
        })

    }
    //MARK: Tìm kiếm sản phẩm theo tên
    @IBAction func TimKiemSanPhamTheoTen(_ sender: UITextField) {
        if(lbTimKiem.text == ""){
            DanhSachSanPham.removeAll()
            ListSanPham.reloadData()
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
                        //
                        let sanPham = SanPham(ID: ID, HDH: HDH, tenSanPham: TenSanPham, HSX: HSX, ManHinh: ManHinh, CamSau: CamSau, Ram: Ram, Rom: Rom, Pin: Pin, GiaCa: Gia, Anh1: Anh1, Anh2: Anh2, Anh3: Anh3, Anh4: Anh4)
                        self.DanhSachSanPham.append(sanPham)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            })
        }else{
            DanhSachSanPham.removeAll()
            ListSanPham.reloadData()
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
                        //
                        let sanPham = SanPham(ID: ID, HDH: HDH, tenSanPham: TenSanPham, HSX: HSX, ManHinh: ManHinh, CamSau: CamSau, Ram: Ram, Rom: Rom, Pin: Pin, GiaCa: Gia, Anh1: Anh1, Anh2: Anh2, Anh3: Anh3, Anh4: Anh4)
                        if(sanPham.tenSanPham.lowercased().contains(self.lbTimKiem.text?.lowercased() ?? "")){
                            self.DanhSachSanPham.append(sanPham)
                            let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                            self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            })
        }
    }
    //MARK: Get cellls
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SanPhamCellAD") as! SanPhamCellAD
        cell.setDataCell(ten: sanPham.tenSanPham, gia: sanPham.GiaCa, hsx: sanPham.HSX, anh: sanPham.Anh1, id: sanPham.ID)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sanPham = DanhSachSanPham[indexPath.row]
        idSanPhamAD = sanPham.ID
        let scr = storyboard?.instantiateViewController(withIdentifier: "ManHinhChiTietSanPhamAD") as! ThongTinSanPham
        present(scr, animated: true, completion: nil)
    }
}
