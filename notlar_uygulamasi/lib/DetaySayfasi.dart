import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/main.dart';

import 'Derslerdao.dart';
import 'Notlar.dart';

class NotDetay extends StatefulWidget {
  Notlar not;


  NotDetay(this.not);

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var tfDersadi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();

  Future<void> guncelle(int not_id,String ders_adi,int not1,int not2) async{
    await Derslerdao().guncelle(not_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));


  }
  Future<void> sil(int not_id) async{
    await Derslerdao().sil(not_id);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var not= widget.not;
    tfDersadi.text=not.ders_adi;
    tfnot1.text=not.not1.toString();
    tfnot2.text=not.not2.toString();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(

              onPressed: (){
                sil(widget.not.not_id);
              },
              child: Text("Sil",style: TextStyle(color: Colors.white),)
          ),
          TextButton(
              onPressed: (){
                guncelle(widget.not.not_id, tfDersadi.text, int.parse(tfnot1.text) ,int.parse(tfnot2.text));
              },
              child: Text("Güncelle",style: TextStyle(color: Colors.white),)
          ),

        ],
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Not Detay"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Padding(

               padding:  EdgeInsets.only(right: 50,left: 50),
               child: TextField(
                 decoration: InputDecoration(
                   hintStyle: TextStyle(
                       fontSize: 25,
                       fontWeight: FontWeight.bold
                   ),
                 ),
                 controller: tfDersadi,
               ),
             ),
            Padding(
              padding:  EdgeInsets.only(right: 50,left: 50),
              child: TextField(
                decoration: InputDecoration(
                  label: Text("1.Not"),
                  hintStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                controller: tfnot1,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 50,left: 50),
              child: TextField(

                controller: tfnot2,
              ),
            ),





          ],
        ),
      ),
    );
  }
}
