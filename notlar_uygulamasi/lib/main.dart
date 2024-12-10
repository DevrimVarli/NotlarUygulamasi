import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/Derslerdao.dart';
import 'package:notlar_uygulamasi/DetaySayfasi.dart';
import 'package:notlar_uygulamasi/NotKayit.dart';

import 'Notlar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<bool> uygulamayiKapat() async{
    await exit(0);
  }
  Future<List<Notlar>> notlariGetir() async{
    var notlarListesi=await Derslerdao().tumNotlariGetir();
    return notlarListesi;


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
            icon: Icon( Icons.arrow_back),
          onPressed: (){
              uygulamayiKapat();

          },
           ),
        backgroundColor: Colors.deepPurpleAccent,
        title: Column(
          children: [
            Text("Notlar Uygulamasi"),
            FutureBuilder<List<Notlar>>(
              future: notlariGetir(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var notlarListesi=snapshot.data;

                  double ortalama=0.0;
                  if(!notlarListesi!.isEmpty){
                    double toplam=0.0;

                    for(var n in notlarListesi!){
                      toplam+=((n.not1+n.not2)/2);

                    }
                    ortalama=toplam/notlarListesi.length;
                  }
                  return Text("Ortalama: ${ortalama.toInt()}") ;
                }
                else{
                  return Text("Ortalama:0.0") ;
                }
              },
            ),

          ],
        ),
      ),
      body: WillPopScope(
         onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Notlar>>(
             future: notlariGetir(),
              builder: (context,snapshot){
               if(snapshot.hasData){
                 var notlarListesi=snapshot.data;
                 return ListView.builder(
                     itemCount: notlarListesi!.length,
                     itemBuilder: (context,indeks){
                       var not=notlarListesi[indeks];
                       return GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>NotDetay(not)));
                         },
                         child: SizedBox(
                           height: 50,
                           child: Card(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                               children: [
                                 Text("${not.ders_adi}"),
                                 Text("${not.not1}"),
                                 Text("${not.not2}"),
                               ],
                             ),
                           ),
                         ),
                       );
                     });
               }
               else{
                 return Center(
                   child: Text("Veri bulunamadi"),
                 );
               }
              },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotKayit()));
        },
        tooltip: 'Not Ekle',
        child: Icon(Icons.add),
      ),
      
      
    );
  }
}
