//
//  ChiTietLichSuMuaHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChiTietLichSuMuaHang:UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var lbMaHD: UILabel!
    @IBOutlet weak var lbGiaTri: UILabel!
    @IBOutlet weak var ListSanPham: UITableView!
    {
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [dsGioHang]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMaHD.text = maHDLSMH
        lbGiaTri.text = "\(giaTriHDLSMH) VNĐ"
        //MARK: lấy thông tin sản phẩm của đơn hàng
        let ref = Database.database().reference()
        ref.child("ChiTietDonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let IDDonHang:String = oSnap.childSnapshot(forPath: "IDDonHang").value as? String ?? ""
                    let maSanPham:String = oSnap.childSnapshot(forPath: "IDSanPham").value as? String ?? ""
                    let soLuong:Int = oSnap.childSnapshot(forPath: "SoLuong").value as? Int ?? 0
                    let thanhTien:Int = oSnap.childSnapshot(forPath: "ThanhTien").value as? Int ?? 0
                    //lấy thông tin hình ảnh
                    if(IDDonHang == maHDLSMH){
                        let dsGiohang = dsGioHang(ID: "", taiKhoan: "", idSanpham: maSanPham, soLuong: soLuong, thanhTien: thanhTien)
                        self.DanhSachSanPham.append(dsGiohang)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChiTietLichSuCell") as! ChiTietLichSuCell
        let ref = Database.database().reference()
        ref.child("DanhSachSanPham").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let Anh1:String = oSnap.childSnapshot(forPath: "Anh1").value as? String ?? ""
                    let TenSanPham:String = oSnap.childSnapshot(forPath: "TenSanPham").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(ID == sanPham.idSanPham){
                        cell.setDataChiTietLichSuCell(Anh: Anh1, tenSanPham: TenSanPham, soLuong: sanPham.soLuong, thanhTien: sanPham.thanhTien, id: "")
                        return
                    }
                }
            }
        })
        return cell
    }
}
