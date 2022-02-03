import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/ayudaPage.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class VisualizadorPage extends StatefulWidget {
  String nombreWeb="";
  String htmlCode="";
  
  VisualizadorPage(String html,web){
htmlCode=html;

nombreWeb=web;
  }
  
 @override
  _VisualizadorPage createState() => _VisualizadorPage(htmlCode,nombreWeb);
  
}

class _VisualizadorPage extends State<VisualizadorPage>{
  String htmlCode="";
  String nombreWeb="";
  
  _VisualizadorPage(String html,web){

htmlCode=html;

nombreWeb=web;
  }

 var currentUser = FirebaseAuth.instance.currentUser;
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      
     
      body: Column(

        children: [

_crearButtonVolver(),
           Center(
        child: SingleChildScrollView(
          child: Html(
            
          data:htmlCode
          
          
          
          
          
          
          
          
          
          
          
          
          
          ),

    ))
        ],
      )
      
      
     );
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
return CreacionWebsPage(nombreWeb);

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}



}