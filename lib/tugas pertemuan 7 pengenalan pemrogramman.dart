// 261240001745-Nando Fadlikal Kamal
void main(){
  String nama = "Nando Fadlikal Kamal";
  String alamat = "Senenan";
  String mulaiSewa = "07";
  String selesaiSewa = "10";
  int lamaSewa = int.parse(selesaiSewa) - int.parse(mulaiSewa);
  int biayaSewa = lamaSewa * 5000;
  
  print("==== APLIKASI RENTAL SEPEDA ====");
  print("nama: $nama");
  print("alamat: $alamat");
  print("mulai sewa: $mulaiSewa:00");
  print("selesai sewa: $selesaiSewa:00");
  print("lama sewa: $lamaSewa jam");
  print("biaya sewa: Rp$biayaSewa");
}