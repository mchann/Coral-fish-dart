import 'dart:io';
import 'package:csv/csv.dart';

//membaca stok ikan yang ada di file barang.csv
void bacaStok(List<List<dynamic>> stok, String pathBerkas) {
  try {
    File berkas = File(pathBerkas);
    String isi = berkas.readAsStringSync();
    //bawaan file handling
    stok.addAll(CsvToListConverter().convert(isi));

    print('Stok Ikan saat ini:\n$stok');
  } catch (e) {
    print('Kesalahan membaca stok ikan: $e');
  }
}

//menulis stok barang
void tulisStok(List<List<dynamic>> stok, String pathBerkas) {
  try {

    File berkas = File(pathBerkas);
  //convercsv
    String csvData = ListToCsvConverter().convert(stok);
    //writestring untuk menulis stok
    berkas.writeAsStringSync(csvData);

    print('Stok ikan ditulis dengan sukses');
  } catch (e) {
    print('Kesalahan menulis stok ikan: $e');
  }
}

void perbaruiStok(List<List<dynamic>> stok, String namaBarang, int jumlah) {
  //memperbarui stok
  int indexOfItem = stok.indexWhere((row) => row.isNotEmpty && row[0] == namaBarang);
//mengurangi stok
  if (indexOfItem != -1) {
   
    stok[indexOfItem][1] = jumlah;
  } else {
   
    stok.add([namaBarang, jumlah]);
  }
}

//input stok ikan
void main() {
  String pathBerkasStok = 'stok.csv';
  List<List<dynamic>> stokBarang = [];

  // Membaca stok ikan
  bacaStok(stokBarang, pathBerkasStok);

  // Menambah atau mengurangi stok ikan
  stdout.write("Masukkan nama ikan :\n");
  String? name = stdin.readLineSync();

  stdout.write("Perbarui jumlah stok ikan :\n");
  int? stok = int.parse(stdin.readLineSync()!);

  perbaruiStok(stokBarang, '$name', stok);

  tulisStok(stokBarang, pathBerkasStok);
}
