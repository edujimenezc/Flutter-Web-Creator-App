import 'dart:collection';
import 'dart:ffi';

import 'package:ejemplobbdd/src/classes/Contenedor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Clase Encabezado, que recojerá todo el cuerpo de la web desde base de datos para recuperar valores de este, y los subirá a la base de datos
 * @author Eduardo Jimenez Cobos
*/

 class Encabezado{
  //usuario actual logado
  var currentUser = FirebaseAuth.instance.currentUser;
  //instancia de Firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //autor del encabezado
  String autor="";
  //nombre del encabezado
  String nombre="";
  //lista con los elementos de h1
List h1=[];
  //lista con los elementos de h2
List h2=[];
  //lista con los elementos de h3
List h3=[];
  //mapa con los estilos de los divs
Map divStyles={};
  //fondo de la página (Color)
String pageBackground="";
  //fondo de la página (URL)
String pageBackgroundURL="";
  //mapa con los elementos del footer
Map footer={};
  //lista de los contenedores (divs) de la página
List<Contenedor> contenedores=[];
  //mapa con los divs de la página
Map<dynamic,dynamic> mapaDivs=Map<dynamic,dynamic>();

/**
 * Constructor de Encabezado
 * @param nombre, nombre de la web
 * @param h1 lista con los elementos de h1
 * @param h2 lista con los elementos de h2
 * @param h3 lista con los elementos de h3
 * @param mapadivs, map con los divs de la página web
 * @param mapadivsCSS, map con los estilos de cada div
 * @param autor, autor de la web
 */
Encabezado.constructor1( String nombre,List h1, List h2, List h3, Map<dynamic,dynamic> mapadivs,Map<dynamic,dynamic> mapadivsCSS, String autor){

this.nombre=nombre;

this.h1=h1;
this.h2=h2;
this.h3=h3;
this.mapaDivs=mapaDivs;

this.autor=autor;

}
/**
 * COnstructor vacio de Encabezado
 */
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
/**
 * funcion que pone los estilos a los divs
 * @param mapa, map con los estilos de los divs
 */
void setStyles(Map mapa){
this.divStyles=mapa;

}
/**
 * funcion que devuelve los estilos de los divs
 * @return Map con los estilos de los divs
 */
Map getStyles(){
return this.divStyles;

}
/**
 * funcion que añade los estilos a los divs dependiendo de su nombre
 * @param nombreDiv, nombre del div al que se le quiere añadir estilos
 * @param color, color para el div 
 */
void aniadirEstiloDiv(String nombreDiv,String color){
  if(divStyles.containsKey(nombreDiv)){
    divStyles[nombreDiv]=color;
  }else{
 this.divStyles.putIfAbsent(nombreDiv, () => color);
  }

 
  
}

/**
 * funcion que añade los contenedores desde mapaDivs a una Lista<Contenedor>
 */

void aniadirAContenedores(){
 
 
   mapaDivs.forEach((key, value) {


contenedores.add(new Contenedor(key.toString(),value));



    });
contenedores=List.from(contenedores.reversed);






}

/**
 * función asíncrona que sube la página web a la base de datos
 * @param nombreWeb nombre de la web a subir
 */
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
"pageBackground":pageBackground,
"footer":footer,
 }
   

 )
 
          
          
          .catchError((error) => print("Failed to add web: $error"));








}








/*
/**
 * Función que guarda la web en estilo json, la dejo comentada por si fuera necesaria en futuras implementaciones
 */
static Encabezado fromJson(json)=> Encabezado(
  nombre : "nombrePorDefecto",
  h1: json["h1"],
  h2: json["h2"],
  h3: json["h3"],
  Listadivs: json["divs"],

);*/

}