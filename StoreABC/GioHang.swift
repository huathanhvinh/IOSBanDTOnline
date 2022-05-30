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
    @IBOutlet weak var listSanPhamGioHang: UITableView!{
        didSet{
            listSanPhamGioHang.dataSource = self
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
                        self.listSanPhamGioHang.insertRows(at: [indexPath], with: .automatic)
                    }
                    self.lbTongTien.text = "\(TongTien)"
                }
            }
        })
    }
    
    //MARK: Nút xóa tất cả
    @IBAction func btnXoaTatCa(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn có muốn xóa không ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { action in
            switch action.style{
            case .default:
                //xóa danh sách sản phẩm
                let ref = Database.database().reference()
                ref.child("GioHang").observe(.value, with: {(snapshot) in
                    if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                        for oSnap in oSnapshot {
                            let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                            let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                            if(TaiKhoan == ThongTinDangNhap.taiKhoan){
                                ref.child("GioHang").child(ID).removeValue()
                            }
                        }
                    }
                })
                //thông báo & reload lại dữ liệu
                let alert = UIAlertController(title: "Thông Báo", message: "Xóa thành công", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        self.DanhSachSanPham.removeAll()
                        self.listSanPhamGioHang.reloadData()
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                    default:
                        break
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
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
    //MARK: Nút Đặt Hàng
    @IBAction func btnDatHang(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Xác nhận đặt hàng ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { action in
            switch action.style{
            case .default:
                //thêm đơn hàng
                let ref = Database.database().reference()
                let idDonHang:String = ref.child("DonHang").childByAutoId().key ?? "Lỗi"
                //MARK: thêm thông tin vào firebase
                let object : [String : Any] = [
                    "ID" : idDonHang,
                    "TaiKhoan" : ThongTinDangNhap.taiKhoan,
                    "TongTien" : self.lbTongTien.text ?? "",
                    "TrangThai" : "False",
                ]
               ref.child("DonHang").child(idDonHang).setValue(object)
                //thêm chi tiết đơn hàng
                for i in 0..<self.DanhSachSanPham.count {
                    let idChiTietDonHang:String = ref.child("ChiTietDonHang").childByAutoId().key ?? "Lỗi"
                    //MARK: thêm thông tin vào firebase
                    let object : [String : Any] = [
                        "ID" : idChiTietDonHang,
                        "IDDonHang" : idDonHang,
                        "IDSanPham" : self.DanhSachSanPham[i].idSanPham,
                        "SoLuong" : self.DanhSachSanPham[i].soLuong,
                        "ThanhTien" : self.DanhSachSanPham[i].thanhTien,
                    ]
                   ref.child("ChiTietDonHang").child(idChiTietDonHang).setValue(object)
                }
                self.DanhSachSanPham.removeAll()
                self.listSanPhamGioHang.reloadData()
                self.lbTongTien.text = "0"
                //thông báo đặt hàng thành công
                let alert = UIAlertController(title: "Thông Báo", message: "Đặt hàng thành công, vui lòng chờ phản hồi !!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        //xóa danh sách giỏ hàng
                        ref.child("GioHang").observe(.value, with: {(snapshot) in
                            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                                for oSnap in oSnapshot {
                                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                                    if(TaiKhoan == ThongTinDangNhap.taiKhoan){
                                        ref.child("GioHang").child(ID).removeValue()
                                    }
                                }
                            }
                        })
                        //load lại data
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                    default:
                        break
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
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
    
    //MARK: get cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DanhSachSanPham.count
    }
    //get cells
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
