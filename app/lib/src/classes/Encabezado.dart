import 'dart:collection';
import 'dart:ffi';

import 'package:ejemplobbdd/src/classes/Contenedor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 class Encabezado{
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String autor="";
  String nombre="";
List h1=[];
List h2=[];
List h3=[];
Map divStyles={};
String pageBackground="";

List<Contenedor> contenedores=[];
Map<dynamic,dynamic> mapaDivs=Map<dynamic,dynamic>();

Encabezado.constructor1( String nombre,List h1, List h2, List h3, Map<dynamic,dynamic> mapadivs,Map<dynamic,dynamic> mapadivsCSS, String autor){

this.nombre=nombre;

this.h1=h1;
this.h2=h2;
this.h3=h3;
this.mapaDivs=mapaDivs;

this.autor=autor;

}

Encabezado.constructor2();

List get getH1{
return this.h1;
}

List get getH2{
return this.h2;
}

List get getH3{
return this.h3;
}

void set setH1(List text){
this.h1=text;
}

void set setH2(List text){
this.h2=text;
}

void set setH3(List text){
this.h3=text;
}

void setStyles(Map mapa){
this.divStyles=mapa;

}
Map getStyles(){
return this.divStyles;

}
void aniadirEstiloDiv(String nombreDiv,String color){
  if(divStyles.containsKey(nombreDiv)){
    divStyles[nombreDiv]=color;
  }else{
 this.divStyles.putIfAbsent(nombreDiv, () => color);
  }

 
  
}



void aniadirAContenedores(){
 
  //var i=0;

  /*for (var item in mapaDivs.values) {
    
    
    this.contenedores.add(Contenedor());
for (var x in item.keys) {
  if(x.toString().contains("text")){
    
contenedores[i].texto.add(item[x]);
  }*/
   mapaDivs.forEach((key, value) {


contenedores.add(new Contenedor(key.toString(),value));
//print(key.toString());


    });
contenedores=List.from(contenedores.reversed);



//contenedores.sort();
//contenedores.forEach((element) {print(element.toString());});


 /*if(x.toString().contains("image")){
print(item[x]);
  }*/



}

Future<void> cargarABBDD(String nombreWeb)async {
  
  
 autor=currentUser!.email.toString();







DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(autor+"."+nombreWeb).collection("encabezado").doc("unique");

  webActual.set({

"autor" : autor,
"nombre_web" : autor+"."+nombreWeb,
"h1" : getH1,
"h2" : getH2,
"h3" : getH3,
"divs" : mapaDivs,
"divsStyles" :divStyles,
"pageBackground":pageBackground
 }
   

 )
 
          
          
          .catchError((error) => print("Failed to add web: $error"));








}








/*
static Encabezado fromJson(json)=> Encabezado(
  nombre : "nombrePorDefecto",
  h1: json["h1"],
  h2: json["h2"],
  h3: json["h3"],
  Listadivs: json["divs"],

);*/

}