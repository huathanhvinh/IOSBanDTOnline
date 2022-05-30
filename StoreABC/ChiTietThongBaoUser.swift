//
//  ChiTietThongBaoUser.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/30/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChiTietThongBaoUser: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var lbMaDH: UILabel!
    @IBOutlet weak var lbGiaTri: UILabel!
    @IBOutlet weak var lbTinhTrang: UILabel!
    @IBOutlet weak var lbLido: UILabel!
    @IBOutlet weak var ListSanPham: UITableView!{
        didSet{
            ListSanPham.dataSource = self
        }
    }
    var DanhSachSanPham = [dsGioHang]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChiTietThongBao()
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
                    if(IDDonHang == maDHThongBaoUser){
                        let dsGiohang = dsGioHang(ID: "", taiKhoan: "", idSanpham: maSanPham, soLuong: soLuong, thanhTien: thanhTien)
                        self.DanhSachSanPham.append(dsGiohang)
                        let indexPath = IndexPath(row: self.DanhSachSanPham.count - 1, section: 0)
                        self.ListSanPham.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
    }
    func loadChiTietThongBao() {
        let ref = Database.database().reference()
        ref.child("ThongBaoNguoiDung").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //Lấy thông tin giỏ hàng
                    let IdDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                    let LiDo:String = oSnap.childSnapshot(forPath: "LiDo").value as? String ?? ""
                    let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                    //lấy thông tin hình ảnh
                    if(IdDonHang == maDHThongBaoUser){
                        self.lbMaDH.text = IdDonHang
                        self.lbTinhTrang.text = TinhTrang
                        self.lbLido.text = LiDo
                        let ref = Database.database().reference()
                        ref.child("DonHang").observe(.value, with: {(snapshot) in
                            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                                for oSnap in oSnapshot {
                                    //Lấy thông tin giỏ hàng
                                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                                    let tongTien:String = oSnap.childSnapshot(forPath: "TongTien").value as? String ?? ""

                                    //lấy thông tin hình ảnh
                                    if(ID == maDHThongBaoUser){
                                        self.lbGiaTri.text = tongTien
                                        return
                                    }
                                }
                            }
                        })
                    }
                }
            }
        })
    }
    //btn đã hiểu
    @IBAction func btnDaHieu(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: { action in
            switch action.style{
            case .default:
                let ref = Database.database().reference()
                ref.child("ThongBaoNguoiDung").observe(.value, with: {(snapshot) in
                    if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                        for oSnap in oSnapshot {
                            //Lấy thông tin giỏ hàng
                            let IdDonHang:String = oSnap.childSnapshot(forPath: "IdDonHang").value as? String ?? ""
                            let LiDo:String = oSnap.childSnapshot(forPath: "LiDo").value as? String ?? ""
                            let TinhTrang:String = oSnap.childSnapshot(forPath: "TinhTrang").value as? String ?? ""
                            let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                            let TrangThai:String = oSnap.childSnapshot(forPath: "TrangThai").value as? String ?? ""
                            let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                            //lấy thông tin hình ảnh
                            if(IdDonHang == maDHThongBaoUser){
                                let object : [String : Any] = [
                                    "IdDonHang" : IdDonHang,
                                    "LiDo" : LiDo,
                                    "TinhTrang" : TinhTrang,
                                    "TaiKhoan" : TaiKhoan,
                                    "TrangThai" : "True",
                                    "ID" : ID
                                ]
                                ref.child("ThongBaoNguoiDung").child(ID).setValue(object)
                                return
                            }
                        }
                    }
                })
                
                self.ChuyenManHinh()
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
    func ChuyenManHinh() {
        let scr = storyboard?.instantiateViewController(withIdentifier: "ThongBaoUser") as! ThongBaoUser
        present(scr, animated: true, completion: nil)
    }
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sanPham = DanhSachSanPham[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChiTietThongBaoUserCell") as! ChiTietThongBaoUserCell
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
                        cell.setDataChiTietUserCell(Anh: Anh1, tenSanPham: TenSanPham, soLuong: sanPham.soLuong, thanhTien: sanPham.thanhTien, id: "")
                        return
                    }
                }
            }
        })
        return cell
    }
}
