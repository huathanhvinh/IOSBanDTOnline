//
//  LichSuMuaHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

var maHDLSMH = ""
var giaTriHDLSMH = ""

class LichSuMuaHang: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var ListSanPham: UITableView!
    {
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [DoanhSo]()
    @IBOutlet weak var lbTongSoDonHang: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ListSanPham.delegate = self
        //MARK: lấy tổng số đơn hàng và tổng doanh thu
        self.getInfo()
        //MARK: lấy thông tin lịch sữ mua hàng
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
                    if(TaiKhoan == ThongTinDangNhap.taiKhoan)
                    {
                        self.DanhSachSanPham.append(doanhSo)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                    
                }
            }
        })

    }
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuCell") as! LichSuCell
        cell.setDataLichSuCell(id: sanPham.ID, maDH: sanPham.IdDonHang, thanhTien: sanPham.GiaTri)
        return cell
    }
    //MARK: hàm onclick tabble cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sanPham = DanhSachSanPham[indexPath.row]
        maHDLSMH = sanPham.IdDonHang
        giaTriHDLSMH = sanPham.GiaTri
        let scr = storyboard?.instantiateViewController(withIdentifier: "ChiTietLichSuMuaHang") as! ChiTietLichSuMuaHang
        present(scr, animated: true, completion: nil)
    }
    //MARK: hàm lấy tổng số đơn hàng và tổng doanh thu
    func getInfo() {
        let ref = Database.database().reference()
        ref.child("LichSuMuaHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                var soLuong = 0
                var tongTien = 0
                for oSnap in oSnapshot {
                    let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let GiaTri:String = oSnap.childSnapshot(forPath: "GiaTri").value as? String ?? ""
                    //Lấy thông tin
                    if(ThongTinDangNhap.taiKhoan == taiKhoan)
                    {
                        soLuong = soLuong + 1
                        tongTien = tongTien + Int(GiaTri)!
                    }
                    
                }
                self.lbTongSoDonHang.text = "Tổng số đơn hàng: \(soLuong)"
                self.lbTongTien.text = "Tổng tiền: \(tongTien) VNĐ"
            }
        })
    }

}
