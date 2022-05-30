//
//  ThongKeDoanhSo.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ThongKeDoanhSo: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var lbTongSoDonHang: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var ListSanPham: UITableView!
    {
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [DoanhSo]()
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: lấy tổng số đơn hàng và tổng doanh thu
        self.getInfo()
        //MARK: lấy thông tin doanh số
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
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoanhSo") as! DoanhSoCell
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
    //MARK: hàm lấy tổng số đơn hàng và tổng doanh thu
    func getInfo() {
        let ref = Database.database().reference()
        ref.child("LichSuMuaHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                var soLuong = 0
                var tongTien = 0
                for oSnap in oSnapshot {
                    //Lấy thông tin
                    soLuong = soLuong + 1
                    let GiaTri:String = oSnap.childSnapshot(forPath: "GiaTri").value as? String ?? ""
                    tongTien = tongTien + Int(GiaTri)!
                }
                self.lbTongSoDonHang.text = "Tổng số đơn hàng: \(soLuong)"
                self.lbTongTien.text = "Tổng tiền: \(tongTien) VNĐ"
            }
        })
    }
}
