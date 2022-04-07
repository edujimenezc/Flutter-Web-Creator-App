// ignore_for_file: must_be_immutable

import 'dart:collection';
import 'dart:convert';
import 'package:ejemplobbdd/src/classes/ColorExt.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path/path.dart' as path; 
import 'dart:io';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditorPiePage extends StatefulWidget {
  String paginaActual="";
  EditorPiePage(String nombreWeb){
paginaActual=nombreWeb;

  }
 @override
  _EditorPiePage createState() => _EditorPiePage(paginaActual);
  
}

class _EditorPiePage extends State<EditorPiePage>{
   String paginaActual="";
  _EditorPiePage(String nombreWeb){
paginaActual=nombreWeb;

  }
  Color colorTargeta=Colors.white;
   PickedFile? imageFile=null;
   String fondoImagen="";
    String nombreImagen="Default";
     String? currentUser = FirebaseAuth.instance.currentUser!.email;


 @override
  Widget build(BuildContext context) {
    
    

    return FutureBuilder (
      
      future: cargarDeBBDD(),
      
      builder: ( context,AsyncSnapshot<Encabezado> snapshot  ){
  var h1="";
var h2="";
var h3="";
var h1Hint="Título";
var h2Hint="Subtítulo";
var h3Hint="Subsubtítulo";

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
fondoImagen=encabezadoActual.pageBackgroundURL;


String fondoActual=encabezadoActual.pageBackground;
NetworkImage imgFondoX;
  Color scaffoldColor=Colors.white;

if(fondoActual!=""){
if(fondoActual.contains("\$")){
 


return FutureBuilder(
  
  future: getImageFromDatabaseFondo(fondoActual), builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

if (!snapshot.hasData) {
     return Container(
       child: Center(
         child: CircularProgressIndicator(),
       ),
     );
}else{
  scaffoldColor=Colors.transparent;
  String imgUrl=snapshot.data!;

return containerCentralImgFondo(imgUrl,encabezadoActual,scaffoldColor,h1Hint,h2Hint,h3Hint);


}








    },
  
);
 



}
else{
scaffoldColor=scaffoldColor.fromHex(fondoActual);
  imgFondoX=NetworkImage("https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif?20151024034921");

}

}


return containerCentral(encabezadoActual,scaffoldColor,h1Hint,h2Hint,h3Hint);

 

}
      },
    );
  }



Widget containerCentralImgFondo(String url,Encabezado encabezadoActual,Color scaffoldColor,String h1Hint,String h2Hint,String h3Hint){
 return Container(
decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage("${url}"),
      fit: BoxFit.cover)
    ),
    child: Scaffold(
    backgroundColor: scaffoldColor,
    body: Container(
 alignment: Alignment.center,
 child: Column(children: <Widget>[
Column(

  children: <Widget>[
  
 _crearButtonVolver(),

botonEstilosFondo(encabezadoActual),

crearFooter(encabezadoActual)




]),

  



],
),

),
  ),

);
 








}




Widget containerCentral(Encabezado encabezadoActual,Color scaffoldColor,String h1Hint,String h2Hint,String h3Hint){

  return Container(
decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif?20151024034921"),
      fit: BoxFit.cover)
    ),
  child: Scaffold(
    backgroundColor: scaffoldColor,
    body: Container(
 alignment: Alignment.center,
 child: Column(children: <Widget>[
Column(

  children: <Widget>[
  
 _crearButtonVolver(),

botonEstilosFondo(encabezadoActual),

crearFooter(encabezadoActual)




]),

  



],
),

),
  ),
);
 
}


Future<String> urlFondo(String fondoActual) async {
  final ref = FirebaseStorage.instance.ref().child('uploads').child("${fondoActual}");
  String url="";
await ref.getDownloadURL().then((value) =>  url=value);
return url;
}

Widget crearImgFooter(Encabezado encabezadoActual){


if(encabezadoActual.footer["img"][0]==""){

return Column(children: [
Text("No has seleccionado ninguna imagen"),
crearBotonImagen(encabezadoActual,"Seleccionar imagen"),


]);










}else{

return Column(
   
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [

FutureBuilder (
      
      future: getImageFromDatabaseFondo(encabezadoActual.footer["img"][0]),
      
      builder: ( context,AsyncSnapshot<String> snapshot  ){
  
if (!snapshot.hasData) {
     return Container(
       child: Center(
         child: CircularProgressIndicator(),
       ),
     );
}else{

return Image.network(snapshot.data!,height: 150,
        width: 150,);




}
      }),
      Row(children: [

 crearBotonImagen(encabezadoActual,"Cambiar imagen"),
        _crearButtonEliminarImagen(encabezadoActual)
      ],)
     

      




],);



}










}
Widget _crearButtonEliminarImagen(Encabezado encabezadoActual){


return FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn3",
        child: Text('Eliminar imagen'),
        onPressed: (){
encabezadoActual.footer["img"][0]="";
setState(() {
  encabezadoActual.cargarABBDD(paginaActual);
});


        });



}

Widget crearBotonImagen(Encabezado encabezadoActual, String mensaje){

return FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text(mensaje),
        onPressed: (){

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
                Text("Selecciona una imagen"),
                TextField(

decoration: InputDecoration(
        
        hintText: "Nombre para la Imagen",
       
        
        
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
                  onPressed: () async {

                    bool nombreExiste=false;




firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
    .ref()
    .child('images')
    .child('defaultProfile.png');
var listado=await FirebaseStorage.instance.ref().child('uploads').list().then((value){
for (var item in value.items) {
  if(item.fullPath.toString()=="uploads/"+currentUser.toString()+nombreImagen){

nombreExiste=true;
  }
}

if(nombreExiste){



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('¡Ya estas usando ese nombre!'),
          
          content: Expanded(child: Text("Ya estas usando ese nombre para una imagen, si usas el mismo nombre la imagen se sobreescribirá \n ¿Deseas sobreescribir la imagen?")),
          actions: <Widget>[
           
            TextButton(
              child: Text('No'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: (){

                Navigator.of(context).pop();





showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Elige una opción",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){










                _openGallery(context).then((value){






if(imageFile!=null){





if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){

  encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;


 setState(() {


  encabezadoActual.cargarABBDD(paginaActual);

 
imageFile=null;



 });


});




}

    
                }});

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
 encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;



 setState(() {

  encabezadoActual.cargarABBDD(paginaActual);

// Navigator.of(context).pop();


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
            )
          ],
        );

      }

    );





}else{

showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Elige una opción",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){

                _openGallery(context).then((value){






if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){


  encabezadoActual.footer["img"][0]="\$"+currentUser!+nombreImagen;


 setState(() {



  encabezadoActual.cargarABBDD(paginaActual);

 Navigator.of(context).pop();


imageFile=null;



 });


});


}

           
                });

              },
            title: Text("Galeria"),
              leading: Icon(Icons.account_box,color: Colors.blue,),
        ),

            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){
                _openCamera(context).then((value){


if(imageFile!=null){
    
uploadImageToFirebase(context).then((value){
 encabezadoActual.footer["img"][0]="\$"+currentUser!+nombreImagen;
 setState(() {

  encabezadoActual.cargarABBDD(paginaActual);

 Navigator.of(context).pop();


imageFile=null;

 });

});

}

                });
              },
              title: Text("Camara"),
              leading: Icon(Icons.camera,color: Colors.blue,),
            ),
          ],
        ),
      ),);
    });

}

});

      
                  },
                  child: Text("Seleccionar imagen"),

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
                 Navigator.of(context).pop();







              },
            ),
          ],
        );

      }

    );
              











});
        }













Widget crearFooter(Encabezado encabezadoActual){
return Container(

  child: Column(
    children: [
      
Text("Texto del Pie de Página"),

textoFooter(encabezadoActual),
Text("Imagen del Pie de Página"),
crearImgFooter(encabezadoActual),
    ],
  ),
);



}

Widget botonFondoImagen(Encabezado encabezadoActual){

return FloatingActionButton(
              child: Text('Sube una imagen'),
              onPressed: (){
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
                Text("Selecciona una imagen"),
                TextField(

decoration: InputDecoration(
        
        hintText: "Nombre para la Imagen",
       
        
        
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
                  onPressed: () async {

                    bool nombreExiste=false;




firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
    .ref()
    .child('images')
    .child('defaultProfile.png');
var listado=await FirebaseStorage.instance.ref().child('uploads').list().then((value){
for (var item in value.items) {
  if(item.fullPath.toString()=="uploads/"+currentUser.toString()+nombreImagen){

nombreExiste=true;
  }
}

if(nombreExiste){



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('¡Ya estas usando ese nombre!'),
          
          content: Expanded(child: Text("Ya estas usando ese nombre para una imagen, si usas el mismo nombre la imagen se sobreescribirá \n ¿Deseas sobreescribir la imagen?")),
          actions: <Widget>[
           
            TextButton(
              child: Text('No'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: (){

                Navigator.of(context).pop();





showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Elige una opción",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){










                _openGallery(context).then((value){






if(imageFile!=null){





if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){

  encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;


 setState(() {


  encabezadoActual.cargarABBDD(paginaActual);

 
imageFile=null;



 });


});




}

    
                }});

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
 encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;



 setState(() {

  encabezadoActual.cargarABBDD(paginaActual);

// Navigator.of(context).pop();


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
            )
          ],
        );

      }

    );





}else{

showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Elige una opción",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){

                _openGallery(context).then((value){






if(imageFile!=null){


      
uploadImageToFirebase(context).then((value){


  encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;


 setState(() {



  encabezadoActual.cargarABBDD(paginaActual);

 Navigator.of(context).pop();


imageFile=null;



 });


});


}

           
                });

              },
            title: Text("Galeria"),
              leading: Icon(Icons.account_box,color: Colors.blue,),
        ),

            Divider(height: 1,color: Colors.blue,),
            ListTile(
              onTap: (){
                _openCamera(context).then((value){


if(imageFile!=null){
    
uploadImageToFirebase(context).then((value){
 encabezadoActual.pageBackground="\$"+currentUser!+nombreImagen;
 setState(() {

  encabezadoActual.cargarABBDD(paginaActual);

 Navigator.of(context).pop();


imageFile=null;

 });

});

}

                });
              },
              title: Text("Camara"),
              leading: Icon(Icons.camera,color: Colors.blue,),
            ),
          ],
        ),
      ),);
    });

}

});

      
                  },
                  child: Text("Seleccionar imagen"),

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
                 Navigator.of(context).pop();







              },
            ),
          ],
        );

      }

    );
               
        },
            );

}



Widget botonEstilosFondo(Encabezado encabezadoActual){


 return FloatingActionButton(
              child: Text('Editar el Fondo'),
              onPressed: (){
               showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Edita el fondo de la Web'),
          
          content: Column(
mainAxisSize: MainAxisSize.min,
children: [

colorPicker(encabezadoActual, "pageBackground"),

botonFondoImagen(encabezadoActual),



],

          ),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){

                Navigator.of(context).pop();
                final route = MaterialPageRoute(

    builder: (context){
return EditorPiePage(paginaActual);

    }
  );

Navigator.push(context, route);
        },
            ),
          ],
        );

      }

    );
               
        },
            );











}



Widget textoFooter(Encabezado encabezadoActual){
FontWeight bold =FontWeight.normal;
FontStyle italic=FontStyle.normal;
TextAlign alineacion=TextAlign.left;
Color color=Colors.black;
double tamanio=30;
if(encabezadoActual.footer["texto"][1]!=""){
bold=FontWeight.bold;
}
if(encabezadoActual.footer["texto"][2]!=""){
italic=FontStyle.italic;
}
if(encabezadoActual.footer["texto"][3]!=""){
if(encabezadoActual.footer["texto"][3]=="center"){
alineacion=TextAlign.center;
}else if(encabezadoActual.footer["texto"][3]=="right"){
alineacion=TextAlign.right;
}else{
}
}

if(encabezadoActual.footer["texto"][4]!=""){
color=color.fromHex(encabezadoActual.footer["texto"][4]);
}
if(encabezadoActual.footer["texto"][5]!=""){
tamanio=double.parse(encabezadoActual.footer["texto"][5]);
}






TextStyle estilo=TextStyle(fontWeight: bold,fontStyle: italic,fontSize: tamanio,color: color);

return TextField(
  textAlign: alineacion,
  style: estilo,
      
      decoration: InputDecoration(
hintStyle: estilo,
        suffixIcon: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn10",
        child: Text('Editar'),
        
        onPressed: (){

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Edición del texto'),
          













          
          content: Column(
            mainAxisSize:MainAxisSize.min,
children: [



Row(

children: [
SizedBox(width: 50),
FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn20",
        child: Text('Negrita'),
        onPressed: (){



  bool estaYa=false;
 
 if(encabezadoActual.footer["texto"][1]=="bold"){
   estaYa=true;
 }






     if(estaYa==false){
encabezadoActual.footer["texto"][1]="bold";
     
       
}else{

encabezadoActual.footer["texto"][1]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 
     setState(() {
       
     });
    


        }),
SizedBox(width: 50),
FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn21",
        child: Text('Cursiva'),
        onPressed: (){



  bool estaYa=false;
 
 if(encabezadoActual.footer["texto"][2]=="italic"){
   estaYa=true;
 }






     if(estaYa==false){
encabezadoActual.footer["texto"][2]="italic";
      
       
}else{

encabezadoActual.footer["texto"][2]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 
     setState(() {
       
     });
    



        }),










],


          ),

SizedBox(height: 30),
Text("Alineación"),
SizedBox(height: 15),
Row(



children: [
SizedBox(width: 10),

FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn21",
        child: Text('Izquierda'),
        onPressed: (){




  bool estaYa=false;
 
 if(encabezadoActual.footer["texto"][3]=="left"){
   estaYa=true;
 }






     if(estaYa==false){
encabezadoActual.footer["texto"][3]="left";
     
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 
     setState(() {
       
     });
    


        }),
  SizedBox(width: 20), 
FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn21",
        child: Text('Centro'),
        onPressed: (){




  bool estaYa=false;
 
 if(encabezadoActual.footer["texto"][3]=="center"){
   estaYa=true;
 }






     if(estaYa==false){
encabezadoActual.footer["texto"][3]="center";
      
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 
     setState(() {
       
     });
    


        }),
   SizedBox(width: 20), 
FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn21",
        child: Text('Derecha'),
        onPressed: (){



  bool estaYa=false;
 
 if(encabezadoActual.footer["texto"][3]=="right"){
   estaYa=true;
 }






     if(estaYa==false){
encabezadoActual.footer["texto"][3]="right";
      
     }

 encabezadoActual.cargarABBDD(paginaActual);
 
     setState(() {
       
     });
    



        })





],




),
SizedBox(height: 20), 
Text("Color"),

colorPicker(encabezadoActual,"footer"),

SizedBox(height: 20), 

Text("Tamaño"),
dropDown(["14","20","30","40","50","70"].toList(),encabezadoActual,5),

SizedBox(height: 20), 
//para meter las google fonts seria aqui
Text("Tipo de letra"),
dropDown(["Arial","Verdana","Helvetica","Tahoma","'Trebuchet MS'","'Times New Roman'","Georgia","'Courier New'","'Brush Script MT'"].toList(),encabezadoActual,6),

aniadirURL(encabezadoActual),
SizedBox(height: 20),



],








            
          ),
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


        }),
        hintText:encabezadoActual.footer["texto"][0],
        
       
        
        
      ),

      onChanged: (valor) =>setState(() {
        encabezadoActual.footer["texto"][0] = valor;
        encabezadoActual.cargarABBDD(paginaActual);
       
      }),
   
    );


}

Widget colorPicker(Encabezado encabezadoActual,String posicionHTML){
return ElevatedButton(
                        onPressed: (){
                          Color mycolor=Colors.lightBlue;
                          
switch(posicionHTML) { 
                                                        
                                                          case "footer": {  
                                                            if(encabezadoActual.footer["texto"][4]!=""){
                                                             mycolor= mycolor.fromHex(encabezadoActual.footer["texto"][4]);
                                                            }
                                                             
                                                   

                                                          }
                                                          break;
                                                           case "pageBackground": {  
                                                            if((encabezadoActual.pageBackground!="") && (!encabezadoActual.pageBackground.contains("\$"))){
                                                             mycolor= mycolor.fromHex(encabezadoActual.pageBackground);
                                                            }
                                                             
                                                   

                                                          }
                                                          break;
                                                         
                                                       
                                                        
                                                          default: { print("Invalid choice"); } 
                                                          break; 
                                                      } 
                                                    

                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                      title: Text('Selecciona un color'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: mycolor, //default color
                                          onColorChanged: (Color color){ //on color picked
                                              setState(() {
                                                mycolor = color;
                                              
                                                    switch(posicionHTML) { 
      case "footer": { 
      encabezadoActual.footer["texto"][4]=mycolor.toHex();
        encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     
      case "pageBackground": {  
        
encabezadoActual.pageBackground=mycolor.toHex();
 encabezadoActual.cargarABBDD(paginaActual);
       } 
      break;  
     
     
   
       






   }

                                          



















                                                
                                               } );
                                          }, 
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); //dismiss the color picker
                                          },
                                        ),
                                      ],
                                  );
                              }
                            ); 


                        },
                        child: Text("Cambiar Color"),
                    );


}

Widget aniadirURL(Encabezado encabezadoActual){
  String x="";
   x=  encabezadoActual.footer["texto"][7];

if(x==""){
  x="Introduce la URL";
}

return FloatingActionButton(onPressed: () {
  
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Añadir url'),
          content: TextField(
             decoration: InputDecoration(
        
        hintText: x,
       
        
        
      ),
            onChanged: (valor) =>setState(() {
              x=valor;
       
      }),
          ),
         
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){

if(x.isNotEmpty){
 encabezadoActual.footer["texto"][7]=x;

   Navigator.of(context).pop();
encabezadoActual.cargarABBDD(paginaActual);

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


},







);












}


Widget dropDown(List<String> elementos,Encabezado encabezadoActual,int parteCSS){
  String x="";
   x=  encabezadoActual.footer["texto"][parteCSS];

if(x==""){
 x=elementos[0];

}

return DropdownButtonFormField<String>(
  onChanged: (valueX) {
     setState(() {
      x=valueX.toString();
      encabezadoActual.footer["texto"][parteCSS]=x;
     encabezadoActual.cargarABBDD(paginaActual);
      
   });
  
  },
  
 onSaved: (valueX) {
   setState(() {
      x=valueX.toString();
     
   });
  
 },
 value: x,
  items: elementos.map((String value) {
    
    return DropdownMenuItem<String>(
      
      value: value,
      child: new Text(value),
      onTap: () {
       
       
 setState(() {
      x=value.toString();
   });


      },
      
    );
  }).toList(),
  
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

Future<String> getImageFromDatabaseFondo(String imageName) async {

  final ref = FirebaseStorage.instance.ref().child('uploads').child("${imageName.replaceFirst("\$", "")}");
var url = await ref.getDownloadURL();

return url;




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
DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(currentUser!+"."+paginaActual).collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();

Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombre=data["nombre_web"].toString();
 x.h1=data["h1"];
 x.h2=data["h2"];
 x.h3=data["h3"];
x.mapaDivs=data["divs"];
x.divStyles=data["divsStyles"];
x.pageBackground=data["pageBackground"];
x.footer=data["footer"];
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
/*sleep(Duration(seconds:1));
xNow.aniadirAlMapa();
xNow.cargarABBDD();*/
 final route = MaterialPageRoute(

    builder: (context){
return CreacionWebsPage(paginaActual);

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}






}