import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:flutter/material.dart';

class UserWebsPage extends StatefulWidget {
  
 @override
  _UserWebsPage createState() => _UserWebsPage();
  
}

class _UserWebsPage extends State<UserWebsPage>{
 
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
Text('Tus Webs'),

     Expanded(child:Align(
       
     alignment: Alignment.center,
       
       child:  _crearLista(["1","3"]),
       
       
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






Widget _crearLista(List listaWebs ){
  int selectedIndex;
//var  listaWebs = ['1','2','3'];
return ListView.builder(
  //shrinkWrap: true,
  padding: const EdgeInsets.all(10.0),
 
        itemCount: listaWebs.length,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            title:Text(listaWebs[index]),
             
           onTap: () {
              setState(() {
              selectedIndex = index;
              print(selectedIndex);
              
               
            });
           },
             onLongPress: () => {
               
              _crearAlertEliminar(context)

  },
            
            );


});
}


void _crearAlertEliminar(BuildContext context){

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
              onPressed: (){
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