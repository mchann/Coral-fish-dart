import 'dart:io';
import 'package:csv/csv.dart';


void main() {
  //membaca file stok barang.csv
  File stok = File('stok.csv');
  String csv = stok.readAsStringSync();
  //mengconvert csv
  List<List<dynamic>> stokBarang = CsvToListConverter().convert(csv);



  List<String> ikan = [
    'Clown Fish     /ekor',
    'Blue Tang      /ekor',
    'Fire Fish      /ekor',
    'Paradise Fish  /ekor',
    'Botana Zebra   /ekor',
    'Keyhole Angel  /ekor',
    'Blue Devilfish /ekor',
    'Guppy Fish     /ekor',
    'Jae jae green  /ekor',
    'Banggai Fish   /ekor'
  ];
  List<double> harga = [
    20000,
    150000,
    30000,
    8000,
    30000,
    30000,
    10000,
    12000,
    10000,
    30000
  ];
  

  List<int> jumlah = List.filled(ikan.length, 0);

  print('\n========== Daftar Ikan Dan Harga Per Ekor: ==========');
  for (int i = 0; i < ikan.length; i++) {
    print('${i + 1}. ${ikan[i]} \t Harga: ${harga[i]}');
  }

  while (true) {
    stdout.write('\nPilih nomor ikan yang ingin dibeli (0 untuk selesai): \n');
    int pilih = int.parse(stdin.readLineSync()!);

    if (pilih == 0) {
      break;
    }

    if (pilih < 1 || pilih > ikan.length) {
      print('IKAN NOT FOUND !\nHarap ketik dengan benar nomor ikan');
      continue;
    }

    stdout.write('Masukkan jumlah ekor ikan yang dibeli: ');
    int ekor = int.parse(stdin.readLineSync()!);

    jumlah[pilih - 1] += ekor;

    //jika membeli stok tidak cukup maka muncul notif maaf stok tidak cukup
    if (ekor <= stokBarang[pilih - 1][1]) {
    stokBarang[pilih - 1][1] -= ekor;
    } else {
    print('Maaf, stok tidak cukup.');
    continue;
    }
    //untuk convert csv 
    String barangCsv = const ListToCsvConverter().convert(stokBarang);
    stok.writeAsStringSync(barangCsv);

  }

  double total = calculateTotal(harga, jumlah);

//  detail pembelian
  print('\nDetail Pembelian:');
  for (int i = 0; i < ikan.length; i++) {
    if (jumlah[i] > 0) {
      print('${ikan[i]} \t Harga: ${harga[i]} \t Jumlah: ${jumlah[i]}');
    }
  }

  print('\nTotal Yang Harus di bayar: $total\n');
}

  // mengunakan function return value
double calculateTotal(List<double> harga, List<int> jumlah) {
  double total = 0.0;
  double diskon = 0;
  for (int i = 0; i < harga.length; i++) {
    total += harga[i] * jumlah[i];
    if (total > 500000) {
      diskon = total * 0.10;
      // total = total - diskon;
    } else if (total < 500000) {}
  
  }

  print(
      '\n=== anda mendapatkan diskon 10% jika pembelian diatas 500.000 \n===Total pembelian anda $total\n===diskon yang anda dapatkan $diskon ===\n');
  return total = total - diskon;
}

