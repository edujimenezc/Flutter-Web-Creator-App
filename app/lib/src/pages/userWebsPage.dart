import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/classes/Encabezado.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'EditorEncabezadoPage.dart';

class UserWebsPage extends StatefulWidget {
  
 @override
  _UserWebsPage createState() => _UserWebsPage();
  
}

class _UserWebsPage extends State<UserWebsPage>{
 String? currentUser = FirebaseAuth.instance.currentUser!.email;
 @override
  Widget build(BuildContext context) {

return FutureBuilder (
      
      future:  cargarWebs(),
      
      builder: ( context,AsyncSnapshot<dynamic> snapshot  ){
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



return Scaffold(
  resizeToAvoidBottomInset: false,
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
Text('Tus Webs',style: TextStyle(color: colorFromHex("#165364"),fontSize: 30),),

     Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child:  _crearLista(snapshot.data),
       
       
       ),
       
       ),
      

        



    
 


SizedBox(height: 25),



Row(
  children: <Widget>[
    SizedBox(width: 60),

  ],
)






],

  ),
),


    );








}
      });











    
  }





Future<List<String>> cargarWebs() async {

List<String> userWebs=[];
/*

final db = FirebaseFirestore.instance;
var result=await db.collection('webs').get();
result.docs.forEach((res) {print(res.id); });


*/





   
 await FirebaseFirestore.instance.collection('webs').get().then((value) {

value.docs.forEach((element) {
  String correo=element.id.toString().split(".")[0]+"."+element.id.toString().split(".")[1];

if(correo.toString() == currentUser){
  
   userWebs.add(element.id);
};
  
  
  });

 });


 











/*
var querySnapshot = await webActual.get();
    

Map<String, dynamic>? data = querySnapshot.data() as Map<String, dynamic>?;
if(data!=null){
  userWebs.add(data["nombre_web"].toString());





}


   
  
*/




  return userWebs;
}





Widget _crearLista(List listaWebs ){
  if(listaWebs.isEmpty){
return Text("¡No tienes Webs Aún!",style: TextStyle(color: colorFromHex("#165364")),);

  }

return ListView.builder(
  
  //shrinkWrap: true,
  padding: const EdgeInsets.all(10.0),
 
        itemCount: listaWebs.length,
        itemBuilder: (BuildContext context,int index){

String nombreActual="";
List arrayActual=listaWebs[index].toString().split(".");
if(arrayActual.length>3){
 
  for (var i = 2; i < arrayActual.length; i++) {
     nombreActual=nombreActual+" "+arrayActual[i];
  }
  
}else{
  nombreActual=arrayActual[2];
}

 String nombreFinal="";
          return ListTile(

           iconColor: colorFromHex("#ff9a3d"),
            title:Row(
               mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
              children: [
 Image(
        image: AssetImage('assets/web.png'),
        fit: BoxFit.cover,
        height: 50,
    ),
    SizedBox(width: 5),
 Text(nombreActual,style: TextStyle(color: colorFromHex("#ff9a3d")),textAlign: TextAlign.center,),

            ],),
            
           
             hoverColor: colorFromHex("#ff9a3d"),
              selectedColor:colorFromHex("#ff9a3d"),
              selectedTileColor:colorFromHex("#ff9a3d"),
              
           onTap: () {
              setState(() {
              String nombreWeb=listaWebs[index];
              var nombreSplit=nombreWeb.split(".");
             





              if(nombreSplit.length>3){
                for (var i = 2; i < arrayActual.length; i++) {
     nombreActual=nombreActual+" "+arrayActual[i];
  }
                
              }else{

                nombreFinal=nombreSplit[2];
              }

              

             final route = MaterialPageRoute(

                     builder: (context){
                  return CreacionWebsPage(nombreFinal);

                                         }
                                              );
























                      Navigator.push(context, route);
            
              
              
               
            });
           },
             onLongPress: () => {
               
              _crearAlertEliminar(context,nombreActual)

  },
            
            );


});
}


void _crearAlertEliminar(BuildContext context,String nombreWeb){

 showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Eliminar Web'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('¿Seguro que deseas Eliminar esta Web?'),
              
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: ()async{



                  eliminarDeBBDD(nombreWeb).then((value) => setState(() {
  
}));







                Navigator.of(context).pop();

//TODO aki


              },
            ),
          ],
        );

      }

    );


/*

*/
}



Future<void> eliminarDeBBDD(String paginaActual) async {

var collection = FirebaseFirestore.instance.collection('webs');
await collection.doc(currentUser!+"."+paginaActual).delete();

Widget _crearButtonEditar(){


return Column(children: <Widget>[
  
  Container(
 height: 50.0,
        width: 50.0,

child: FloatingActionButton(
   shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
    heroTag: "btn2",
        child: Text('Editar'),
        onPressed: (){


//TODO

        }),

),







]);



}}


Widget _crearButtonVolver(){


return Column(

  children: <Widget>[
  
  Container(
    
 height: 75.0,
        width: 75.0,

child: FloatingActionButton(
  shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn3",
        child:Image(
        image: AssetImage('assets/back.png'),
        fit: BoxFit.cover,
        height: 50,
    ),
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