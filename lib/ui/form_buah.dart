import 'package:flutter/material.dart';
import 'package:toko_buah/db/db_helper.dart';
import 'package:toko_buah/model/buah.dart';

class FormBuah extends StatefulWidget {
  final Buah? buah;

  FormBuah({this.buah});

  @override
  _FormBuahState createState() => _FormBuahState();
}

class _FormBuahState extends State<FormBuah> {
  DBHelper db = DBHelper();

  TextEditingController? nama;
  TextEditingController? jumlah;
  TextEditingController? harga;
  TextEditingController? isi;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.buah == null ? '' : widget.buah!.nama);
    jumlah = TextEditingController(
        text: widget.buah == null ? '' : widget.buah!.jumlah);
    harga = TextEditingController(
        text: widget.buah == null ? '' : widget.buah!.harga);
    isi = TextEditingController(
        text: widget.buah == null ? ' ' : widget.buah!.isi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buah Box'),
        actions: [
          IconButton(
            onPressed: () {
              upsertBuah();
            },
            icon: Icon(Icons.save),
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Column(children: [
                  TextFormField(
                    controller: nama,
                    decoration: InputDecoration(hintText: 'Nama'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: jumlah,
                    decoration: InputDecoration(hintText: 'Jumlah'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: harga,
                    decoration: InputDecoration(hintText: 'Harga'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: isi,
                    decoration: InputDecoration(hintText: 'Isi'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          )),
    );
  }

  //update insert notes
  Future<void> upsertBuah() async {
    if (widget.buah != null) {
      //insert
      await db.updateBuah(Buah.fromMap({
        'id': widget.buah!.id,
        'nama': nama!.text,
        'jumlah': jumlah!.text,
        'harga': harga!.text,
        'isi': isi!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //update
      await db.saveBuah(Buah(
        nama: nama!.text,
        jumlah: jumlah!.text,
        harga: harga!.text,
        isi: isi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
