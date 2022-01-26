import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/main.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'dart:io';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorEncabezadoPage extends StatefulWidget {
  
 @override
  _EditorEncabezadoPage createState() => _EditorEncabezadoPage();
  
}

class _EditorEncabezadoPage extends State<EditorEncabezadoPage>{
  Color colorTargeta=Colors.white;
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




if(encabezadoActual.getH1.toString().isNotEmpty){
h1=encabezadoActual.getH1;
}


if(encabezadoActual.getH2.toString().isNotEmpty){
h2=encabezadoActual.getH2;
}

if(encabezadoActual.getH3.toString().isNotEmpty){
h3=encabezadoActual.getH3;
}







 


  return Scaffold(
    body: Column(

children: <Widget>[
_crearButtonVolver(encabezadoActual),
TextField(
  
      
      decoration: InputDecoration(
        
        hintText: h1.toString(),
        //labelText: 'Password',
        
        
      ),

      onChanged: (valor) =>setState(() {
        encabezadoActual.setH1 = valor;
        encabezadoActual.cargarABBDD();
       
      }),
   
    ),


TextField(
  
     
      decoration: InputDecoration(
        
        hintText: h2.toString(),
        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {

      encabezadoActual.setH2 = valor;
      encabezadoActual.cargarABBDD();
      })
    ),


TextField(
  
      
      decoration: InputDecoration(
        
        hintText: h3.toString(),




        //labelText: 'Password',
        
        
      ),
      onChanged: (valor) =>setState(() {
       encabezadoActual.setH3 = valor;
       encabezadoActual.cargarABBDD();
      })
    ),
    
    Expanded(child: _crearListaDivs(encabezadoActual.contenedores,encabezadoActual,colorTargeta)),


Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),
Text("Aqui van los botones de edicion"),




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
    

 return InkWell(
  child: Card(
  elevation:1.0 ,//sombra
  color: colorTargeta,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),//borde redondeado
  child: Column(
    children: <Widget>[
      SizedBox(height: 30.0 ,),

Text(lista[index].nombre),
    
SizedBox(height: 20.0 ,),
Row(
  children: <Widget>[

Expanded(child:

ListView.builder(
   shrinkWrap: true,
  physics: ScrollPhysics(),
  padding: const EdgeInsets.all(8),
  itemCount: lista[index].texto.length,
  itemBuilder: (BuildContext context, int index2) {

    return TextField(
  
      
      decoration: InputDecoration(
        

        hintText: lista[index].texto[index2].toString(),




      
        
        
      ),
      onChanged: (valor) =>setState(() {
      encabezadoActual.contenedores[index].texto[index2] = valor;
      
      //encabezadoActual.aniadirAlMapa();
      //encabezadoActual.cargarABBDD();
      
      }),
      
       onSubmitted: (value){
         encabezadoActual.contenedores[index].texto[index2]=value;
        
        

Map mapaActual={};
int i=1;
for (var item in encabezadoActual.contenedores[index].texto) {
  mapaActual["text${i}"]=item.toString();
  i++;
}
print(mapaActual.toString());


encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]=mapaActual;





  encabezadoActual.cargarABBDD();
 











       },
    );






  })

),























    

  ],
  
),



Row(

  children: <Widget>[

SizedBox(width: 20.0 ,),
TextButton(onPressed: (){//el del texto

 
encabezadoActual.contenedores[index].texto.add("Text");

Map mapaActual={};
int i=1;
for (var item in encabezadoActual.contenedores[index].texto) {
  mapaActual["text${i}"]=item.toString();
  i++;
}
print(mapaActual.toString());


encabezadoActual.mapaDivs[encabezadoActual.contenedores[index].getNombre()]=mapaActual;





  encabezadoActual.cargarABBDD();
 setState(() {



 });

}, child: Text("+T")),
TextButton(onPressed: (){//el de imgs


}, child: Text("+Img")),
TextButton(onPressed: (){//el de videos


}, child: Text("+Video")),
TextButton(onPressed: (){//el de musica



}, child: Text("+Music")),

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



/*











*/ 

 



Future<Encabezado> cargarDeBBDD() async {

var nombre;
var h1;
var h2;
var h3;
var mapaDivs;

Encabezado x=Encabezado.constructor2();
DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc("prueba").collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();

Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  
nombre=data["nombre_web"].toString();
 x.h1=data["h1"].toString();
 x.h2=data["h2"].toString();
 x.h3=data["h3"].toString();
x.mapaDivs=data["divs"];



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
  
























Widget _crearButtonVolver(Encabezado x){
  
  Encabezado xNow=x;


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
return CreacionWebsPage();

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}






}