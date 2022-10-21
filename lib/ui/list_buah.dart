import 'package:flutter/material.dart';
import 'package:toko_buah/db/db_helper.dart';
import 'package:toko_buah/model/buah.dart';
import 'package:toko_buah/ui/detail_buah.dart';
import 'package:toko_buah/ui/form_buah.dart';

class ListBuahPage extends StatefulWidget {
  const ListBuahPage({Key? key}) : super(key: key);

  @override
  _ListBuahPageState createState() => _ListBuahPageState();
}

class _ListBuahPageState extends State<ListBuahPage> {
  List<Buah> listBuah = [];
  DBHelper db = DBHelper();

  @override
  void initState() {
    _getAllBuah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ui tampilan awal
    return Scaffold(
      appBar: AppBar(
        title: Text('Buah Box'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: listBuah.length,
        itemBuilder: (context, index) {
          Buah buah = listBuah[index];
          return Container(
              child: Column(children: [
            ListTile(
              onTap: () {
                //edit
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBuahPage(buah),
                    ));
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                "${buah.nama}",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              //overflow: TextOverflow.ellipsis(pada text…)
              subtitle: Text(
                '${buah.jumlah}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deleteBuah(buah, index);
                },
                icon: Icon(Icons.delete),
              ),
              leading: IconButton(
                onPressed: () {
                  _openFormEdit(buah);
                },
                icon: Icon(Icons.edit),
              ),
            )
          ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllBuah() async {
    var list = await db.getAllBuah();
    setState(() {
      listBuah.clear();
      list!.forEach((buah) {
        listBuah.add(Buah.fromMap(buah));
      });
    });
  }

  //form create
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormBuah()));
    if (result == 'save') {
      await _getAllBuah();
    }
  }

  Future<void> _deleteBuah(Buah buah, int position) async {
    await db.deleteBuah(buah.id!);

    setState(() {
      listBuah.removeAt(position);
    });
  }

  //form edit
  Future<void> _openFormEdit(Buah buah) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormBuah(buah: buah)));

    if (result == 'update') {
      await _getAllBuah();
    }
  }
}
