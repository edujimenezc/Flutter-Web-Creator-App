import 'dart:io';
import 'package:ejemplobbdd/src/pages/visualizarWebPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/pages/EditorEncabezadoPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_archive/flutter_archive.dart';
class CreacionWebsPage extends StatefulWidget {
  String paginaActual="";
  CreacionWebsPage(String nombreWeb){
paginaActual=nombreWeb;

  }
 @override
  _CreacionWebsPage createState() => _CreacionWebsPage(paginaActual);
  
}

class _CreacionWebsPage extends State<CreacionWebsPage>{
   String paginaActual="";
    String? currentUser = FirebaseAuth.instance.currentUser!.email;
 _CreacionWebsPage(String nombreWeb){
   paginaActual=nombreWeb;
 }
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
SizedBox(width: 120),
_crearButtonVistaPrevia(),
SizedBox(width: 20),
_crearButtonGuardarWeb(),
],),

      

        



    
 


SizedBox(height: 25),
Text(paginaActual),
SizedBox(height: 25),


  Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child:  ListView(
padding: EdgeInsets.all(20),
children: <Widget>[
  
  _cardCabecera(),
  SizedBox(height: 10.0 ,),
  _cardCuerpo(),
  SizedBox(height: 10.0 ,),
  _cardPie(),
  SizedBox(height: 10.0 ,),
  
],

)
       
       ),
       
       ),












],

  ),
),


    );
  }















Future<Encabezado> cargarDeBBDD() async {

var nombre;
var h1;
var h2;
var h3;
var mapaDivs;

Encabezado x=Encabezado.constructor2();
DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(currentUser!+"."+paginaActual).collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();

Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombre=data["nombre_web"].toString();
 x.h1=data["h1"].toString();
 x.h2=data["h2"].toString();
 x.h3=data["h3"].toString();
x.mapaDivs=data["divs"];



return x;








}else{
  
 

 
  return x;




 



}
 


  
}


Future<String> _write(String text) async {

  //TODO cuando veamos eso en clase
  final Directory directory = await getApplicationDocumentsDirectory();
  final directoryExternal = await getExternalStorageDirectory();
  final File file = File('${directory.path}/${currentUser!+"."+paginaActual}.html');
  await file.writeAsString(text);
final File file2 = File('${directoryExternal!.path}/${currentUser!+"."+paginaActual}.html');
  await file2.writeAsString(text);
  
    //return directoryExternal!.absolute.path;

    //print(directory.absolute.path);
  return directory.absolute.path;
}

Future<String> _read() async {
  String text="";
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${currentUser!+"."+paginaActual}.html');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}




Future<String> _crearHTML() async{


DocumentReference EncabezadoActual = FirebaseFirestore.instance.collection('webs').doc(currentUser!+"."+paginaActual).collection("encabezado").doc("unique");
var querySnapshot = await EncabezadoActual.get();

String nombreWeb="";
String h1Encabezado="";
String h2Encabezado="";
String h3Encabezado="";
Map divsEncabezado={};





Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombreWeb=data["nombre_web"].toString();
 h1Encabezado=data["h1"].toString();
 h2Encabezado=data["h2"].toString();
 h3Encabezado=data["h3"].toString();
divsEncabezado=data["divs"];


//demas
}



String textoArchivoHTML="";

//abro html
textoArchivoHTML=textoArchivoHTML+"<html>\n";
//tittle
textoArchivoHTML=textoArchivoHTML+"<Title> ${nombreWeb} </Title>"+"\n";

//abro body
textoArchivoHTML=textoArchivoHTML+"<body>\n";

//abro el div del marco
textoArchivoHTML=textoArchivoHTML+'<div class="marco">\n';

//abro el div encabezado
textoArchivoHTML=textoArchivoHTML+'<div class="encabezado">\n';


//h1 del encabezado
if(h1Encabezado!=""){
textoArchivoHTML=textoArchivoHTML+'<h1>\n'+h1Encabezado+"\n</h1>\n";
}

//h2 del encabezado
if(h2Encabezado!=""){
textoArchivoHTML=textoArchivoHTML+'<h2>\n'+h2Encabezado+"\n</h2>\n";
}

//h3 del encabezado
if(h3Encabezado!=""){
textoArchivoHTML=textoArchivoHTML+'<h3>\n'+h3Encabezado+"\n</h3>\n";
}

//recorro todos los divs del encabezado
for (var div in divsEncabezado.keys) {
  //abro div
  textoArchivoHTML=textoArchivoHTML+'<div class="${div}">\n';
  
for (var contenido in divsEncabezado[div].keys) {
  

if(contenido.length>6){
//es video >9
  if(contenido.substring(2)=="video"){
 //meto el video
 String id=divsEncabezado[div][contenido].split('=')[1];
 textoArchivoHTML=textoArchivoHTML+'<iframe width="560" height="315" src="https://www.youtube.com/embed/${id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
+"\n";


}



}else{
//es video <=9
if(contenido.substring(1)=="video"){
 //meto el video
 String id=divsEncabezado[div][contenido].split('=')[1];
 textoArchivoHTML=textoArchivoHTML+'<iframe width="560" height="315" src="https://www.youtube.com/embed/${id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
+"\n";


}



//compruebo si es texto >9
 if(contenido.length>5){
//print("+9"+contenido.substring(2));
if(contenido.substring(2)=="text"){
  //meto un p
textoArchivoHTML=textoArchivoHTML+'<p>${divsEncabezado[div][contenido]}</p>'+"\n";


}

  }else{//compruebo si es texto <=9


if(contenido.substring(1)=="text"){
  textoArchivoHTML=textoArchivoHTML+'<p>${divsEncabezado[div][contenido]}</p>'+"\n";
}else{
//no es texto

if(contenido.length>4){
//compriebo si es una umagen >9
if(contenido.substring(2)=="img"){
  //meto la imagen
  textoArchivoHTML=textoArchivoHTML+'<img src="${divsEncabezado[div][contenido]}" alt="${divsEncabezado[div][contenido]}">'+"\n";
}

}else{
  //compruebo si es una imagen <=9
//meto la imagen
if(contenido.substring(1)=="img"){
 textoArchivoHTML=textoArchivoHTML+'<img src="${divsEncabezado[div][contenido]}" alt="${divsEncabezado[div][contenido]}">'+"\n";
}








}



}





  }



}






 
   
  /*if(divsEncabezado[div][contenido].){

  }*/
}

//cierro div
textoArchivoHTML=textoArchivoHTML+'</div>\n';




}












//cierro el div de encabezado
textoArchivoHTML=textoArchivoHTML+'</div>\n';

//cierro marco
textoArchivoHTML=textoArchivoHTML+'</div>\n';

//cierro body
textoArchivoHTML=textoArchivoHTML+"</body>\n";

//cierro html
textoArchivoHTML=textoArchivoHTML+"</html>\n";


return textoArchivoHTML;


}


/*
_comprimirArchivos(String directory,String htmlFile,String cssFile) async {

  final directoryExternal = await getExternalStorageDirectory();
  final sourceDir = Directory(directory);
  final files = [
    File(sourceDir.path + htmlFile),
    File(sourceDir.path + cssFile)
  ];
  final zipFile = File(directoryExternal!.toString());
  try {
    ZipFile.createFromFiles(
        sourceDir: sourceDir, files: files, zipFile: zipFile);
  } catch (e) {
    print(e);
  }











}



*/




_sendEmail(String ruta)async{
  print("ha llegao al correo");
final Email email = Email(
  body: 'Email body',
  subject: 'Email subject',
  recipients: ['ejimenezco13@icloud.com'],
  attachmentPaths: [ruta.toString()],
  isHTML: false,
);

await FlutterEmailSender.send(email);


}












Widget _crearButtonVistaPrevia(){


return Column(children: <Widget>[
  
  Container(
 height: 50.0,
        width: 50.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Vista Previa'),
        onPressed: (){

/*
*/
_crearHTML().then((value1) {









final route = MaterialPageRoute(

    builder: (context){
return VisualizadorPage(value1,paginaActual);

    }
  );

Navigator.push(context, route);





  

//_read().then((value) => print(value)),


});
        }),

),







]);



}










Widget _crearButtonGuardarWeb(){


return Column(children: <Widget>[
  
  Container(
 height: 50.0,
        width: 50.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn5",
        child: Text('Guardar Web'),
        onPressed: (){

/*
*/
_crearHTML().then((value1) {















  
_write(value1).then((value2)  /*_sendEmail(value)*/{

});
//_read().then((value) => print(value)),


});
        }),

),







]);



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
return HomePage();

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}



Widget  _cardCabecera() {

return InkWell(
    child: Card(
  
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Cabecera'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[



  ],
)*/


    ],
  ),
),
    onTap: () { 
        



 final route = MaterialPageRoute(

    builder: (context){
return EditorEncabezadoPage(paginaActual);

    }
  );

Navigator.push(context, route);







    },
);






}


Widget  _cardCuerpo() {



return Card(
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Cuerpo'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[

TextButton(onPressed: (){}, child: Text('mamaguebo')),
TextButton(onPressed: (){}, child: Text('mamapinga')),

  ],
)*/


    ],
  ),
);




}

Widget  _cardPie() {



return Card(
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Pie'),
  subtitle: Text('Texto'),
),
/*Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <Widget>[

TextButton(onPressed: (){}, child: Text('mamaguebo')),
TextButton(onPressed: (){}, child: Text('mamapinga')),

  ],
)*/


    ],
  ),
);




}






}