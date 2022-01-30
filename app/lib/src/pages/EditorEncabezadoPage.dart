import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path; 
import 'dart:io';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditorEncabezadoPage extends StatefulWidget {
  
 @override
  _EditorEncabezadoPage createState() => _EditorEncabezadoPage();
  
}

class _EditorEncabezadoPage extends State<EditorEncabezadoPage>{
  Color colorTargeta=Colors.white;
   PickedFile? imageFile=null;
    String nombreImagen="Default";
     String? currentUser = FirebaseAuth.instance.currentUser!.email;
 // Encabezado encabezadoActual=cargarDeBBDD() as Encabezado;

 @override
  Widget build(BuildContext context) {
    
    

    return FutureBuilder (
      
      future: cargarDeBBDD(),
      
      builder: ( context,AsyncSnapshot<Encabezado> snapshot  ){
  var h1="Titulo";
var h2="Subtitulo";
var h3="Más texto";
if (!snapshot.hasData) {
     return Container(
       child: Center(
         child: CircularProgressIndicator(),
       ),
     );
}else{


  Encabezado encabezadoActual=snapshot.data!;
  
encabezadoActual.aniadirAContenedores();

encabezadoActual.contenedores.reversed;




if(encabezadoActual.getH1.toString().isNotEmpty){
h1=encabezadoActual.getH1;
}


if(encabezadoActual.getH2.toString().isNotEmpty){
h2=encabezadoActual.getH2;
}

if(encabezadoActual.getH3.toString().isNotEmpty){
h3=encabezadoActual.getH3;
}







 


  return Scaffold(
    body: Column(

children: <Widget>[
_crearButtonVolver(encabezadoActual),
TextField(
  
      
      decoration: InputDecoration(
        
        hintText: h1.toString(),
        //labelText: 'Password',
        
        
      ),

      onChanged: (valor) =>setState(() {
        encabezadoActual.setH1 = valor;
        encabezadoActual.cargarABBDD();
       
      }),
   
    ),


TextField(
  
     
      decoration: InputDecoration(
        
        hintText: h2.toString(),
        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {

      encabezadoActual.setH2 = valor;
      encabezadoActual.cargarABBDD();
      })
    ),


TextField(
  
      
      decoration: InputDecoration(
        
        hintText: h3.toString(),




        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       encabezadoActual.setH3 = valor;
       encabezadoActual.cargarABBDD();
      })
    ),
    
    Expanded(child: _crearListaDivs(encabezadoActual.contenedores,encabezadoActual,colorTargeta)),


Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),




],

),
  );
}
      },
    );
  }











Widget _crearListaDivs(List<dynamic> lista,Encabezado x,colorTargetaX){
  Color colorTargeta=colorTargetaX;
  lista.reversed;
  
Encabezado encabezadoActual=x;
return ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: lista.length,
  itemBuilder: (BuildContext context, int index) {
    

List<int> newLista=[];


int numMayor=0;

for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {

newLista.add(int.parse(item[0]));

}
newLista.sort();





 return InkWell(
  child: Card(
  elevation:1.0 ,//sombra
  color: colorTargeta,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
      SizedBox(height: 30.0 ,),

Text(lista[index].nombre),
    
SizedBox(height: 20.0 ,),
Row(
  children: <Widget>[

Expanded(child:

ListView.builder(
   shrinkWrap: true,
  physics: ScrollPhysics(),
  padding: const EdgeInsets.all(8),
  itemCount: newLista.length,
  itemBuilder: (BuildContext context, int index2) {






//print(lista[index].elementos.keys.toString() );
//index2=index2+1;

if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]!=null){



return TextField(
  
      
      decoration: InputDecoration(
        

        hintText: encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"],




      
        
        
      ),
      onChanged: (valor) =>setState(() {
      encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"] = valor;
      
      //encabezadoActual.aniadirAlMapa();
      //encabezadoActual.cargarABBDD();
      
      }),
      
       onSubmitted: (value){
         encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]=value;
        
        
/*
Map mapaActual={};
int i=0;
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {

if(item.toString().contains("t")){
   mapaActual.putIfAbsent("${i}text", () => encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);

print(item);
}else if(item.toString().contains("img")){
mapaActual["${i}img"]=encabezadoActual.contenedores[index].elementos["${i}img"];

}else{

mapaActual["${i}video"]=encabezadoActual.contenedores[index].elementos["${i}video"];


}

 
  i++;
}



encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]=mapaActual;


*/


  encabezadoActual.cargarABBDD();
 











       },
    );

















//si armario[indiceActual].contains(text) 
//then
//return textField
//else if armario[indiceActual].contains(img) 
// return ImageIcon
//else if armario[indiceActual].contains(video)
//return Video 


}else if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}img"]!=null){



 return FutureBuilder (
      
      future: getImageFromDatabase(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}img"]),
      
      builder: ( context,AsyncSnapshot<Widget> snapshot  ){
  
if (!snapshot.hasData) {
     return Container(
       child: Center(
         child: CircularProgressIndicator(),
       ),
     );
}else{

return snapshot.data!;




}
      });















}else{




 return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/YouTube_social_white_square_%282017%29.svg/800px-YouTube_social_white_square_%282017%29.svg.png");







//ponerle el future
//y arreglar el resto
/*
String  urlImagen=getYoutubeThumbnail(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}video"]);
if(urlImagen.isNotEmpty){
return Image.network(urlImagen);







}else{
  return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/YouTube_social_white_square_%282017%29.svg/800px-YouTube_social_white_square_%282017%29.svg.png");

}
*/



}








    






  })

),























    

  ],
  
),



Row(

  children: <Widget>[
SizedBox(width: 20.0 ,),
TextButton(onPressed: (){//el del texto


int x=0;

int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}text", () => "Text");




 setState(() {







  encabezadoActual.cargarABBDD();








 });

}, child: Text("+T")),
TextButton(onPressed: (){
  

  
  
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
         
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(

decoration: InputDecoration(
        
        hintText: "textomamaguebo",
        //labelText: 'Password',
        
        
      ),

      onChanged: (valor) =>setState(() {
       nombreImagen = valor;
        
       
      }),









                ),
                Card(
                  child:( imageFile==null)?Text("Elige una imagen"): Image.file( io.File(  imageFile!.path)),
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  onPressed: (){
                   
                   



showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){
                _openGallery(context).then((value){






if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){

//print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString());


int x=0;

int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => currentUser!+nombreImagen);




 setState(() {







  encabezadoActual.cargarABBDD();

 Navigator.of(context).pop();


imageFile=null;



 });











































});




}

























                  
                });










              },
            title: Text("Gallery"),
              leading: Icon(Icons.account_box,color: Colors.blue,),
        ),

            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){
                _openCamera(context).then((value){






if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){

//print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString());


int x=0;

int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => currentUser!+nombreImagen);




 setState(() {







  encabezadoActual.cargarABBDD();

 Navigator.of(context).pop();


imageFile=null;



 });











































});




}

























                  
                });
              },
              title: Text("Camera"),
              leading: Icon(Icons.camera,color: Colors.blue,),
            ),
          ],
        ),
      ),);
    });








                   
                  },
                  child: Text("Select Image"),

                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
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
  
  


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


}, child: Text("+Img")),
TextButton(onPressed: (){//el de videos

String url="";

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Añadir video de Youtube'),
          content: TextField(

            onChanged: (valor) =>setState(() {
              url=valor;
       
      }),
          ),
         
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){


if(url.isNotEmpty){



int x=0;

int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}video", () =>url);




 setState(() {







  encabezadoActual.cargarABBDD();

 Navigator.of(context).pop();






 });



}else{
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("No has introducido una url"),
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






















                //Navigator.of(context).pop();
        },
            ),

  TextButton(
              child: Text('Cancelar'),
              onPressed: (){

  Navigator.of(context).pop();

              })

          ],
        );

      }

    );







}, child: Text("+Video")),
TextButton(onPressed: (){//el de borrar


int x=0;

int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}


encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].remove(elementoMayor);
encabezadoActual.cargarABBDD();

setState(() {
  
});


}, child: Text("-Eliminar elemento")),

  ],
)




    ],
  ),
),

 onTap: () { 
     /*
setState(() {
  this.colorTargeta=Colors.red.shade100;
}
);



*/

    }

);




































    
  }
);







}



 
 Future<void> _openGallery(BuildContext context) async{
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile!;

    });

    Navigator.pop(context);
  }

  Future<void> _openCamera(BuildContext context)  async{
      // ignore: deprecated_member_use
      final pickedFile = await ImagePicker().getImage(
            source: ImageSource.camera ,
            );
            setState(() {
            imageFile = pickedFile!;
      });
      Navigator.pop(context);
  }





Future<Widget> getImageFromDatabase(String imageName) async {

  
final ref = FirebaseStorage.instance.ref().child('uploads').child(imageName);
var url = await ref.getDownloadURL();
return Image.network(url);




} 




Future uploadImageToFirebase(BuildContext context) async {

if(imageFile==null){
 
}else{

    String fileName = path.basename(imageFile!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child('uploads').child('/${currentUser!+nombreImagen}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': nombreImagen});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(imageFile!.path), metadata);

    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
    
    setState((){

    })


    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });




  }
}


Future<Encabezado> cargarDeBBDD() async {

var nombre;
var h1;
var h2;
var h3;
var mapaDivs;

Encabezado x=Encabezado.constructor2();
DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc("prueba").collection("encabezado").doc("unique");
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










/*

  Future<Encabezado> readJson() async {

    final String response = await rootBundle.loadString('assets/jsonBase.json');
    final datos =json.decode(response);
    


   return encabezadoActual.cargarDeBBDD();
    
  
}*/
  

















/*

 String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}
*/


String getYoutubeThumbnail(String videoUrl) {
  final Uri? uri = Uri.tryParse(videoUrl);
  if (uri == null) {
    return "";
  }

  return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
}




Widget _crearButtonVolver(Encabezado x){
  
  Encabezado xNow=x;


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
/*sleep(Duration(seconds:1));
xNow.aniadirAlMapa();
xNow.cargarABBDD();*/
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