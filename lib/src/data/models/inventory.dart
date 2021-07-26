class Inventory {
  int id;
  String nama;
  int kodeBarang;
  int noUrutPendaftaran;
  String merk;
  int tahunPeroleh;
  int jumlahBarang;
  String lokasi;
  String gambar;

  Inventory(
      {this.id,
      this.nama,
      this.kodeBarang,
      this.noUrutPendaftaran,
      this.merk,
      this.tahunPeroleh,
      this.jumlahBarang,
      this.lokasi,
      this.gambar});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json["id"],
      nama: json['nama'],
      kodeBarang: json['kode_barang'],
      noUrutPendaftaran: json['no_urut_pendaftaran'],
      merk: json['merk'],
      tahunPeroleh: json['tahun_peroleh'],
      jumlahBarang: json['jumlah_barang'],
      lokasi: json['lokasi'],
      gambar: json['image'],
    );
  }
}
