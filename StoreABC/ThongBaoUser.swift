//
//  ThongBaoUser.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

var maDHThongBaoUser = ""

class ThongBaoUser: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var lbDonHangChuaXuLy: UILabel!
    @IBOutlet weak var ListDonHang:
        UITableView!
    {
        didSet{
            ListDonHang.dataSource = self
        }
    }
    var DanhSachDonHang = [ThongBaoNguoiDung]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ListDonHang.delegate = self
        //MARK: Đơn hàng đã xử lý
        ThongBaoMuaHang()
        //MARK: Load thông báo đã xử lý
        let ref = Database.database().reference()
        ref.child("ThongBaoNguoiDung").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                self.DanhSachDonHang.removeAll()
                self.ListDonHang.reloadData()
                for oSnap in oSnapshot {
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let IdDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                    let LiDo:String = oSnap.childSnapshot(forPath: "LiDo").value as? String ?? ""
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                    let TrangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                    if(TrangThai == "False" && TaiKhoan == ThongTinDangNhap.taiKhoan){
                        let thongBaoUser = ThongBaoNguoiDung(id: ID, idDH: IdDonHang, liDo: LiDo, taiKhoan: TaiKhoan, tinhTrang: TinhTrang, trangThai: TrangThai)
                        self.DanhSachDonHang.append(thongBaoUser)
                        let indexPath = IndexPath(row: self.DanhSachDonHang.count - 1, section: 0)
                        self.ListDonHang.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
    }
    //MARK: Func Đơn hàng đã xử lý
    func ThongBaoMuaHang() {
        let ref = Database.database().reference()
        ref.child("ThongBaoNguoiDung").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for _ in oSnapshot {
                    var soLuong = 0
                    for oSnap in oSnapshot {
                        let trangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                        let taiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                        if(trangThai == "False" && taiKhoan == ThongTinDangNhap.taiKhoan){
                            soLuong = soLuong + 1
                        }
                    }
                    self.lbDonHangChuaXuLy.text = "Đơn hàng đã xử lý: \(soLuong)"
                }
            }
        })
    }
    //MARK:get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachDonHang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let donHang = DanhSachDonHang[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThongBaoUserCell") as! ThongBaoUserCell
        let ref = Database.database().reference()
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let TongTien:String = oSnap.childSnapshot(forPath: "TongTien").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(ID  == donHang.IdDonHang){
                        cell.setDataThongBaoUser(maDH: donHang.IdDonHang, giaTri: TongTien, tinhTrang: donHang.TinhTrang)
                        return
                    }
                }
            }
        })
        return cell
    }
    //click chi tiết thông báo
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sanPham = DanhSachDonHang[indexPath.row]
        maDHThongBaoUser = sanPham.IdDonHang
        let scr = storyboard?.instantiateViewController(withIdentifier: "ChiTietThongBaoUser") as! ChiTietThongBaoUser
        present(scr, animated: true, completion: nil)
    }
    
}
