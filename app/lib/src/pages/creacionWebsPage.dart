import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class CreacionWebsPage extends StatefulWidget {
  
 @override
  _CreacionWebsPage createState() => _CreacionWebsPage();
  
}

class _CreacionWebsPage extends State<CreacionWebsPage>{
 
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
Text('Nombre de la pagina'),
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



return Card(
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