class Inventory {
  final int id;
  final String nama;
  final String kodeBarang;
  final String noUrutPendaftaran;
  final String merk;
  final String tahunPeroleh;
  final int jumlahBarang;
  final int satuanBarang;
  final String lokasi;
  final String image;

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
    );
  }
}
