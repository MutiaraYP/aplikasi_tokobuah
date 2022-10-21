import 'package:flutter/material.dart';
import 'package:toko_buah/model/buah.dart';

class DetailBuahPage extends StatelessWidget {
  final Buah? buah;

  DetailBuahPage(this.buah);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buah Box'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nama',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${buah!.nama}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Jumlah',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${buah!.jumlah}'),
                  Text(
                    'Harga',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${buah!.harga}'),
                  Text(
                    'Isi',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${buah!.isi}'),
                ],
              ),
            )
          ]),
        ));
  }
}
