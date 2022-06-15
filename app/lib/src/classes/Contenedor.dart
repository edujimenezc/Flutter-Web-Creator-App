import 'package:flutter/material.dart';


/**
 * Clase Contenedor, en la que se almacenan los elementos de un contenedor (div en html)
 * @author Eduardo Jimenez Cobos
 */
class Contenedor{
  //Nombre del contenedor
  String nombre="";


//elementos del contenedor

Map<dynamic,dynamic> elementos={};










/**
 * Constructor de Contenedor
 * @param nombreX, nombre del Contenedor
 * @param elementosX map con los elementos del contenedor
 */
Contenedor(String nombreX, Map<dynamic,dynamic> elementosX){
nombre=nombreX;
elementos=elementosX;
}

/**
 * Funcion que devuelve el nombre del contenedor
 */
String getNombre(){
  return nombre;
}


}