

import 'dart:async';

import 'package:ejemplobbdd/src/pages/registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'src/pages/homepage.dart';

void main()  {

runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inicialization = Firebase.initializeApp();
@override
Widget build(BuildContext context) {


return FutureBuilder(
future: _inicialization,
builder: (context,snapshot){

	return MaterialApp(
	title: 'Splash Screen',
	theme: ThemeData(
		primarySwatch: Colors.green,
	),
	home: MyHomePage(),
	debugShowCheckedModeBanner: false,
   

	);
},
);









}
}

class MyHomePage extends StatefulWidget {
@override
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 3),
		()=>Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) =>
														LoginPage()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
  
	return Container(
	color: Colors.teal.shade100,
	child:FlutterLogo(size:MediaQuery.of(context).size.height)
	);
}
}


class LoginPage extends StatefulWidget {
  
 @override
  _LoginPage createState() => _LoginPage();
  
}

class _LoginPage extends State<LoginPage>{
  final Future<FirebaseApp> _inicialization =Firebase.initializeApp();

 
  String _email  = '';
    String _pass  = '';
   
    
 @override
  Widget build(BuildContext context) {


    
    
    
    
      return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text('Iniciar Sesión'),
SizedBox(height: 100),
 _crearEmail(),
 SizedBox(height: 25),
_crearPassword(),
 SizedBox(height: 50),

   _crearButtonAccess(),
 
   SizedBox(height: 25),
  
 _crearButtonRegistro(),



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


Future<void> _loguearUsuario() async{
}
Widget _crearButtonAccess(){


return Container(
   height: 100.0,
        width: 100.0,
child: FloatingActionButton(
   heroTag: "btn2",
        child: Text('Acceder'),
        onPressed: () async {

 
try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
















        })

);



}

Widget _crearButtonRegistro(){




return Container(
 height: 100.0,
        width: 100.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn1",
        child: Text('Registrarse'),
        onPressed: (){


 final route = MaterialPageRoute(

    builder: (context){
return RegistroPage();

    }
  );

Navigator.push(context, route);







        }),

);

}

}