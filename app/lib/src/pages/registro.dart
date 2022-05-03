


import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class RegistroPage extends StatefulWidget {
  
 @override
  _RegistroPage createState() => _RegistroPage();
  
}

class _RegistroPage extends State<RegistroPage>{
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email  = '';
  String _pass = "";
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text('Registro',style: TextStyle(color: colorFromHex("#165364"),fontSize: 45),),
SizedBox(height: 100),
Text('Crea una cuenta para continuar',style: TextStyle(color: colorFromHex("#165364"),fontSize: 15),),
SizedBox(height: 50),
 _crearEmail(),
 SizedBox(height: 25),
_crearPassword(),
 SizedBox(height: 25),
_crearButtonAccess(),
 SizedBox(height: 25),
_crearButtonVolver(),
],

  ),
),


    );
  }

Widget _crearEmail() {

    return TextField(
       style: TextStyle(color: colorFromHex("#165364")),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
         focusColor: colorFromHex("#165364") ,
       hoverColor:colorFromHex("#165364") ,
       labelStyle:  TextStyle(color: colorFromHex("#165364")),
       
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon( Icons.alternate_email ),
        icon: Icon( Icons.email )
      ),
      onChanged: (valor) =>setState(() {
        _email = valor;
      })
    );

  }
 Widget _crearPassword(){

     return TextField(
       style: TextStyle(color: colorFromHex("#165364")),
      obscureText: true,
      decoration: InputDecoration(
         focusColor: colorFromHex("#165364") ,
       hoverColor:colorFromHex("#165364") ,
       labelStyle:  TextStyle(color: colorFromHex("#165364")),
       
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon( Icons.lock_open ),
        icon: Icon( Icons.lock )
      ),
      onChanged: (valor) =>setState(() {
        _pass = valor;
      })
    );

  }


Widget _crearButtonAccess(){

return  Container(
   height: 100.0,
        width: 100.0,


child: FloatingActionButton(
    backgroundColor: colorFromHex("#ff703d"),
   heroTag: "btn2",
       child: Text('Acceder',style: TextStyle(color: colorFromHex("#165364")),),
      
        onPressed: () async {




if(_email.isEmpty || _pass.isEmpty){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("Los campos Email y Password deben estar rellenos")),
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



















try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email,
    password: _pass
  );
  
  
 final route = MaterialPageRoute(

    builder: (context){
return HomePage();

    }
  );

Navigator.push(context, route);


} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
   
  
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("La contraseña es demasiado débil")),
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











  } else if (e.code == 'email-already-in-use') {
   
   

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("Ya hay una cuenta registrada con ese correo")),
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
















  }else if (e.code == 'invalid-email') {
   
   

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("Introduce un email válido")),
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
} catch (e) {
  print(e);
}



        }));

}

Widget _crearButtonVolver(){

return FloatingActionButton(
    heroTag: "btn1",
    backgroundColor: colorFromHex("#ff9a3d"),
    shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
        child: Text('Volver',style: TextStyle(color: colorFromHex("#165364")),),
       
        onPressed: (){


 final route = MaterialPageRoute(

    builder: (context){
return LoginPage();

    }
  );

Navigator.push(context, route);







        });

}


}