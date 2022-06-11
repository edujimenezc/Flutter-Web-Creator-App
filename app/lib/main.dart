

import 'dart:async';

import 'package:ejemplobbdd/colors/color.dart';
import 'package:ejemplobbdd/src/pages/registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'src/pages/homepage.dart';

void main()  {
 WidgetsFlutterBinding.ensureInitialized();
     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
		primarySwatch:primaryBlue
    
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
	child:Image(
        image: AssetImage('assets/logo.jpg'),
        fit: BoxFit.cover,
        height: 50,
    )
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
        resizeToAvoidBottomInset: false,
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
  SizedBox(height: 20),
Text('Iniciar Sesión',style: TextStyle(color: colorFromHex("#165364"),fontSize: 45),),
SizedBox(height: 80),
Text('Accede para continuar',style: TextStyle(color: colorFromHex("#165364"),fontSize: 15),),
SizedBox(height: 50),
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
        icon: Icon( Icons.email ),
        //iconColor: colorFromHex("#165364")
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


Future<void> _loguearUsuario() async{
}
Widget _crearButtonAccess(){


return Container(
   height: 100.0,
        width: 100.0,
child: FloatingActionButton(
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
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
   


showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("Email incorrecto")),
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








  } else if (e.code == 'wrong-password') {
   
   
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Expanded(child: Text("Contraseña Incorrecta")),
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
}
















        })

);



}

Widget _crearButtonRegistro(){




return Container(
 height: 100.0,
        width: 100.0,

child: FloatingActionButton(
  backgroundColor: colorFromHex("#ff9a3d"),
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn1",
        child: Text('Registrarse',style: TextStyle(color: colorFromHex("#165364")),),
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