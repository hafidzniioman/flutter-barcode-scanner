class Inventory {
  String nama;
  String merk;
  String lokasi;
  String gambar;

  Inventory({this.nama, this.merk, this.lokasi, this.gambar});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
    nama : json['nama'],
    merk : json['merk'],
    lokasi : json['lokasi'],
    gambar : json['image'],
    );
  }
}
