import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sukamiskin/src/data/models/inventory.dart';

class ApiService {
  final String apiUrl = 'http://inventory.hafidzniioman.com/api/product';
  final String urlImage = "http://inventory.hafidzniioman.com/product/";

  Future<List<Inventory>> retrieveInventory() async {
    final response = await http.get(apiUrl);
    var responseJson = json.decode(response.body);
    return (responseJson['data']['products'] as List)
        .map((e) => Inventory.fromJson(e))
        .toList();
  }

  Future<http.Response> createInventory(nama, kodeBarang, noUrutPendaftaran, merk, tahunPeroleh, jumlahBarang, lokasi, image) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
        'nama': nama,
        'kode_barang': kodeBarang,
        'no_urut_pendaftaran': noUrutPendaftaran,
        'merk': merk,
        'tahun_peroleh': tahunPeroleh,
        'jumlah_barang': jumlahBarang,
        'lokasi': lokasi,
        'image': image,
        }));
    // if (response.statusCode == 201) {
    //   return Inventory.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to create');
    // }
  }
}
