class Buah {
  int? id;
  String? nama;
  String? jumlah;
  String? harga;
  String? isi;

  Buah({this.id, this.nama, this.jumlah, this.harga, this.isi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['jumlah'] = jumlah;
    map['harga'] = harga;
    map['isi'] = isi;
    return map;
  }

  Buah.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.jumlah = map['jumlah'];
    this.harga = map['harga'];
    this.isi = map['isi'];
  }
}
