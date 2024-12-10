import 'package:flutter/material.dart';

import 'Derslerdao.dart';
import 'Notlar.dart';
import 'main.dart';

class NotKayit extends StatefulWidget {






  @override
  State<NotKayit> createState() => _NotKayitState();


}

class _NotKayitState extends State<NotKayit> {
  Future<void> ekle(String ders_adi,int not1,int not2) async{
    await Derslerdao().notEkle(ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));


  }
  var tfDersadi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Not Detay"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(

              padding:  EdgeInsets.only(right: 20,left: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText:"Ders Adi",
                  hintStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                controller: tfDersadi,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top:20,right: 20,left: 20),
              child: TextField(
                decoration: InputDecoration(

                  hintText:"1.Not",
                  hintStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                controller: tfnot1,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 20,left: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText:"2.Not",
                  hintStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                controller: tfnot2,
              ),
            ),





          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          ekle(tfDersadi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
        },
        tooltip: 'Not Kayıt',
        icon: Icon(Icons.add),
        label: Text("Kaydet"),
      ),
    );
  }
}
