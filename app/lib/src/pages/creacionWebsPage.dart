import 'dart:io';
import 'package:ejemplobbdd/src/pages/visualizarWebPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/pages/EditorEncabezadoPage.dart';
import 'package:ejemplobbdd/src/pages/EditorCuerpoPage.dart';
import 'package:ejemplobbdd/src/pages/EditorPiePage.dart';
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














//creo q esta aqui no sirve
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
 x.h1=data["h1"];
 x.h2=data["h2"];
 x.h3=data["h3"];
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
Map estilosDivs={};
String pageBackground="";
Map footer={};



Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombreWeb=data["nombre_web"].toString();
 h1Encabezado=data["h1"][0].toString();
 h2Encabezado=data["h2"][0].toString();
 h3Encabezado=data["h3"][0].toString();
divsEncabezado=data["divs"];
estilosDivs=data['divsStyles'];
pageBackground=data['pageBackground'];
footer=data['footer'];

}



String textoArchivoHTML="";

//abro html

if(pageBackground.toString()!=""){
  if(pageBackground.contains("\$")){
    final ref = FirebaseStorage.instance.ref().child('uploads').child("${pageBackground.replaceFirst("\$", "")}");
var url = await ref.getDownloadURL();
    textoArchivoHTML=textoArchivoHTML+'<html style="background-image: url(${url});background-repeat: no-repeat;background-attachment: fixed;background-size: 100% 100%;">\n';
  }else{
textoArchivoHTML=textoArchivoHTML+'<html style="background-color:${pageBackground}">\n';
  }

  }else{
textoArchivoHTML=textoArchivoHTML+'<html>\n';
  }
//abro head
textoArchivoHTML=textoArchivoHTML+'<head>\n';


//title
textoArchivoHTML=textoArchivoHTML+"<Title> ${nombreWeb.split(".")[2]} </Title>"+"\n";

//h1 del encabezado
if(h1Encabezado!=""){
  String estilos="";
  String url="";
  for (var i = 1; i < 8; i++) {
switch (i) {
  case 1:
  if(data!["h1"][i].toString()!=""){
 estilos=estilos+ "font-weight: ${data["h1"][i].toString()}; ";
  }
   
    
    break;
  case 2:
  if(data!["h1"][i].toString()!=""){
    estilos=estilos+ "font-style: ${data["h1"][i].toString()}; ";
  }

    
  break;
  case 3:
  if(data!["h1"][i].toString()!=""){
    estilos=estilos+ "text-align: ${data["h1"][i].toString()}; ";
  }

  break;
  case 4:
  if(data!["h1"][i].toString()!=""){
    estilos=estilos+ "color: ${data["h1"][i].toString()}; ";
  }





  break;
  case 5:
   if(data!["h1"][i].toString()!=""){
    estilos=estilos+ "font-size: ${data["h1"][i].toString()}px; ";
  }

  break;
   case 6:
   if(data!["h1"][i].toString()!=""){
    estilos=estilos+ "font-family: ${data["h1"][i].toString()}; ";
  }

  break;





 case 7:
   if(data!["h1"][i].toString()!=""){
    url='<a href="${data["h1"][i].toString()}">${h1Encabezado}</a>';
  }

  break;

  
}


}

if(url!=""){

textoArchivoHTML=textoArchivoHTML+'<h1 style="${estilos}">\n'+url+"\n</h1>\n";
}else{
textoArchivoHTML=textoArchivoHTML+'<h1 style="${estilos}">\n'+h1Encabezado+"\n</h1>\n";

}

}

//h2 del encabezado
if(h2Encabezado!=""){
  String url="";
  String estilos="";
  for (var i = 1; i < 8; i++) {
switch (i) {
  case 1:
  if(data!["h2"][i].toString()!=""){
 estilos=estilos+ "font-weight: ${data["h2"][i].toString()}; ";
  }
   
    
    break;
  case 2:
  if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "font-style: ${data["h2"][i].toString()}; ";
  }

    
  break;
  case 3:
  if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "text-align: ${data["h2"][i].toString()}; ";
  }

  break;
  case 4:
 if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "color: ${data["h2"][i].toString()}; ";
  }





  break;
  case 5:
   if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "font-size: ${data["h2"][i].toString()}px; ";
  }

  break;

case 6:
   if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "font-family: ${data["h2"][i].toString()}; ";
  }

  break;

case 7:
   if(data!["h2"][i].toString()!=""){
    url='<a href="${data["h2"][i].toString()}">${h2Encabezado}</a>';
  }

  break;

  
}


}

if(url!=""){
  
textoArchivoHTML=textoArchivoHTML+'<h2 style="${estilos}">\n'+url+"\n</h2>\n";
}else{
textoArchivoHTML=textoArchivoHTML+'<h2 style="${estilos}">\n'+h2Encabezado+"\n</h2>\n";

}
}

//h3 del encabezado
if(h3Encabezado!=""){
String url="";
String estilos="";
  for (var i = 1; i < 8; i++) {
switch (i) {
  case 1:
  if(data!["h3"][i].toString()!=""){
 estilos=estilos+ "font-weight: ${data["h3"][i].toString()}; ";
  }
   
    
    break;
  case 2:
  if(data!["h3"][i].toString()!=""){
    estilos=estilos+ "font-style: ${data["h3"][i].toString()}; ";
  }

    
  break;
  case 3:
  if(data!["h3"][i].toString()!=""){
    estilos=estilos+ "text-align: ${data["h3"][i].toString()}; ";
  }

  break;
  case 4:
 if(data!["h3"][i].toString()!=""){
    estilos=estilos+ "color: ${data["h3"][i].toString()}; ";
  }





  break;
  case 5:
   if(data!["h2"][i].toString()!=""){
    estilos=estilos+ "font-size: ${data["h3"][i].toString()}px; ";
  }

  break;
case 6:
   if(data!["h3"][i].toString()!=""){
    estilos=estilos+ "font-family: ${data["h3"][i].toString()}; ";
  }

  break;


case 7:
   if(data!["h3"][i].toString()!=""){
    url='<a href="${data["h3"][i].toString()}">${h3Encabezado}</a>';
  }

  break;

  
}


}

if(url!=""){
 
textoArchivoHTML=textoArchivoHTML+'<h3 style="${estilos}">\n'+url+"\n</h3>\n";
}else{
textoArchivoHTML=textoArchivoHTML+'<h3 style="${estilos}">\n'+h3Encabezado+"\n</h3>\n";

}



}




//cierro head
textoArchivoHTML=textoArchivoHTML+'</head>\n';



//abro body
textoArchivoHTML=textoArchivoHTML+"<body>\n";

//abro el div del marco
textoArchivoHTML=textoArchivoHTML+'<div class="marco">\n';

//abro el div encabezado
textoArchivoHTML=textoArchivoHTML+'<div class="encabezado">\n';





for (var div in divsEncabezado.keys.toList().reversed) {
 
  //pongo cada div y su estilo
String estiloDivActual="";
if(estilosDivs.containsKey(div)){
  
   estiloDivActual=estiloDivActual+ "background-color:${estilosDivs[div]}; ";




  
}



  textoArchivoHTML=textoArchivoHTML+'<div class="${div}" style="${estiloDivActual}">\n';
for (var i = 0; i < divsEncabezado[div].keys.length; i++) {

if(divsEncabezado[div].containsKey("${i}text")){
String url="";
String estilos="";
  for (var j = 1; j < 8; j++) {
switch (j) {
  case 1:
  if(divsEncabezado[div]["${i}text"][j].toString()!=""){
 estilos=estilos+ "font-weight: ${divsEncabezado[div]["${i}text"][j].toString()}; ";
  }
   
    
    break;
  case 2:
  if(divsEncabezado[div]["${i}text"][j].toString()!=""){
    estilos=estilos+ "font-style: ${divsEncabezado[div]["${i}text"][j].toString()}; ";
  }

    
  break;
  case 3:
  if(divsEncabezado[div]["${i}text"][j].toString()!=""){
    estilos=estilos+ "text-align: ${divsEncabezado[div]["${i}text"][j].toString()}; ";
  }

  break;
  case 4:
   if(divsEncabezado[div]["${i}text"][j]!=""){
    estilos=estilos+ "color: ${divsEncabezado[div]["${i}text"][j]}; ";
  }




  break;
  case 5:
   if(divsEncabezado[div]["${i}text"][j].toString()!=""){
    estilos=estilos+ "font-size: ${divsEncabezado[div]["${i}text"][j].toString()}px; ";
  }

  break;
case 6:
   if(divsEncabezado[div]["${i}text"][j].toString()!=""){
    estilos=estilos+ "font-family: ${divsEncabezado[div]["${i}text"][j].toString()}; ";
  }

  break;



case 7:
   if(divsEncabezado[div]["${i}text"][j].toString()!=""){
    url='<a href="${divsEncabezado[div]["${i}text"][j].toString()}">${divsEncabezado[div]["${i}text"][0]}</a>';
  }

  break;

  
}


}

if(url!=""){
 textoArchivoHTML=textoArchivoHTML+'<p style="${estilos}">${url}</p>'+"\n";

}else{
textoArchivoHTML=textoArchivoHTML+'<p style="${estilos}">${divsEncabezado[div]["${i}text"][0]}</p>'+"\n";

}

}else if(divsEncabezado[div].containsKey("${i}img")){
   
final ref = FirebaseStorage.instance.ref().child('uploads').child("${divsEncabezado[div]["${i}img"][0]}");
var url = await ref.getDownloadURL();
textoArchivoHTML=textoArchivoHTML+'<img src="${url}" alt="${url}">'+"\n";

}else{
String id=divsEncabezado[div]["${i}video"][0].split('=')[1];
 textoArchivoHTML=textoArchivoHTML+'<iframe width="560" height="315" src="https://www.youtube.com/embed/${id}?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
+"\n";

}








  /*
//print(listaKeys[i].toString()+" "+"esto compara "+i.toString());
  if(listaKeys[i].toString()=="${i}text"){
    print("soy un txt");
textoArchivoHTML=textoArchivoHTML+'<p>${divsEncabezado[div][listaKeys[i]]}</p>'+"\n";

  }else if(listaKeys[i].toString()=="${i}img"){

 textoArchivoHTML=textoArchivoHTML+'<img src="${divsEncabezado[div][listaKeys[i]]}" alt="${divsEncabezado[div][listaKeys[i]]}">'+"\n";





  }else if(listaKeys[i].toString()=="${i}video"){
    print("soy un video");
    print("video"+divsEncabezado[div][listaKeys[i]].split('=').toString());
/*
String id=divsEncabezado[div][listaKeys[i]].split('=')[1];
 textoArchivoHTML=textoArchivoHTML+'<iframe width="560" height="315" src="https://www.youtube.com/embed/${id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
+"\n";


*/
*/

  }
textoArchivoHTML=textoArchivoHTML+'</div>\n';




}












/*

for (var div in divsEncabezado.keys.toList().reversed) {
  
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


*/









//cierro el div de encabezado
textoArchivoHTML=textoArchivoHTML+'</div>\n';

//cierro marco
textoArchivoHTML=textoArchivoHTML+'</div>\n';



//creo footer

String url="";
String estilos="";
  for (var j = 1; j < 8; j++) {
switch (j) {
  case 1:
  if(footer["texto"][j].toString()!=""){
 estilos=estilos+ "font-weight: ${footer["texto"][j].toString()}; ";
  }
   
    
    break;
  case 2:
  if(footer["texto"][j].toString()!=""){
    estilos=estilos+ "font-style: ${footer["texto"][j].toString()}; ";
  }

    
  break;
  case 3:
  if(footer["texto"][j].toString()!=""){
    estilos=estilos+ "text-align: ${footer["texto"][j].toString()}; ";
  }

  break;
  case 4:
   if(footer["texto"][j]!=""){
    estilos=estilos+ "color: ${footer["texto"][j]}; ";
  }




  break;
  case 5:
   if(footer["texto"][j].toString()!=""){
    estilos=estilos+ "font-size: ${footer["texto"][j].toString()}px; ";
  }

  break;
case 6:
   if(footer["texto"][j].toString()!=""){
    estilos=estilos+ "font-family: ${footer["texto"][j].toString()}; ";
  }

  break;



case 7:
   if(footer["texto"][j].toString()!=""){
    url='<a href="${footer["texto"][j].toString()}">${footer["texto"][0]}</a>';
  }

  break;

  
}


}

String imgURL="";
if(footer["img"][0]!=""){

final ref = FirebaseStorage.instance.ref().child('uploads').child("${footer["img"][0].replaceFirst("\$", "")}");
var urlBuena= await ref.getDownloadURL();
imgURL= "<img style='display:inline-block; width:5 ; height:5;' src='${urlBuena}'  />";
}

print(imgURL);







if(url!=""){
  textoArchivoHTML=textoArchivoHTML+"<footer><div class='row'>	<div class='site-info'>${imgURL}<p style='${estilos}'>${url}</p></div></div></footer>";


}else{
    textoArchivoHTML=textoArchivoHTML+"<footer><div class='row'>	<div style=display:inline-block>${imgURL}<p style='${estilos};display:inline-block'>${footer['texto'][0]}</p></div></div></footer>";


}





	
	
			

		
	






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


String urlFinal="";

List url=value1.split(">");
if(!url[0].toString().contains("background-color")){

List url2=url[0].toString().split(")");
List url3=url2[0].toString().split("(");
if(url3.length>1){
 urlFinal=url3[1];
}

}




final route = MaterialPageRoute(

    builder: (context){
return VisualizadorPage(value1,urlFinal,paginaActual);

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


return InkWell(
    child: Card(
  
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Cuerpo'),

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
return EditorCuerpoPage(paginaActual);

    }
  );

Navigator.push(context, route);







    },
);









}

Widget  _cardPie() {

return InkWell(
    child: Card(
  
  elevation:1.0 ,//sombra
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    
    children: <Widget>[
ListTile(
  leading: Icon(Icons.photo_album),
  title: Text('Pie de Página'),
//sbutitle
),


    ],
  ),
),
    onTap: () { 
        



 final route = MaterialPageRoute(

    builder: (context){
return EditorPiePage(paginaActual);

    }
  );

Navigator.push(context, route);







    },
);



}






}

