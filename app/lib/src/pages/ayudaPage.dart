import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class AyudaPage extends StatefulWidget {
  
 @override
  _AyudaPage createState() => _AyudaPage();
  
}

class _AyudaPage extends State<AyudaPage>{
 
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 75),
Row(children: <Widget>[
  SizedBox(width: 10),
_crearButtonVolver(),
SizedBox(width: 40),
],),
Text('Preguntas Frecuentes'),
SizedBox(height: 25),




     Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child:Column(children: [
_crearListaPreguntas("¿Cómo creo una página web?","En la pantalla principal pulsa el botón naranja de Crea un nuevo proyecto, luego podrás elegir si la quieres crear desde cero o con una plantilla, se te pedirá un nombre para tu web, y listo!"),
_crearListaPreguntas("¿Cómo publico mi página web?","Sólo necesitas pulsar el botón de Publicar Web, del resto nos encargamos nosotros!"),
_crearListaPreguntas("¿Puedo tener dos páginas con el mismo nombre?","La respuesta es No, ya que cada web es única"),
_crearListaPreguntas("¿Puedo crear un tema predefinido?","Actualmente no, pero estamos trabando en ello y será posible muy pronto"),
_crearListaPreguntas("¿Cómo elimino una web?","En el apartado de editar un proyecto existente, deja pulsada la web que desees borrar durante 2 segundos")



       ],)
       
       
       ),
       
       ),
      
     



    
 


SizedBox(height: 25),









],

  ),
),


    );
  }






Widget _crearListaPreguntas(String pregunta, String respuesta ) {

 return ExpansionTile(title: Text(pregunta),
 children: [
Text(respuesta)

 ],
 
 
 
 
 
 );
 
}








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