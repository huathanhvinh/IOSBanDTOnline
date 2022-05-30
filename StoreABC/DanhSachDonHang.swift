//
//  DanhSachDonHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase
var idHoaDon = ""
var tkMua = ""
class DanhSachDonHang: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tfTimKiem: UITextField!
    
    @IBOutlet weak var ListSanPham: UITableView!
    {
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [DoanhSo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ListSanPham.delegate = self
        //MARK: lấy thông tin đơn hàng
        let ref = Database.database().reference()
        ref.child("LichSuMuaHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin
                    let GiaTri:String = oSnap.childSnapshot(forPath: "GiaTri").value as? String ?? ""
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let IDDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                    //lấy thông tin
                    let doanhSo = DoanhSo(GiaTri: GiaTri, ID: ID, IdDonHang: IDDonHang, TaiKhoan: TaiKhoan, TinhTrang: TinhTrang)
                    self.DanhSachSanPham.append(doanhSo)
                    let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                    self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                }
            }
        })
        
    }
    //MARK: tìm kiếm hóa đơn theo sdt
    @IBAction func timKiemSanPhamTheoSDT(_ sender: Any) {
        if(tfTimKiem.text == "")
        {
            DanhSachSanPham.removeAll()
            ListSanPham.reloadData()
            let ref = Database.database().reference()
            ref.child("LichSuMuaHang").observe(.value, with: {(snapshot) in
                if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for oSnap in oSnapshot {
                        //Lấy thông tin
                        let GiaTri:String = oSnap.childSnapshot(forPath: "GiaTri").value as? String ?? ""
                        let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                        let IDDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                        let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                        //lấy thông tin
                        let doanhSo = DoanhSo(GiaTri: GiaTri, ID: ID, IdDonHang: IDDonHang, TaiKhoan: TaiKhoan, TinhTrang: TinhTrang)
                        self.DanhSachSanPham.append(doanhSo)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            })
        }
        else{
            DanhSachSanPham.removeAll()
            ListSanPham.reloadData()
            let ref = Database.database().reference()
            ref.child("LichSuMuaHang").observe(.value, with: {(snapshot) in
                if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for oSnap in oSnapshot {
                        //Lấy thông tin
                        let GiaTri:String = oSnap.childSnapshot(forPath: "GiaTri").value as? String ?? ""
                        let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                        let IDDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                        let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                        //lấy thông tin
                        let doanhSo = DoanhSo(GiaTri: GiaTri, ID: ID, IdDonHang: IDDonHang, TaiKhoan: TaiKhoan, TinhTrang: TinhTrang)
                        let ref = Database.database().reference()
                        ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
                            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                                for oSnap in oSnapshot {
                                    //Lấy thông tin giỏ hàng
                                    let sdt:String = oSnap.childSnapshot(forPath: "SoDienThoai").value as? String ?? ""
                                    //lấy thông tin hình ảnh
                                    if(sdt.contains(self.tfTimKiem.text ?? "")){
                                        self.DanhSachSanPham.append(doanhSo)
                                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                                        return
                                    }
                                }
                            }
                        })
                    }
                }
            })
        }
    }
    
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DanhSachDonHang") as! DanhSachDonHangCell
        let ref = Database.database().reference()
        ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let sdt:String = oSnap.childSnapshot(forPath: "SoDienThoai").value as? String ?? ""
                    let hoTen:String = oSnap.childSnapshot(forPath: "HoTen").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(taiKhoan == sanPham.TaiKhoan){
                        cell.setDataDoanhSo(maDonHang: sanPham.IdDonHang, hoTen: hoTen, sdt: sdt, thanhTien: sanPham.GiaTri)
                        return
                    }
                }
            }
        })
        return cell
    }
    //MARK: hàm onclick tabble cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sanPham = DanhSachSanPham[indexPath.row]
        idHoaDon = sanPham.IdDonHang
        tkMua = sanPham.TaiKhoan
        let scr = storyboard?.instantiateViewController(withIdentifier: "ChiTietHoaDon") as! ChiTietHoaDon
        present(scr, animated: true, completion: nil)
    }
}
