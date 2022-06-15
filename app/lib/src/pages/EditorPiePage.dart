
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
/**
 * Clase EditorPiePage extiende de StatefulWidget y crea el state para _EditorPiePage
 */
class EditorPiePage extends StatefulWidget {
  String paginaActual="";
  EditorPiePage(String nombreWeb){
paginaActual=nombreWeb;

  }
 @override
  _EditorPiePage createState() => _EditorPiePage(paginaActual);
  
}
/**
 * Clase _EditorPiePage extiende de State<EditorPiePage>
 * Contiene el editor del pie de la página web
 */

class _EditorPiePage extends State<EditorPiePage>{
   String paginaActual="";
  _EditorPiePage(String nombreWeb){
paginaActual=nombreWeb;

  }
    //color de fondo de la web, por defecto blanco
  Color colorTargeta=Colors.white;
  //imagen seleccionada en las acciones de añadir imagen
   PickedFile? imageFile=null;
   //imagen de fondo para la web
   String fondoImagen="";
   //nombre por defecto para las acciones de añadir una images
    String nombreImagen="Default";
        //email del usuario actual
     String? currentUser = FirebaseAuth.instance.currentUser!.email;

/**
 * Widget que construye el editor del cuerpo de la web con el que se puede modificar la página y personalizarla
 * @ param context Contexto actual
 * @return FutureBuilder
 */
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

/**
 * Widget containerCentralImgFondo, es el contenedor central que contiene toda la estructura editable de la web
 * @param url, url de la imagen de fondo
 * @param encabezadoActual, Encabezado traido desde la base de datos
 * @param scaffoldColor para el fondo de la web
 * @param h1Hint, hint para el encabezado h1 por defecto
 * @param h2Hint, hint para el encabezado h2 por defecto
 * @param h3Hint, hint para el encabezado h3 por defecto
 * @return Container
 */

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
   SizedBox(height: 75),
Column(

  children: <Widget>[
  SizedBox(height: 75),
 _crearButtonVolver(),
SizedBox(height: 15),
botonEstilosFondo(encabezadoActual),

crearFooter(encabezadoActual)




]),

  



],
),

),
  ),

);
 








}


/**
 * Widget containerCentral, es el contenedor central que contiene toda la estructura editable de la web
 * @param encabezadoActual, Encabezado traido desde la base de datos
 * @param scaffoldColor para el fondo de la web
 * @param h1Hint, hint para el encabezado h1 por defecto
 * @param h2Hint, hint para el encabezado h2 por defecto
 * @param h3Hint, hint para el encabezado h3 por defecto
 * @return Container
 */


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
  SizedBox(height: 75),
 _crearButtonVolver(),
SizedBox(height: 15),
botonEstilosFondo(encabezadoActual),

crearFooter(encabezadoActual)




]),

  



],
),

),
  ),
);
 
}

/**
 * funcion asincrona que devuelve la url de una imagen de firebase storage a partir del nombre
 * @param fondoActual nombre de la imagen a recuperar
 * @return String
 */
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
SizedBox(height: 30.0 ),
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
SizedBox(width: 70),
 crearBotonImagen(encabezadoActual,"Cambiar imagen"),
SizedBox(width: 20),
        _crearButtonEliminarImagen(encabezadoActual)
      ],)
     

      




],);



}










}

/**
 * Widget _crearButtonEliminarImagen boton que aparece si hay una imagen asignada al footer para eliminarla
 * @return Container
 */

Widget _crearButtonEliminarImagen(Encabezado encabezadoActual){


return MaterialButton(
  shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    color: colorFromHex("#ffc93d"),
        child: Text('Eliminar\nimagen'),
        onPressed: (){
encabezadoActual.footer["img"][0]="";
setState(() {
  encabezadoActual.cargarABBDD(paginaActual);
});


        });



}

/**
 * Widget crearBotonImagen boton que aparece si no hay una imagen asignada al footer para subir una
 * @return Container
 */



Widget crearBotonImagen(Encabezado encabezadoActual, String mensaje){

return MaterialButton(
       shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
 color: colorFromHex("#ff9a3d"),
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












/**
 * Widget que crea todo el footer editable de manera visual
 * @param encabezadoActual del que traer y guardar valores
 * @return Container
 */
Widget crearFooter(Encabezado encabezadoActual){
return Container(

  child: Column(
    children: [
      SizedBox(height: 30.0 ),

SizedBox(height: 30.0 ),
textoFooter(encabezadoActual),
SizedBox(height: 30.0 ),

SizedBox(height: 30.0 ),
crearImgFooter(encabezadoActual),
    ],
  ),
);



}


/**
 * Widget botonFondoImagen, boton para poner como fondo de la página una imagen
 * @param encabezadoActual, Encabezado actual para guardar el fondo
 * @return FloatingActionButton
 */

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



/**
 * Widget botonEstilosFondo boton para cambiarle el estilo al fondo ya sea una imagen o un color
 * @param encabezadoActual, Encabezado actual para guardar el fondo
 * @return MaterialButton
 */
Widget botonEstilosFondo(Encabezado encabezadoActual){


 return MaterialButton(
       shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
 color: colorFromHex("#ffc93d"),
              child: Text('Editar el Fondo'),
              onPressed: (){
               showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
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

/**
 * Widget textoFooter TextView que recupera el texto desde el encabezado y permite al usuario editarlo
 * @param encabezadoActual Encabezado desde el que cojer y guardar el texto
 * @return TextField
 */

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
           scrollable: true,
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
        child: Text('Izq.'),
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
        child: Text('Der.'),
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
/**
 * Widget colorPicker, seleccionador de color visual
 * @param encabezadoActual, Encabezado actual para guardar el color
 * @param posicionHTML, elemento en el que que se va a guardar el color
 * @param p2,  parte del div a la que pertenece
 * @param p3,  parte del elemento al que pertenece
 * @return ElevatedButton
 */

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
/**
 * Widget aniadirURL, boton para añadir url a un texto, muestra un mensaje en el que se pide la url
 * @param encabezadoActual, encabezado actual para cambiar/añadir la url
 * @param parteCSS, parte en la que se guarda esta propiedad
 * @param pt2,  parte del div a la que pertenece
 * @param pt3,  parte del elemento al que pertenece
 * @return MaterialButton
 */

Widget aniadirURL(Encabezado encabezadoActual){
  String x="";
   x=  encabezadoActual.footer["texto"][7];

if(x==""){
  x="Introduce la URL";
}

return MaterialButton(
  shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    color: colorFromHex("#145463"),
        child: Text('Añadir URL',style: TextStyle(color: Colors.white)),onPressed: () {
  
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
/**
 * Widget dropDown lista de elementos desplegables para seleccionar 
 * @param elementos lista de los elementos a mostrar
 * @param encabezadoActual encabezado en el  que guardar el valor seleccionado
 * @param posicionHTML posición en la que se guardará esta parte dentro de las propiedades internas del encabezado
 * @param parteCSS, parte en la que se guarda esta propiedad
 * @param pt2,  parte del div a la que pertenece
 * @param pt3,  parte del elemento al que pertenece
 * @return MaterialButton
 */

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






/**
 * Función para abrir la galería y seleccionar una foto 
 * @param context context actual
 */
 
 
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
/**
 * función para abrir la cámara y tomar una foto
 * @param context context actual
 */
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



/**
 * función asincrona que trae una imagen de base de datos y la convierte en widget
 * @param imageName nombre de la imagen a mostrar
 * @return Image
 */

Future<Widget> getImageFromDatabase(String imageName) async {

  
final ref = FirebaseStorage.instance.ref().child('uploads').child(imageName);
var url = await ref.getDownloadURL();
return Image.network(url);




} 
/**
 * función asincrona que trae una imagen de base de datos para el fondo y la convierte en widget
 * @param imageName nombre de la imagen a mostrar
 * @return Image
 */

Future<String> getImageFromDatabaseFondo(String imageName) async {

  final ref = FirebaseStorage.instance.ref().child('uploads').child("${imageName.replaceFirst("\$", "")}");
var url = await ref.getDownloadURL();

return url;




} 

/**
 * funcion para subir una imagen a firebase storage
 * @param context contexto actual
 */

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

/**
 * funcion que carga un Encabezado desde la base de datos
 * @return Encabezado
 */
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


/**
 * Widget _crearButtonVolver boton para volver a la pantalla anterior
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