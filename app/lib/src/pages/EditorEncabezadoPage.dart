import 'dart:collection';
import 'dart:convert';

import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorEncabezadoPage extends StatefulWidget {
  
 @override
  _EditorEncabezadoPage createState() => _EditorEncabezadoPage();
  
}

class _EditorEncabezadoPage extends State<EditorEncabezadoPage>{

 @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[

Row(children: <Widget>[
  
  SizedBox(width: 10),
_crearButtonVolver(),
//SizedBox(width: 20),

],),

      Row(children: <Widget>[
  
  SizedBox(width: 10),

//SizedBox(width: 20),

],),

        

_crearEditable(),

    SizedBox(height: 400),
 
















],

  ),
),


    );
  }

















 Widget _crearEditable() {
readJson();
    // menuProvider.cargarData()
    return FutureBuilder(
      future: readJson(),
      initialData: [""],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot ){



Encabezado EncabezadoActual=snapshot.data![0];
EncabezadoActual.aniadirAContenedores();
var h1="Titulo";
var h2="Subtitulo";
var h3="Más texto";


if(EncabezadoActual.getH1.toString().isNotEmpty){
h1=EncabezadoActual.getH1;
}


if(EncabezadoActual.getH2.toString().isNotEmpty){
h2=EncabezadoActual.getH2;
}

if(EncabezadoActual.getH3.toString().isNotEmpty){
h3=EncabezadoActual.getH3;
}
  return Column(

children: <Widget>[

TextField(
  
      obscureText: true,
      decoration: InputDecoration(
        
        hintText: h1.toString(),
        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       // _pass = valor;
      })
    ),


TextField(
  
      obscureText: true,
      decoration: InputDecoration(
        
        hintText: h2.toString(),
        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       // _pass = valor;
      })
    ),


TextField(
  
      obscureText: true,
      decoration: InputDecoration(
        
        hintText: h3.toString(),




        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       // _pass = valor;
      })
    )





],

);

      },
    );

  

    

  }
















  Future<List<dynamic>> readJson() async {

    final String response = await rootBundle.loadString('assets/jsonBase.json');
    final datos =json.decode(response);
    


   return datos.map<Encabezado>(Encabezado.fromJson).toList();
    
  
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
return CreacionWebsPage();

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}






}