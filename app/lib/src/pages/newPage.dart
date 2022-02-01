import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  
 @override
  _NewPage createState() => _NewPage();
  
}

class _NewPage extends State<NewPage>{
  String? currentUser = FirebaseAuth.instance.currentUser!.email;
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 75),
Row(children: <Widget>[
  SizedBox(width: 10),
_crearButtonVolver(),
SizedBox(width: 40),
],),
Text('¿Cómo prefieres hacer tu Web?'),
SizedBox(height: 50),

_crearButtonDesdeCero(),



SizedBox(height: 50),
_crearButtonConIA(),
SizedBox(height: 50),






],

  ),
),


    );
  }








Future<bool> checkIfDocExists(String docId) async {
  try {
    // Get reference to Firestore collection
    DocumentReference webActual =FirebaseFirestore.instance.collection('webs').doc(docId).collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();
    
    return querySnapshot.exists;
  } catch (e) {
    throw e;
  }
}

Widget _crearButtonDesdeCero(){




return Container(
 height: 300.0,
        width: 250.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn1",
        child: Text('Crear Web desde Cero'),
        onPressed: () async {


String nombreWeb="prueba";
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Introduce un nombre para tu web'),
          
          content: TextField(
            onChanged: (valor)=>setState(() {
              nombreWeb=valor;
            }),
          ),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: () async {




bool docExists = await checkIfDocExists(currentUser!+"."+nombreWeb);

if(!docExists){


cargarABBDD(currentUser!+"."+nombreWeb);
Navigator.of(context).pop();




final route = MaterialPageRoute(

    builder: (context){
return CreacionWebsPage(nombreWeb);

    }
  );

Navigator.push(context, route);









}else{



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Ya tienes una web con ese nombre"),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
          ],
        );

      }

    );





}


















                
        },
            ),
          ],
        );

      }

    );












 










}),

);

}


Future<void> cargarABBDD(String nombreWeb)async {
  
  
 String autor=currentUser.toString();

DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(nombreWeb);//.collection("encabezado").doc("unique");

 webActual.set({

"autor" : autor,



 });
   



   DocumentReference webActual2 = FirebaseFirestore.instance.collection('webs').doc(nombreWeb).collection("encabezado").doc("unique");

 return webActual2.set({

"autor" : autor,
"nombre_web" : nombreWeb,
"h1" : "Titulo",
"h2" : "Subtitulo",
"h3" :"Subtitulo2",
"divs" : {}


 }

 )
          
          
          .catchError((error) => print("Failed to add user: $error"));


}

Widget _crearButtonConIA(){


return Column(children: <Widget>[
  
  Container(
 height: 115.0,
        width: 200.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Generar con Inteligencia Artificial'),
        onPressed: (){


//TODO

        }),

),







]);



}


Widget _crearButtonVolver(){


return Column(

  children: <Widget>[
  
  Container(
    
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn3",
        child: Text('Volver img'),
        onPressed: (){



 final route = MaterialPageRoute(

    builder: (context){
return HomePage();

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}



}