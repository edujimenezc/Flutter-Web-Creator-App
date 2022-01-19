import 'package:ejemplobbdd/src/classes/Contenedor.dart';
import 'package:flutter/material.dart';

class Encabezado{
String h1;
String h2;
String h3;
List<dynamic> Listadivs;
List<Contenedor> contenedores=[];
Map<dynamic,dynamic> mapaDivs={};
Encabezado(
  {
required this.h1,
required this.h2,
required this.h3,
required this.Listadivs,
}








);




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



void aniadirAContenedores(){
  this.Listadivs.forEach((element) {mapaDivs=element;});
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


static Encabezado fromJson(json)=> Encabezado(
  h1: json["h1"],
  h2: json["h2"],
  h3: json["h3"],
  Listadivs: json["divs"],

);
 @override
String toString() {
  return this.h1.toString();//me he quedado en que me ha leido bn el json y tal crea los getter y setter y la clase en condiciones y luego es mostrarlo
}
}