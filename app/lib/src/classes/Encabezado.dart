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
String h1="";
String h2="";
String h3="";

List<Contenedor> contenedores=[];
Map<dynamic,dynamic> mapaDivs=SplayTreeMap<dynamic,dynamic>();

Encabezado.constructor1( String nombre,String h1, String h2, String h3, Map<dynamic,dynamic> mapadivs, String autor){

this.nombre=nombre;

this.h1=h1;
this.h2=h2;
this.h3=h3;
this.mapaDivs=mapaDivs;
this.autor=autor;

}

Encabezado.constructor2();

String get getH1{
return this.h1;
}

String get getH2{
return this.h2;
}

String get getH3{
return this.h3;
}

void set setH1(String text){
this.h1=text;
}

void set setH2(String text){
this.h2=text;
}

void set setH3(String text){
this.h3=text;
}




void aniadirAlMapa(){
  Map arrayTextos={};
  mapaDivs={};
int i=1;//used for the number of the div's name, example div1
int j=0;//used for the array number of container becouse in programming it starts at 0
int k=1;//used for the number of the text name, example text1
for (var item in contenedores) {

  for (var itemText in contenedores[j].texto) {
   // mapaDivs["div${i.toString()}"]=[];
    //print("texto del contenedor ");
    arrayTextos["text${k.toString()}"]=itemText.toString();
    k++;
  }
  mapaDivs["div${i.toString()}"]=arrayTextos;
  arrayTextos={};
  i++;
  j++;
  
//se cambian los putos nombres d los divsy d los text



  
}




}



void aniadirAContenedores(){
 
  var i=0;

  for (var item in mapaDivs.values) {
    
    
    this.contenedores.add(Contenedor());
for (var x in item.keys) {
  if(x.toString().contains("text")){
    
contenedores[i].texto.add(item[x]);
  }
  
 /*if(x.toString().contains("image")){
print(item[x]);
  }*/

}


i++;
   

  }
  










}
//hacer funcion que te cambie el doc en bbdd
Future<void> cargarABBDD()async {
  
  
 autor=currentUser!.email.toString();

DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc("prueba").collection("encabezado").doc("unique");

 return webActual.set({

"autor" : autor,
"nombre_web" : nombre,
"h1" : getH1,
"h2" : getH2,
"h3" : getH3,
"divs" : mapaDivs


 }
   

 )
          
          
          .catchError((error) => print("Failed to add user: $error"));


}








/*
static Encabezado fromJson(json)=> Encabezado(
  nombre : "nombrePorDefecto",
  h1: json["h1"],
  h2: json["h2"],
  h3: json["h3"],
  Listadivs: json["divs"],

);*/
 @override
String toString() {
  return this.h1.toString();//me he quedado en que me ha leido bn el json y tal crea los getter y setter y la clase en condiciones y luego es mostrarlo
}
}