import 'package:flutter/material.dart';

class Contenedor{
  String nombre="";
//List<dynamic> texto=[];//ordenar por texto

Map<dynamic,dynamic> elementos={};











Contenedor(String nombreX, Map<dynamic,dynamic> elementosX){
nombre=nombreX;
elementos=elementosX;
}
String getNombre(){
  return nombre;
}

/*List<dynamic> getTexto(){

  return texto;
}*/
}