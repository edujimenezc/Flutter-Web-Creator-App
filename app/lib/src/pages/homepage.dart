import 'package:ejemplobbdd/src/pages/newPage.dart';
import 'package:ejemplobbdd/src/pages/perfilPage.dart';
import 'package:ejemplobbdd/src/pages/userWebsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
 @override
  _HomePage createState() => _HomePage();
  
}

class _HomePage extends State<HomePage>{
 
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 75),
Text('¿Qué vas a hacer hoy?'),
SizedBox(height: 50),
Row(
   mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
_crearButtonCrearWeb(),
SizedBox(width: 10),
_crearButtonEditarWeb(),

],
),
SizedBox(height: 30),
Row(
 mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
_crearButtonMiCuenta(),
SizedBox(width: 90),
_crearButtonAyuda(),



  ],
),

],

  ),
),


    );
  }



Widget _crearButtonCrearWeb(){




return Container(
height: 450.0,
        width: 185.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn1",
        child: Text('Crea un nuevo Proyecto'),
        onPressed: (){



 final route = MaterialPageRoute(

    builder: (context){
return NewPage();

    }
  );

Navigator.push(context, route);

        }),

);

}





Widget _crearButtonEditarWeb(){




return Container(
 height: 450.0,
        width: 185.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Edita un Proyecto Existente'),
        onPressed: (){



 final route = MaterialPageRoute(

    builder: (context){
return UserWebsPage();

    }
  );

Navigator.push(context, route);

        }),

);

}

Widget _crearButtonMiCuenta(){


return Column(children: <Widget>[
  
  Container(
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn3",
        child: Text('Mi cuenta img'),
        onPressed: (){


 final route = MaterialPageRoute(

    builder: (context){
return PerfilPage();

    }
  );

Navigator.push(context, route);

        }),

),


Text('Mi Cuenta'),




]);



}


Widget _crearButtonAyuda(){


return Column(children: <Widget>[
  
  Container(
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn4",
        child: Text('Ayuda img'),
        onPressed: (){


//TODO

        }),

),

Text('Ayuda'),





]);



}






}