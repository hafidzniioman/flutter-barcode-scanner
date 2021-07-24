class Inventory {
  int id;
  String nama;
  int kodeBarang;
  int noUrutPendaftaran;
  String merk;
  int tahunPeroleh;
  int jumlahBarang;
  int satuanBarang;
  String lokasi;
  String image;

  Inventory(
      {this.id,
      this.nama,
      this.kodeBarang,
      this.noUrutPendaftaran,
      this.merk,
      this.tahunPeroleh,
      this.jumlahBarang,
      this.satuanBarang,
      this.lokasi,
      this.image,});

  Inventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kodeBarang = json['kode_barang'];
    noUrutPendaftaran = json['no_urut_pendaftaran'];
    merk = json['merk'];
    tahunPeroleh = json['tahun_peroleh'];
    jumlahBarang = json['jumlah_barang'];
    satuanBarang = json['satuan_barang'];
    lokasi = json['lokasi'];
    image = json['image'];
  }
}
