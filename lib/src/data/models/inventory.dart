class Inventory {
  final int id;
  final String nama;
  final int kodeBarang;
  final int noUrutPendaftaran;
  final String merk;
  final int tahunPeroleh;
  final int jumlahBarang;
  final int satuanBarang;
  final String lokasi;
  final String image;
  final String createdAt;
  final String updatedAt;

  Inventory({
    required this.id,
    required this.nama,
    required this.kodeBarang,
    required this.noUrutPendaftaran,
    required this.merk,
    required this.tahunPeroleh,
    required this.jumlahBarang,
    required this.satuanBarang,
    required this.lokasi,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      nama: json['nama'],
      kodeBarang: json['kode_barang'],
      noUrutPendaftaran: json['no_urut_pendaftaran'],
      merk: json['merk'],
      tahunPeroleh: json['tahun_peroleh'],
      jumlahBarang: json['jumlah_barang'],
      satuanBarang: json['satuan_barang'],
      lokasi: json['lokasi'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
