import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/pages/ayudaPage.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

/**
 * Clase VisualizadorPage extiende de StatefulWidget y crea el State de _VisualizadorPage
 */
class VisualizadorPage extends StatefulWidget {
  String nombreWeb="";
  String htmlCode="";
  String imgFondoX="";
  VisualizadorPage(String html,String myImg,web){
htmlCode=html;
imgFondoX=myImg;
nombreWeb=web;
  }
  
 @override
  _VisualizadorPage createState() => _VisualizadorPage(htmlCode,"${imgFondoX}",nombreWeb);
  
}

/**
 * Clase _VisualizadorPage extiende de State<VisualizadorPage>
 * construirá la página para visualización
 */
class _VisualizadorPage extends State<VisualizadorPage>{
  String htmlCode="";
  String nombreWeb="";
  String imgFondoX="";
  Color scaffoldColor=Colors.white;

  _VisualizadorPage(String html,String imgFondo,web){
imgFondoX=imgFondo;
htmlCode=html;

nombreWeb=web;
  }

 var currentUser = FirebaseAuth.instance.currentUser;
 @override
  Widget build(BuildContext context) {

if(imgFondoX!=""){

scaffoldColor=Colors.transparent;

}else{
   imgFondoX="https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Google_Images_2015_logo.svg/640px-Google_Images_2015_logo.svg.png";
}



return Container(
decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage("${imgFondoX}"),
      fit: BoxFit.cover)
    ),
  child: Scaffold(
      
      backgroundColor: scaffoldColor,
     
      body: SingleChildScrollView(
        child: Column(

        children: [

_crearButtonVolver(),
           Center(
        child: SingleChildScrollView(
          
          child: Html(
            
          data:htmlCode
          
          
          
          
          
          
          
          
          
          
          
          
          
          ),

    ))
        ],
      ),
      )
      
      
      
      
      
      
      
      
      
      
      
     ),
);
    
  }


/** 
 * Widget _crearButtonVolver boton para volver a la página anterior
 * @return Column
*/
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