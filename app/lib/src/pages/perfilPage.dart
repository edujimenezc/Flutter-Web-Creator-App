import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/ayudaPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/**
 * Clase PerfilPage extiende de StatefulWidget y crea el State de _PerfilPage
 */
class PerfilPage extends StatefulWidget {
  
 @override
  _PerfilPage createState() => _PerfilPage();
  
}
/**
 * Clase _PerfilPage extiende de State<PerfilPage>
 * construirá la página de perfil
 */
class _PerfilPage extends State<PerfilPage>{
 var currentUser = FirebaseAuth.instance.currentUser;
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
   
    mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 60),
Row(children: <Widget>[
  SizedBox(width: 10),
_crearButtonVolver(),
SizedBox(width: 40),
],),
Text('Tu Perfil'),

Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1018943227791982592/URnaMrya.jpg'),
              radius: 25.0,
            ),
          ),
SizedBox(height: 10),
Text(currentUser!.email.toString()),
SizedBox(height: 40),



 FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Cerrar Sesión'),
        onPressed: () async {

await FirebaseAuth.instance.signOut();


 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );

Navigator.push(context, route);


        }),

SizedBox(height: 80),

 TextButton(
              onPressed: () {
_crearAlertCambiarCorreo(context);
              },
              child: Text(
                '¿Cambiar Email?', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),
/*TextButton(
              onPressed: () {
                //_crearAlertCambiarContrasenia(context);
              },
              child: Text(
                '¿Cambiar Contraseña?', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),*/
/*TextButton(
              onPressed: () async {

_crearAlertEliminarCuenta(context);

              },
              child: Text(
                'Eliminar mi cuenta', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),*/


SizedBox(height: 140),


Row(children: <Widget>[
SizedBox(width: 40),
TextButton(
              onPressed: () {
               
               
 final route = MaterialPageRoute(

    builder: (context){
return AyudaPage();

    }
  );


Navigator.push(context, route);



              },
              child: Text(
                'Preguntas Frecuentes', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),
SizedBox(width: 40),
TextButton(
              onPressed: () {
              
              

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Donaciones'),
          
          content: Expanded(child: Text("Puedes donar a mi Paypal \n edujimenez010502@gmail.com")),
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











              },
              child: Text(
                'Donaciones', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),



],),




],

  ),
),


    );
  }



void _crearAlertEliminarCuenta(BuildContext context ){
var passActual = null;

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Eliminar Cuenta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Introduce tu Contraseña Actual'),



TextField(
            onChanged: (value) {
passActual=value;
            },
             obscureText: true,
            decoration: InputDecoration(hintText: "Contraseña"),
          ),










              
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();

 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );
//TODO trycatch
                AuthCredential credential = EmailAuthProvider.credential(email: currentUser!.email.toString(), password: passActual);

currentUser!.reauthenticateWithCredential(credential).then((value) => FirebaseAuth.instance.currentUser!.delete().then((value) => Navigator.push(context, route)));










              },
            ),
          ],
        );

      }

    );

















/*

                try {
  await FirebaseAuth.instance.currentUser!.delete();

 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );













//TODO



Navigator.push(context, route);

} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') {
    print('The user must reauthenticate before this operation can be executed.');
  }
}
              */


}





void _crearAlertCambiarCorreo(BuildContext context){
var correoNuevo=null;
 showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Cambiar Correo Electrónico'),
          
          content: TextField(
            onChanged: (value) {
correoNuevo=value;
            },
            
            decoration: InputDecoration(hintText: "Correo@example.com"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: (){
               
if(correoNuevo!=null){
//falta las excepciones
  
 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );

  currentUser!.updateEmail(correoNuevo).then((value) => 
Navigator.push(context, route));
  

 // Navigator.of(context).pop();

  

}else{

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("El correo introducido no es válido"),
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


/*

*/
}


void _crearAlertCambiarContrasenia(BuildContext context){
var passAntigua="";
var passNueva="";
 showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Cambiar Contraseña'),
          
          content: Column(
          children: <Widget>[
  

TextField(
            onChanged: (value) {
passAntigua=value;
            },
             obscureText: true,
            decoration: InputDecoration(hintText: "Contraseña Actual"),
          ),

              

TextField(
            onChanged: (value) {
passNueva=value;
            },
             obscureText: true,
            decoration: InputDecoration(hintText: "Nueva Contraseña"),
          ),









          ],



          ),
          
          
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );

               






try{

if(passNueva.toString().isNotEmpty && passAntigua.toString().isNotEmpty){

 AuthCredential credential = EmailAuthProvider.credential(email: currentUser!.email.toString(), password: passAntigua);

currentUser!.reauthenticateWithCredential(credential).then((value) => currentUser!.updatePassword(passNueva).then((value) => Navigator.push(context, route)));




  
 
  

  

 // Navigator.of(context).pop();

  

}else{

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Debes rellenar todos los campos "),
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







} on FirebaseAuthException catch (e) {



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Introduce una contraseña válida en los dos campos "),
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




// ignore: nullable_type_in_catch_clause
} on FirebaseException  catch (e){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Introduce una contraseña válida en los dos campos "),
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


/*

*/
}






















Widget _crearButtonVolver(){


return Column(

  children: <Widget>[
  
  Container(
    
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn3",
        child:Image(
        image: AssetImage('assets/back.png'),
        fit: BoxFit.cover,
        height: 50,
    ),
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