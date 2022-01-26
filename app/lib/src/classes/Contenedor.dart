import 'package:flutter/material.dart';

class Contenedor{
  String nombre="";
List<dynamic> texto=[];//ordenar por texto

//cargar a bbdd los resultados

Contenedor(String nombreX, List<dynamic> textoX){
nombre=nombreX;
texto=textoX;
}
String getNombre(){
  return nombre;
}

List<dynamic> getTexto(){

  return texto;
}
}