import 'dart:async';
import 'package:app/src/pages/registro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(
	title: 'Splash Screen',
	theme: ThemeData(
		primarySwatch: Colors.green,
	),
	home: MyHomePage(),
	debugShowCheckedModeBanner: false,
   

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
  String _email  = '';
    String _pass  = '';
    FirebaseAuth auth = FirebaseAuth.instance;
    
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text('Iniciar Sesión'),
 _crearEmail(),
_crearPassword(),
 _crearButtonAccess(),
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



Widget _crearButtonAccess(){

return FloatingActionButton(
   heroTag: "btn2",
        child: Text('Acceder'),
        onPressed: (){

















        });

}

Widget _crearButtonRegistro(){

return FloatingActionButton(
    heroTag: "btn1",
        child: Text('Registrarse'),
        onPressed: (){


 final route = MaterialPageRoute(

    builder: (context){
return RegistroPage();

    }
  );

Navigator.push(context, route);







        });

}

}