import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class AyudaPage extends StatefulWidget {
  
 @override
  _AyudaPage createState() => _AyudaPage();
  
}

class _AyudaPage extends State<AyudaPage>{
 
 @override
  Widget build(BuildContext context) {

    return Scaffold(
body: Center(
  child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
SizedBox(height: 75),
Row(children: <Widget>[
  SizedBox(width: 10),
_crearButtonVolver(),
SizedBox(width: 40),
],),
Text('Preguntas Frecuentes'),
SizedBox(height: 25),
     Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child: _crearListaPreguntas()
       
       
       ),
       
       ),
      

        



    
 


SizedBox(height: 25),









],

  ),
),


    );
  }






Widget _crearListaPreguntas( ){
 
 return Column(children: <Widget>[

DropdownButton<String>(
  hint: Text("Please choose a location"),
  items: <String>['A'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (_) {},
),
SizedBox(height: 25),

DropdownButton<String>(
  hint: Text("Please choose a location"),
  items: <String>[''].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text('asas'+"\n"+"asas"),
    );
  }).toList(),
  onChanged: (_) {},
),
SizedBox(height: 25),

DropdownButton<String>(
  hint: Text("Please choose a location"),
  items: <String>['A'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (_) {},
),
SizedBox(height: 25),

DropdownButton<String>(
  hint: Text("Please choose a location"),
  items: <String>['A'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (_) {},
),
SizedBox(height: 25),



 ]);
 
 
 
 
 
 
 
 
  /*
return DropdownButton<String>(
  hint: Text("Please choose a location"),
  items: <String>['A'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (_) {},
);*/
}








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



 final route = MaterialPageRoute(

    builder: (context){
return HomePage();

    }
  );

Navigator.push(context, route);


        }),

),

Text('Volver'),





]);



}



}