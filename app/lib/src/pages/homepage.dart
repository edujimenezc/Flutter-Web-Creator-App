import 'package:ejemplobbdd/src/pages/ayudaPage.dart';
import 'package:ejemplobbdd/src/pages/newPage.dart';
import 'package:ejemplobbdd/src/pages/perfilPage.dart';
import 'package:ejemplobbdd/src/pages/userWebsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
/**
 * Clase HomePage hereda de StatefulWidget y crea el state para _HomePage
 */
class HomePage extends StatefulWidget {
  
 @override
  _HomePage createState() => _HomePage();
  
}
/**
 * Clase _HomePage hereda de State<HomePage> y construye la homepage
 */
class _HomePage extends State<HomePage>{
 /**
  * funcion build que genera la homepage donde el usuario tiene opciones distintas para elegir qué hacer
  */
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 75),

Text('¿Qué vas a hacer hoy?',style: TextStyle(color: colorFromHex("#165364"),fontSize: 25),),
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

/**
 * Widget _crearButtonEditarWeb botón para acceder a la pantalla de crear webs
 * @return Container
 */

Widget _crearButtonCrearWeb(){




return Container(
height: 450.0,
        width: 185.0,

child: FloatingActionButton(
  backgroundColor: colorFromHex("#ff9a3d"),
    shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn1",
    
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
           Image(
        image: AssetImage('assets/newpage.png'),
        fit: BoxFit.cover,
        height: 50,
    ),SizedBox(height: 20),
     Text('Crea un nuevo Proyecto',style: TextStyle(color: colorFromHex("#165364")),),
        ],),
        
        
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




/**
 * Widget _crearButtonEditarWeb botón para acceder a la pantalla de editar webs
 * @return Container
 */
Widget _crearButtonEditarWeb(){




return Container(
 height: 450.0,
        width: 185.0,

child: FloatingActionButton(
  backgroundColor: colorFromHex("#ffc93d"),
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn2",
     
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Image(
        image: AssetImage('assets/editpages.png'),
        fit: BoxFit.cover,
        height: 50,
    ), SizedBox(height: 20),
            Text('Edita un Proyecto Existente',style: TextStyle(color: colorFromHex("#165364"),),textAlign:TextAlign.center ,)],
        ),
     
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

/**
 * Widget _crearButtonMiCuenta botón para acceder a la pantalla del perfil de usuario
 * @return Column
 */
Widget _crearButtonMiCuenta(){


return Column(children: <Widget>[
  
  Container(
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   backgroundColor: colorFromHex("#165364"),
    shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn3",
        child:  Image(
        image: AssetImage('assets/profile.png'),
        fit: BoxFit.cover,
        height: 60,
    ),
        
        
       
        onPressed: (){


 final route = MaterialPageRoute(

    builder: (context){
return PerfilPage();

    }
  );

Navigator.push(context, route);

        }),

),


Text('Mi cuenta',style: TextStyle(color: colorFromHex("#165364")),),
      




]);



}

/**
 * Widget _crearButtonAyuda botón para acceder a la pantalla de ayuda
 * @return Column
 */

Widget _crearButtonAyuda(){


return Column(children: <Widget>[
  
  Container(
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   backgroundColor: colorFromHex("#165364"),
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn4",
        child:  Image(
        image: AssetImage('assets/help.png'),
        fit: BoxFit.cover,
        height: 60,
    ),
        onPressed: (){



 final route = MaterialPageRoute(

    builder: (context){
return AyudaPage();

    }
  );

Navigator.push(context, route);

        }),

),

Text('Ayuda',style: TextStyle(color: colorFromHex("#165364")),),
      





]);



}






}