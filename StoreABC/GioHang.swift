//
//  GioHang.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/20/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GioHang: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var listSanPham: UITableView!{
        didSet{
            listSanPham.dataSource = self
        }
    }
    @IBOutlet weak var lbTaiKhoan: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    var DanhSachSanPham = [dsGioHang]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTaiKhoan.text = "Xin chào: \(ThongTinDangNhap.taiKhoan)"
        let ref = Database.database().reference()
        ref.child("GioHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                var TongTien = 0
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let maSanPham
                        :String = oSnap.childSnapshot(forPath: "maSanPham").value as? String ?? ""
                    let soLuong
                        :Int = oSnap.childSnapshot(forPath: "soLuong").value as? Int ?? 0
                    let thanhTien:Int = oSnap.childSnapshot(forPath: "thanhTien").value as? Int ?? 0
                    //lấy thông tin hình ảnh
                    if(ThongTinDangNhap.taiKhoan == TaiKhoan){
                        let dsGiohang = dsGioHang(ID: ID, taiKhoan: TaiKhoan, idSanpham: maSanPham, soLuong: soLuong, thanhTien: thanhTien)
                        TongTien = TongTien + thanhTien
                        self.DanhSachSanPham.append(dsGiohang)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.listSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                    self.lbTongTien.text = "Tổng tiền: \(TongTien) VNĐ"
                }
            }
        })
    }
    //MARK: Nút xóa tất cả
    @IBAction func btnXoaTatCa(_ sender: Any) {
        
    }
    //MARK: Nút Đặt Hàng
    @IBAction func btnDatHang(_ sender: Any) {
        
    }
    
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SanPhamGioHangCell") as! SanPhamGioHangCell
        let ref = Database.database().reference()
        ref.child("DanhSachSanPham").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                var anh = ""
                var tenSP = ""
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let Anh1:String = oSnap.childSnapshot(forPath: "Anh1").value as? String ?? ""
                    let TenSanPham:String = oSnap.childSnapshot(forPath: "TenSanPham").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(ID  == sanPham.idSanPham){
                        anh = Anh1
                        tenSP = TenSanPham
                        cell.setDataSanPhamGioHangCell(Anh:anh, tenSanPham: tenSP, soLuong: sanPham.soLuong, thanhTien: sanPham.thanhTien, id: sanPham.ID)
                        return
                    }
                }
            }
        })
        return cell
    }
}
