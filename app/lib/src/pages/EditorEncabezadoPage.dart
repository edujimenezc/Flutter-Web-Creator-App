import 'dart:collection';
import 'dart:convert';
import 'package:ejemplobbdd/src/classes/ColorExt.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  String paginaActual="";
  EditorEncabezadoPage(String nombreWeb){
paginaActual=nombreWeb;

  }
 @override
  _EditorEncabezadoPage createState() => _EditorEncabezadoPage(paginaActual);
  
}

class _EditorEncabezadoPage extends State<EditorEncabezadoPage>{
   String paginaActual="";
  _EditorEncabezadoPage(String nombreWeb){
paginaActual=nombreWeb;

  }
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




if(encabezadoActual.h2[0].toString().isNotEmpty){
h1=encabezadoActual.h1[0].toString();
}


if(encabezadoActual.h2[0].toString().isNotEmpty){
h2=encabezadoActual.h2[0].toString();
}

if(encabezadoActual.h3[0].toString().isNotEmpty){
h3=encabezadoActual.h3[0].toString();
}







 


  return Scaffold(
    body: Column(

children: <Widget>[
Column(

  children: <Widget>[
  
 _crearButtonVolver(),

colorPicker(encabezadoActual, "pageBackground", "", "")





]),
TextField(
  
      
      decoration: InputDecoration(
        suffixIcon: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn10",
        child: Text('B'),
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
 
 if(encabezadoActual.h1[1]=="bold"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h1[1]="bold";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h1[1]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h1[2]=="italic"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h1[2]="italic";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h1[2]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h1[3]=="left"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h1[3]="left";
     
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h1[3]=="center"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h1[3]="center";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h1[3]=="right"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h1[3]="right";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
     }

 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
     setState(() {
       
     });
    



        })





],




),
SizedBox(height: 20), 
Text("Color"),

colorPicker(encabezadoActual,"h1","",""),

SizedBox(height: 20), 

Text("Tamaño"),
dropDown(["14","20","30","40","50","70"].toList(),encabezadoActual,5,"h1","",""),

SizedBox(height: 20), 
//para meter las google fonts seria aqui
Text("Tipo de letra"),
dropDown(["Arial","Verdana","Helvetica","Tahoma","'Trebuchet MS'","'Times New Roman'","Georgia","'Courier New'","'Brush Script MT'"].toList(),encabezadoActual,6,"h1","","")





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
        hintText: h1.toString(),
        //labelText: 'Password',
        
        
      ),

      onChanged: (valor) =>setState(() {
        encabezadoActual.h1[0] = valor;
        encabezadoActual.cargarABBDD(paginaActual);
       
      }),
   
    ),


TextField(
  
     
      decoration: InputDecoration(
        suffixIcon: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn15",
        child: Text('B'),
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
 
 if(encabezadoActual.h2[1]=="bold"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h2[1]="bold";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h2[1]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h2[2]=="italic"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h2[2]="italic";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h2[2]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h2[3]=="left"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h2[3]="left";
     
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h2[3]=="center"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h2[3]="center";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h2[3]=="right"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h2[3]="right";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
     }

 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
     setState(() {
       
     });
    



        })





],




),
Text("Color"),
colorPicker(encabezadoActual,"h2","",""),


Text("Tamaño"),
dropDown(["14","20","30","40","50","70"].toList(),encabezadoActual,5,"h2","",""),
Text("Tipo de letra"),
dropDown(["Arial","Verdana","Helvetica","Tahoma","'Trebuchet MS'","'Times New Roman'","Georgia","'Courier New'","'Brush Script MT'"].toList(),encabezadoActual,6,"h2","","")









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
        hintText: h2.toString(),
        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {

      encabezadoActual.h2[0] = valor;
      encabezadoActual.cargarABBDD(paginaActual);
      })
    ),


TextField(
  
      
      decoration: InputDecoration(
        
        hintText: h3.toString(),
suffixIcon: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn16",
        child: Text('B'),
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
 
 if(encabezadoActual.h3[1]=="bold"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h3[1]="bold";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h3[1]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h3[2]=="italic"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h3[2]="italic";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.h3[2]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h3[3]=="left"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h3[3]="left";
     
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h3[3]=="center"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h3[3]="center";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.h3[3]=="right"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.h3[3]="right";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
     }

 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
     setState(() {
       
     });
    



        })





],




),
Text("Color"),
colorPicker(encabezadoActual,"h3","",""),



Text("Tamaño"),
dropDown(["14","20","30","40","50","70"].toList(),encabezadoActual,5,"h3","",""),

Text("Tipo de letra"),
dropDown(["Arial","Verdana","Helvetica","Tahoma","'Trebuchet MS'","'Times New Roman'","Georgia","'Courier New'","'Brush Script MT'"].toList(),encabezadoActual,6,"h3","","")










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


        })




        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       encabezadoActual.h3[0] = valor;
       encabezadoActual.cargarABBDD(paginaActual);
      })
    ),
    
    Expanded(child: _crearListaDivs(encabezadoActual.contenedores,encabezadoActual,colorTargeta)),

Row(children: [
SizedBox(width: 100),

TextButton(onPressed: (){



if(encabezadoActual.mapaDivs.keys.isEmpty){
  encabezadoActual.mapaDivs.putIfAbsent("div1", () => {});


encabezadoActual.cargarABBDD(paginaActual);

setState(() {
  
});





}else{



int numMayor=0;
String elementoMayor="";
for (var item in encabezadoActual.mapaDivs.keys) {

if(item.toString().length>4){

if(int.parse(item.toString()[item.toString().length-2]+item.toString()[item.toString().length-1])>numMayor){
numMayor=int.parse(item.toString()[item.toString().length-2]+item.toString()[item.toString().length-1]);
elementoMayor=item.toString();


encabezadoActual.cargarABBDD(paginaActual);

setState(() {
  
});


}
}else{




if(int.parse(item.toString()[3])>numMayor){
numMayor=int.parse(item.toString()[3]);
elementoMayor=item.toString();
}
}
}

encabezadoActual.mapaDivs.putIfAbsent("div${numMayor+1}", () => {});

encabezadoActual.cargarABBDD(paginaActual);

setState(() {
  
});











  
}















}, child: Text("+Contenedor")),


TextButton(onPressed: (){





int numMayor=0;
String elementoMayor="";

try{

if(
encabezadoActual.mapaDivs.keys==null

){




}else{



for (var item in encabezadoActual.mapaDivs.keys) {

if(item.toString().length>4){

if(int.parse(item.toString()[item.toString().length-2]+item.toString()[item.toString().length-1])>numMayor){
numMayor=int.parse(item.toString()[item.toString().length-2]+item.toString()[item.toString().length-1]);
elementoMayor=item.toString();
}
}else{




if(int.parse(item.toString()[3])>numMayor){
numMayor=int.parse(item.toString()[3]);
elementoMayor=item.toString();
}
}

}

setState(() {
  
encabezadoActual.mapaDivs.remove(elementoMayor);
encabezadoActual.divStyles.remove(elementoMayor);
encabezadoActual.cargarABBDD(paginaActual);
});

















}










  
}catch(e){

}









}, child: Text("-Contenedor"))



],)




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
Row(children: [
SizedBox(width: 150.0 ),
Text(lista[index].nombre),
SizedBox(width: 80.0 ),

FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn17",
        child: Text('Editar contenedor'),
        onPressed: (){

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Edición del Contenedor'),
          













          
          content: Column(
            mainAxisSize:MainAxisSize.min,
children: [




Text("Color"),
colorPicker(encabezadoActual,"estiloDivs",lista[index].nombre,""),








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

],),

    
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
        

        hintText: encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][0],
suffixIcon: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn17",
        child: Text('B'),
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
 
 if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][1]=="bold"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][1]="bold";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][1]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
// Navigator.of(context).pop();
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
 
 if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][2]=="italic"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][2]="italic";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}else{

encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][2]="";


}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]=="left"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]="left";
     
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]=="center"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]="center";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
       
}
 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
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
 
 if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]=="right"){
   estaYa=true;
 }






     if(estaYa==false){
 encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][3]="right";
      //print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"]);
      //encabezadoActual.aniadirAlMapa();
     }

 encabezadoActual.cargarABBDD(paginaActual);
 Navigator.of(context).pop();
     setState(() {
       
     });
    



        })





],




),
Text("Color"),
colorPicker(encabezadoActual,"divs",encabezadoActual.contenedores[index].getNombre(),"${index2}text"),
Text("Tamaño"),
dropDown(["14","20","30","40","50","70"].toList(),encabezadoActual,5,"divs",encabezadoActual.contenedores[index].getNombre(),"${index2}text"),


Text("Tipo de letra"),
dropDown(["Arial","Verdana","Helvetica","Tahoma","'Trebuchet MS'","'Times New Roman'","Georgia","'Courier New'","'Brush Script MT'"].toList(),encabezadoActual,6,"divs",encabezadoActual.contenedores[index].getNombre(),"${index2}text")







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


        })



      
        
        
      ),
      onChanged: (valor) =>setState(() {
      encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][0] = valor;
      
      
      }),
      
       onSubmitted: (value){
         encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}text"][0]=value;
        
        


  encabezadoActual.cargarABBDD(paginaActual);
 











       },
    );



















}else if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}img"]!=null){



 return FutureBuilder (
      
      future: getImageFromDatabase(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}img"][0]),
      
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




/*
try{

}catch(error r){




}*/

  

  
final String? id = getYoutubeThumbnail(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]["${index2}video"][0]);
if(id!=null){

return Image.network('https://img.youtube.com/vi/${id}/0.jpg');
 
}else{

 return Image.network("https://i1.wp.com/www.radiosanjoaquin.cl/wp-content/uploads/2021/08/youtube-video-no-disponible.jpg?fit=1120%2C581&ssl=1");
}









/*



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

if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){



if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.length>10){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Limite alcanzado'),
          
          content: Expanded(child: Text("Sólo puedes añadir 11 elementos por contenedor!")),
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



}else{






for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}


encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}text", () => ["Text","","","","","",""]);

}

}else{


encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}text", () => ["Text","","","","","",""]);




}




 




 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);








 });

}, child: Text("+T")),
TextButton(onPressed: (){
  
if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.length>10){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Limite alcanzado'),
          
          content: Expanded(child: Text("Sólo puedes añadir 11 elementos por contenedor!")),
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



}else{
  
  
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
                Text("Nombre de la imagen"),
                TextField(

decoration: InputDecoration(
        
        hintText: "Nombre de la Imagen",
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


      
uploadImageToFirebase(context).then((value){

//print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString());


int x=0;

int numMayor=0;
String elementoMayor="";


if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){
if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.length>10){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Limite alcanzado'),
          
          content: Expanded(child: Text("Sólo puedes añadir 11 elementos por contenedor!")),
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



}else{

for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
  

 


 
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}


}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => [currentUser!+nombreImagen]);



}




}else{


  encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}img", () => [currentUser!+nombreImagen]);




}






 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);

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





if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){

for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
  
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => [currentUser!+nombreImagen]);



}else{


  encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}img", () => [currentUser!+nombreImagen]);




}















//old


 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);

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

//print(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString());


int x=0;

int numMayor=0;
String elementoMayor="";


if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){

for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
  
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => [currentUser!+nombreImagen]);



}else{


  encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}img", () => [currentUser!+nombreImagen]);




}






 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);

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





if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){

for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {



if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}img", () => [currentUser!+nombreImagen]);



}else{


  encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}img", () => [currentUser!+nombreImagen]);




}















//old


 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);

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









}




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
  
  


  
  
  
  
  
  
  
  
  
  
  
  
}
  
  
  
  
  


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
             decoration: InputDecoration(
        
        hintText: "Introduce la URL del video",
        //labelText: 'Password',
        
        
      ),
            onChanged: (valor) =>setState(() {
              url=valor;
       
      }),
          ),
         
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){





if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.length>10){




showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Limite alcanzado'),
          
          content: Expanded(child: Text("Sólo puedes añadir 11 elementos por contenedor!")),
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



}else{













if(url.isNotEmpty){





 






int x=0;

int numMayor=0;
String elementoMayor="";





if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.toString()!="()"){



for (var item in encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys) {
if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}
}

 encabezadoActual.contenedores[index].elementos.putIfAbsent("${(numMayor+1).toString()}video", () =>[url]);



}else{


 encabezadoActual.contenedores[index].elementos.putIfAbsent("${0}video", () =>[url]);




}















 setState(() {







  encabezadoActual.cargarABBDD(paginaActual);

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
if(encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].keys.length==1){
 elementoMayor=item.toString();
}

if(
item.toString().substring(0,2)=="10"
){

elementoMayor=item.toString();
break;



}else{

if(int.parse(item.toString()[x])>numMayor){
numMayor=int.parse(item.toString()[x]);
elementoMayor=item.toString();
}



}








}


encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()].remove(elementoMayor);
encabezadoActual.cargarABBDD(paginaActual);

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


Widget colorPicker(Encabezado encabezadoActual,String posicionHTML,String pt2,String pt3){
return ElevatedButton(
                        onPressed: (){
                          Color mycolor=Colors.lightBlue;
                          
switch(posicionHTML) { 
                                                          case "h1": { 
                                                            if(encabezadoActual.h1[4]!=""){
                                                              
                                                          mycolor=mycolor.fromHex(encabezadoActual.h1[4]);
                                                            }
                                                          
                                                          
                                                          } 
                                                          break; 
                                                        
                                                          case "h2": {  
                                                            if(encabezadoActual.h2[4]!=""){
                                                           mycolor= mycolor.fromHex(encabezadoActual.h2[4]);
                                                            }
                                                           
                                                             
                                                          } 
                                                          break; 
                                                        
                                                          case "h3": { 
                                                            if(encabezadoActual.h3[4]!=""){
                                                                mycolor=mycolor.fromHex(encabezadoActual.h3[4]);
                                                            } 
                                                           
                                                           
                                                          } 
                                                          break; 
                                                        
                                                          case "divs": {  
                                                            if(encabezadoActual.mapaDivs[pt2][pt3][4]!=""){
                                                             mycolor= mycolor.fromHex(encabezadoActual.mapaDivs[pt2][pt3][4]);
                                                            }
                                                             
                                                   

                                                          }
                                                          break;
                                                           case "pageBackground": {  
                                                            if(encabezadoActual.pageBackground!=""){
                                                             mycolor= mycolor.fromHex(encabezadoActual.pageBackground);
                                                            }
                                                             
                                                   

                                                          }
                                                          break;
                                                          case "estiloDivs":{
                                                            if(encabezadoActual.divStyles.containsKey(pt2)){
                                                              if(encabezadoActual.divStyles[pt2]!=""){
                                                                  mycolor=mycolor.fromHex(encabezadoActual.divStyles[pt2]);
                                                              }
                                                              
                                                              
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
      case "h1": { 
         encabezadoActual.h1[4]=mycolor.toHex();
        encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     //TODO
      case "h2": {  
        

  encabezadoActual.h2[4]=mycolor.toHex();
        encabezadoActual.cargarABBDD(paginaActual);

       } 
      break; 
     
      case "h3": { 
          encabezadoActual.h3[4]=mycolor.toHex();
        encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     
      case "divs": {  
        
encabezadoActual.mapaDivs[pt2][pt3][4]=mycolor.toHex();
 encabezadoActual.cargarABBDD(paginaActual);
       } 
      break;
      case "pageBackground": {  
        
encabezadoActual.pageBackground=mycolor.toHex();
 encabezadoActual.cargarABBDD(paginaActual);
       } 
      break;  
     case "estiloDivs":{
         encabezadoActual.aniadirEstiloDiv(pt2,mycolor.toHex());
encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
      default: { print("Invalid choice"); } 
      break; 
   } 
     
      encabezadoActual.cargarABBDD(paginaActual);
       






   }

                                          



















                                                
                                              );
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




Widget dropDown(List<String> elementos,Encabezado encabezadoActual,int parteCSS,String posicionHTML,String pt2,String pt3){
  String x="";
switch(posicionHTML) { 
      case "h1": { 
       x=  encabezadoActual.h1[parteCSS];
       
       } 
      break; 
     //TODO
      case "h2": {  
           x=  encabezadoActual.h2[parteCSS];
       } 
      break; 
     
      case "h3": {  
        x=  encabezadoActual.h3[parteCSS];
       } 
      break; 
     
      case "divs": {  
        
x=encabezadoActual.mapaDivs[pt2][pt3][parteCSS];

       }
       break;
       case "estiloDivs":{
         if(encabezadoActual.divStyles.containsKey(pt2)){
           x=encabezadoActual.divStyles[pt2];
         }

       } 
      break; 
     
      default: { print("Invalid choice"); } 
      break; 
   } 
if(x==""){
 x=elementos[0];

}

return DropdownButtonFormField<String>(
  onChanged: (valueX) {
     setState(() {
      x=valueX.toString();
      //swith case
      switch(posicionHTML) { 
      case "h1": { 
         encabezadoActual.h1[parteCSS]=x;
        encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     //TODO
      case "h2": {  
        

  encabezadoActual.h2[parteCSS]=x;
        encabezadoActual.cargarABBDD(paginaActual);

       } 
      break; 
     
      case "h3": { 
          encabezadoActual.h3[parteCSS]=x;
        encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     
      case "divs": {  
        
encabezadoActual.mapaDivs[pt2][pt3][parteCSS]=x;
 encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
     case "estiloDivs":{
         encabezadoActual.aniadirEstiloDiv(pt2,x);
encabezadoActual.cargarABBDD(paginaActual);
       } 
      break; 
      default: { print("Invalid choice"); } 
      break; 
   } 
     
      encabezadoActual.cargarABBDD(paginaActual);
       






   });
  
  },
  
 onSaved: (valueX) {
   setState(() {
      x=valueX.toString();
      print(valueX.toString());
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






String? getYoutubeThumbnail(String videoUrl) {
  final Uri? uri = Uri.tryParse(videoUrl);
  if (uri == null) {
    return null;
  }

  return uri.queryParameters['v'];
  //'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
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