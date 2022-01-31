import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/pages/EditorEncabezadoPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class CreacionWebsPage extends StatefulWidget {
  String paginaActual="";
  CreacionWebsPage(String nombreWeb){
paginaActual=nombreWeb;

  }
 @override
  _CreacionWebsPage createState() => _CreacionWebsPage(paginaActual);
  
}

class _CreacionWebsPage extends State<CreacionWebsPage>{
   String paginaActual="";
 _CreacionWebsPage(String nombreWeb){
   paginaActual=nombreWeb;
 }
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
SizedBox(width: 200),
_crearButtonVistaPrevia(),
],),

      

        



    
 


SizedBox(height: 25),
Text(paginaActual),
SizedBox(height: 25),


  Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child:  ListView(
padding: EdgeInsets.all(20),
children: <Widget>[
  
  _cardCabecera(),
  SizedBox(height: 10.0 ,),
  _cardCuerpo(),
  SizedBox(height: 10.0 ,),
  _cardPie(),
  SizedBox(height: 10.0 ,),
  
],

)
       
       ),
       
       ),












],

  ),
),


    );
  }















Future<Encabezado> cargarDeBBDD() async {

var nombre;
var h1;
var h2;
var h3;
var mapaDivs;

Encabezado x=Encabezado.constructor2();
DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc("prueba").collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();

Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombre=data["nombre_web"].toString();
 x.h1=data["h1"].toString();
 x.h2=data["h2"].toString();
 x.h3=data["h3"].toString();
x.mapaDivs=data["divs"];



return x;








}else{
  
 

 
  return x;




 



}
 


  
}






Widget _crearButtonVistaPrevia(){


return Column(children: <Widget>[
  
  Container(
 height: 50.0,
        width: 50.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Vista Previa'),
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



Widget  _cardCabecera() {

return InkWell(
    child: Card(
  
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Cabecera'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[



  ],
)*/


    ],
  ),
),
    onTap: () { 
        



 final route = MaterialPageRoute(

    builder: (context){
return EditorEncabezadoPage(paginaActual);

    }
  );

Navigator.push(context, route);







    },
);






}


Widget  _cardCuerpo() {



return Card(
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Cuerpo'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[

TextButton(onPressed: (){}, child: Text('mamaguebo')),
TextButton(onPressed: (){}, child: Text('mamapinga')),

  ],
)*/


    ],
  ),
);




}

Widget  _cardPie() {



return Card(
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Pie'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[

TextButton(onPressed: (){}, child: Text('mamaguebo')),
TextButton(onPressed: (){}, child: Text('mamapinga')),

  ],
)*/


    ],
  ),
);




}






}