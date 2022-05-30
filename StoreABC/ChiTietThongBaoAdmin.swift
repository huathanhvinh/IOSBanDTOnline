//
//  ChiTietThongBaoAdmin.swift
//  StoreABC
//
//  Created by Thanh Vinh on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChiTietThongBaoAdmin: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var lbTenKhachHang: UILabel!
    @IBOutlet weak var lbSdt: UILabel!
    @IBOutlet weak var lbDiaChi: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var ListSanPham: UITableView!{
        didSet{
            ListSanPham.dataSource = self
        }
    }
    @IBOutlet weak var tfLiDo: UITextField!
    var DanhSachSanPham = [dsGioHang]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: lấy thông tin khách hàng
        ThongTinKhachHang()
        //MARK: Lấy tổng tiền hóa đơn
        layTongTien()
        //MARK: lấy thông tin sản phẩm của khách hàng
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
                    if(IDDonHang == idDonHang){
                        let dsGiohang = dsGioHang(ID: "", taiKhoan: "", idSanpham: maSanPham, soLuong: soLuong, thanhTien: thanhTien)
                        self.DanhSachSanPham.append(dsGiohang)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SanPhamDonHang") as! SanPhamChiTietDonHangCell
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
                        cell.setDataSanPhamDonHangCell(Anh: Anh1, tenSanPham: TenSanPham, soLuong: sanPham.soLuong, thanhTien: sanPham.thanhTien, id: "")
                        return
                    }
                }
            }
        })
        return cell
    }
    //MARK: lấy thông tin khách hàng
    func ThongTinKhachHang() {
        let ref = Database.database().reference()
        ref.child("ThongTinCaNhan").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let tenKH:String = oSnap.childSnapshot(forPath: "HoTen").value as? String ?? ""
                    let sdt:String = oSnap.childSnapshot(forPath: "SoDienThoai").value as? String ?? ""
                    let diaChi:String = oSnap.childSnapshot(forPath: "DiaChi").value as? String ?? ""
                    if(TaiKhoan == idTaiKhoanMuaHang)
                    {
                        self.lbTenKhachHang.text = tenKH
                        self.lbSdt.text = sdt
                        self.lbDiaChi.text = diaChi
                        return
                    }
                }
            }
        })
    }
    //MARK: lấy tổng tiền của đơn hàng
    func layTongTien(){
        let ref = Database.database().reference()
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let TongTien:String = oSnap.childSnapshot(forPath: "TongTien").value as? String ?? ""
                    if(idDonHang == ID)
                    {
                        self.lbTongTien.text = "Tổng tiền: \(TongTien) VNĐ"
                        return
                    }
                }
            }
        })
    }
    //MARK: Đánh dấu thông báo đã đọc
    func DaDocThongBao() {
        let ref = Database.database().reference()
        ref.child("DonHang").observe(.value, with: {(snapshot) in
            if let oSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapshot {
                    //
                    let ID:String = oSnap.childSnapshot(forPath: "ID").value as? String ?? ""
                    let TaiKhoan:String = oSnap.childSnapshot(forPath: "TaiKhoan").value as? String ?? ""
                    let TongTien:String = oSnap.childSnapshot(forPath: "TongTien").value as? String ?? ""
                    if(idDonHang == ID)
                    {
                        let object : [String : Any] = [
                            "ID" : ID,
                            "TaiKhoan" : TaiKhoan,
                            "TongTien" : TongTien ,
                            "TrangThai" : "True",
                        ]
                        ref.child("DonHang").child(ID).setValue(object)
                        return
                    }
                }
            }
        })
    }
    //MARK: nút từ chối
    @IBAction func btnTuChoi(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Từ chối đơn hàng ? !!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "không", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "có", style: .default, handler: { action in
            switch action.style{
            case .default:
                if(self.tfLiDo.text == ""){
                    let alert = UIAlertController(title: "Thông Báo", message: "Vui lòng nhập lí do !!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { action in
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
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let ref = Database.database().reference()
                    let idThongBao:String = ref.child("ThongBaoNguoiDung").childByAutoId().key ?? "Lỗi"
                    let object : [String : Any] = [
                        "ID" : idThongBao,
                        "TaiKhoan" : idTaiKhoanMuaHang,
                        "IdDonHang" : idDonHang ,
                        "TrangThai" : "False",
                        "LiDo" : self.tfLiDo.text ?? "",
                        "TinhTrang" : "Thất bại",
                        
                    ]
                    ref.child("ThongBaoNguoiDung").child(idThongBao).setValue(object)
                    //Thông báo
                    let alert = UIAlertController(title: "Thông Báo", message: "Từ chối đơn hàng thành công !!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.DaDocThongBao()
                            self.chuyenManHinh()
                            //chuyển màn hình
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
    //MARK: nút xác nhận
    @IBAction func btnXacNhan(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Xác nhận đơn hàng !!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "không", style: .default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "có", style: .default, handler: { action in
            switch action.style{
            case .default:
                //upload data thông báo người dùng
                let ref = Database.database().reference()
                let idThongBao:String = ref.child("ThongBaoNguoiDung").childByAutoId().key ?? "Lỗi"
                let object : [String : Any] = [
                    "ID" : idThongBao,
                    "TaiKhoan" : idTaiKhoanMuaHang,
                    "IdDonHang" : idDonHang ,
                    "TrangThai" : "False",
                    "LiDo" : self.tfLiDo.text ?? "",
                    "TinhTrang" : "Thành công",
                    
                ]
                ref.child("ThongBaoNguoiDung").child(idThongBao).setValue(object)
                //upload data lịch sữ mua hàng
                let idLSMH:String = ref.child("LichSuMuaHang").childByAutoId().key ?? "Lỗi"
                let object1 : [String : Any] = [
                    "ID" : idLSMH,
                    "TaiKhoan" : idTaiKhoanMuaHang,
                    "IdDonHang" : idDonHang,
                    "TinhTrang" : "Thành công",
                    "GiaTri" : self.lbTongTien.text?.split(separator: " ")[2] ?? "0"
                    
                ]
                ref.child("LichSuMuaHang").child(idLSMH).setValue(object1)
                //Thông báo
                let alert = UIAlertController(title: "Thông Báo", message: "chấp thuận đơn hàng thành công !!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        self.DaDocThongBao()
                        self.chuyenManHinh()
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
    func chuyenManHinh() {
        let scr = storyboard?.instantiateViewController(withIdentifier: "ThongBaoAdmin") as! ThongBaoAdmin
        present(scr, animated: true, completion: nil)
    }
}
