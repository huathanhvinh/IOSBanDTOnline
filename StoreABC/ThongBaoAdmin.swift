//
//  ThongBaoAdmin.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

var idDonHang = ""
var idTaiKhoanMuaHang = ""

class ThongBaoAdmin: UIViewController, UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var ListDonHang: UITableView!{
        didSet{
            ListDonHang.dataSource = self
        }
    }
    var DanhSachDonHang = [DonHang]()
    @IBOutlet weak var lbSoLuongDonHang: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ListDonHang.delegate = self
        let ref = Database.database().reference()
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                var soLuong = 0
                self.DanhSachDonHang.removeAll()
                self.ListDonHang.reloadData()
                for oSnap in oSnapshot {
                    let TrangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                    if(TrangThai == "False"){
                        soLuong = soLuong + 1
                    }
                }
                self.lbSoLuongDonHang.text = "Đơn hàng chưa xử lý: \(soLuong)"
            }
        })
        //MARK: Load thông báo chưa xử lý
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let TongTien:String = oSnap.childSnapshot(forPath: "TongTien").value as? String ?? ""
                    let TrangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                    if(TrangThai == "False"){
                        let donHang = DonHang(ID: ID, taiKhoan: TaiKhoan, TongTien: TongTien, TrangThai: TrangThai)
                        self.DanhSachDonHang.append(donHang)
                        let indexPath = IndexPath(row: self.DanhSachDonHang.count - 1, section: 0)
                        self.ListDonHang.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
    }
    //MARK:get cells Đơn Hàng
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachDonHang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let donHang = DanhSachDonHang[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonHangCell") as! DonHangCell
        let ref = Database.database().reference()
        ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let hoTen:String = oSnap.childSnapshot(forPath: "HoTen").value as? String ?? ""
                    let sdt:String = oSnap.childSnapshot(forPath: "SoDienThoai").value as? String ?? ""
                    let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(taiKhoan  == donHang.TaiKhoan){
                        cell.setDaTaDonHang(hoTen: hoTen, sdt: sdt, giaTri: donHang.TongTien, id: donHang.ID)
                        return
                    }
                }
            }
        })
        return cell
    }
    
    //MARK: hàm onclick tabble cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donHang = DanhSachDonHang[indexPath.row]
        idDonHang = donHang.ID
        idTaiKhoanMuaHang = donHang.TaiKhoan
        let scr = storyboard?.instantiateViewController(withIdentifier: "ChiTietThongBaoAdmin") as! ChiTietThongBaoAdmin
        present(scr, animated: true, completion: nil)
    }
}
