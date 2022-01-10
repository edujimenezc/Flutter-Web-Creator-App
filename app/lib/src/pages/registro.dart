

import 'package:app/main.dart';
import 'package:flutter/material.dart';



class RegistroPage extends StatefulWidget {
  
 @override
  _RegistroPage createState() => _RegistroPage();
  
}

class _RegistroPage extends State<RegistroPage>{
  String _email  = '';
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
        _email = valor;
      })
    );

  }


Widget _crearButtonAccess(){

return FloatingActionButton(
   heroTag: "btn2",
        child: Text('Acceder'),
        onPressed: (){
//ir2pantalla

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