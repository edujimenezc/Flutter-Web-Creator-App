import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  
 @override
  _NewPage createState() => _NewPage();
  
}

class _NewPage extends State<NewPage>{
 
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
        onPressed: (){



 final route = MaterialPageRoute(

    builder: (context){
return CreacionWebsPage();

    }
  );

Navigator.push(context, route);










        }),

);

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