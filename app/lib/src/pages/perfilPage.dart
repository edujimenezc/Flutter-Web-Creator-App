import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  
 @override
  _PerfilPage createState() => _PerfilPage();
  
}

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

               //currentUser.updateEmail(newEmail)
              },
              child: Text(
                '¿Cambiar Email?', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),
TextButton(
              onPressed: () {
                //action
              },
              child: Text(
                '¿Cambiar Contraseña?', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),
TextButton(
              onPressed: () async {
                try {
  await FirebaseAuth.instance.currentUser!.delete();

 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );

Navigator.push(context, route);

} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') {
    print('The user must reauthenticate before this operation can be executed.');
  }
}
              },
              child: Text(
                'Eliminar mi cuenta', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),


SizedBox(height: 140),


Row(children: <Widget>[
SizedBox(width: 40),
TextButton(
              onPressed: () {
                //action
              },
              child: Text(
                'Preguntas Frecuentes', //title
                textAlign: TextAlign.end, //aligment
              ),
            ),
SizedBox(width: 40),
TextButton(
              onPressed: () {
                //action
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









void _crearAlertEliminar(BuildContext context){
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
            
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
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
  currentUser!.updateEmail(correoNuevo);
   Navigator.of(context).pop();
   //poner success y sino poner que no 
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