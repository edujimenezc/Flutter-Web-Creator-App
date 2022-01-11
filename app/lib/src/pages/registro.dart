


import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';


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
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text('Registro'),
 _crearEmail(),
_crearPassword(),
_crearButtonAccess(),
_crearButtonVolver(),
],

  ),
),


    );
  }

Widget _crearEmail() {

    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
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
      obscureText: true,
      decoration: InputDecoration(
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

return FloatingActionButton(
   heroTag: "btn2",
        child: Text('Acceder'),
        onPressed: () async {


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
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}



        });

}

Widget _crearButtonVolver(){

return FloatingActionButton(
    heroTag: "btn1",
        child: Text('Volver'),
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