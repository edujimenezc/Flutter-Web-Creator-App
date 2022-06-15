import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplobbdd/src/pages/creacionWebsPage.dart';
import 'package:ejemplobbdd/src/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
/**
 * Clase NewPage extiende de StatefulWidget y crea el state para _NewPage
 */
class NewPage extends StatefulWidget {
  
 @override
  _NewPage createState() => _NewPage();
  
}

/**
 * Clase _NewPage extiende de State<NewPage>
 */
class _NewPage extends State<NewPage>{
  String? currentUser = FirebaseAuth.instance.currentUser!.email;
  /**
   * Widget que construye la pantalla NewPage en la que el usuario puede elegir cómo crear su web
   * @return Scaffold
   */
 @override
  Widget build(BuildContext context) {

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
Text('¿Cómo prefieres hacer tu Web?',style: TextStyle(color: colorFromHex("#165364"),fontSize: 25),),
SizedBox(height: 50),

_crearButtonDesdeCero(),



SizedBox(height: 50),
_crearButtonTemas(),
SizedBox(height: 50),






],

  ),
),


    );
  }





/**
 * función que mira en firebase si el usuario tiene un documento con un id dado
 * @param docId id para comprobar si existe
 * @return bool con la respues de si existe=true o no =false
 */


Future<bool> checkIfDocExists(String docId) async {
  try {
    // Get reference to Firestore collection
    DocumentReference webActual =FirebaseFirestore.instance.collection('webs').doc(docId).collection("encabezado").doc("unique");
var querySnapshot = await webActual.get();
    
    return querySnapshot.exists;
  } catch (e) {
    throw e;
  }
}

/**
 * Widget _crearButtonDesdeCero botón para crear una web desde cero, lanza una alerta que pide un nombre, s el usuario no tiene una web con ese nombre la crea y lo lleva al editor
 * @return Container
 */

Widget _crearButtonDesdeCero(){




return Container(
 height: 300.0,
        width: 250.0,

child: FloatingActionButton(
   backgroundColor: colorFromHex("#ff9a3d"),
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn1",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
 Image(
        image: AssetImage('assets/plus.png'),
        fit: BoxFit.cover,
        height: 60,
    ),
    SizedBox(height: 20),
 Text('Crear Web desde Cero',style: TextStyle(color: colorFromHex("#165364"),)),
          ],
        ),
        
       
        onPressed: () async {


String nombreWeb="prueba";
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Introduce un nombre para tu web'),
          
          content: TextField(
            onChanged: (valor)=>setState(() {
              nombreWeb=valor;
            }),
          ),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: () async {




bool docExists = await checkIfDocExists(currentUser!+"."+nombreWeb);

if(!docExists){


cargarABBDD(currentUser!+"."+nombreWeb);
Navigator.of(context).pop();




final route = MaterialPageRoute(

    builder: (context){
return CreacionWebsPage(nombreWeb);

    }
  );

Navigator.push(context, route);









}else{



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Ya tienes una web con ese nombre"),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
          ],
        );

      }

    );





}


















                
        },
            ),
          ],
        );

      }

    );












 










}),

);

}

/**
 * GestureDetector cargaTemaPredefinido botón con los temas predefinidos a elegir por el usuario
 * si el usuario no tiene una web con ese nombre la crea y lo lleva al editor
 * @param nombreWebCarga nombre para la plantilla a cargar
 * @param url ur de la imagen de cada tema
 * @nombreWeb nombre para crear la web
 * @param h1 encabezado para crear la web
 * @param h2 encabezado para crear la web
 * @param h3 encabezado para crear la web
 * @param divs contenedores para crear la web
 * @param pageBackground fondo por defecto para la página
 * @return GestureDetector
 */


GestureDetector cargaTemaPredefinido(String nombreWebCarga,String url,String nombreWeb,List h1,List h2,List h3,Map divs,Map divStyles,String pageBackground){

return GestureDetector(
  
                onTap: () {
                  
                 crearTemaEnBBDD(nombreWeb,h1,h2, h3,divs,divStyles,pageBackground);
                 final route = MaterialPageRoute(

    builder: (context){
return CreacionWebsPage(nombreWebCarga);

    }
  );

Navigator.push(context, route);

                },
                child: Image.network(
                url,
                width: 200,
                fit: BoxFit.cover,
                ),
            );

} 

/**
 * funcion que crea un tema en la base de datos con los parametros dados
 * @nombreWeb nombre para crear la web
 * @param h1 encabezado para crear la web
 * @param h2 encabezado para crear la web
 * @param h3 encabezado para crear la web
 * @param divs contenedores para crear la web
 * @param pageBackground fondo por defecto para la página
 */

Future<void> crearTemaEnBBDD(String nombreWeb,List h1,List h2,List h3,Map divs,Map divStyles,String pageBackground)async {
  
  
 String autor=currentUser.toString();

DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(nombreWeb);//.collection("encabezado").doc("unique");

 webActual.set({

"autor" : autor,



 });
   




   DocumentReference webActual2 = FirebaseFirestore.instance.collection('webs').doc(nombreWeb).collection("encabezado").doc("unique");

 return webActual2.set({

"autor" : autor,
"nombre_web" : nombreWeb,
"h1" : h1,//["Titulo","","","","","",""],
"h2" : h2,//["Subtitulo","","","","","",""],
"h3" :h3,//["Subsubtitulo","","","","","",""],
"divs" : divs,
"divsStyles":divStyles,
"pageBackground":pageBackground,
"footer":{"texto":["Pie de página","","","","","","",""],"img":[""]},

 }

 )
          
          
          .catchError((error) => print("Failed to add user: $error"));


}


/**
 * funcion para cargar una web a la base de datos a partir del nombre
 * @param nombreWeb nombre de la web a crear
 */
Future<void> cargarABBDD(String nombreWeb)async {
  
  
 String autor=currentUser.toString();

DocumentReference webActual = FirebaseFirestore.instance.collection('webs').doc(nombreWeb);//.collection("encabezado").doc("unique");

 webActual.set({

"autor" : autor,



 });
   



   DocumentReference webActual2 = FirebaseFirestore.instance.collection('webs').doc(nombreWeb).collection("encabezado").doc("unique");

 return webActual2.set({

"autor" : autor,
"nombre_web" : nombreWeb,
"h1" : ["Titulo","","","","","","",""],
"h2" : ["Subtitulo","","","","","","",""],
"h3" :["Subsubtitulo","","","","","","",""],
"divs" : {},
"divsStyles":{},
"pageBackground":"",
"footer":{"texto":["Pie de página","","","","","","",""],"img":[""]},
//"pageBackgroundURL":""

 }

 )
          
          
          .catchError((error) => print("Failed to add user: $error"));


}

/** 
 * Widget _crearButtonTemas boton para crear una app a partir de un tema
 * @return Column
*/

Widget _crearButtonTemas(){


return Column(children: <Widget>[
  
  Container(
 height: 115.0,
        width: 200.0,

child: FloatingActionButton(
  backgroundColor: colorFromHex("#ffc93d"),
   shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)),
    heroTag: "btn2",
        child: 
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
 Image(
        image: AssetImage('assets/brush.png'),
        fit: BoxFit.cover,
        height: 60,
    ), SizedBox(height: 10),
 Text('Usar un tema predefinido',style: TextStyle(color: colorFromHex("#165364"),)),
          ],
        ),
        
        onPressed: ()async {


String nombreWeb="default";
showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Introduce un nombre para tu web'),
          
          content: TextField(
            onChanged: (valor)=>setState(() {
              nombreWeb=valor;
            }),
          ),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: () async {




bool docExists = await checkIfDocExists(currentUser!+"."+nombreWeb);

if(!docExists){


//cargarABBDD(currentUser!+"."+nombreWeb);
//Navigator.of(context).pop();

showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Selecciona un tema'),
          content:new SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
        SizedBox(height: 50),      
cargaTemaPredefinido(nombreWeb,"https://firebasestorage.googleapis.com/v0/b/ejemploflutt.appspot.com/o/uploads%2Fedujc%40gmail.comPrevEspacio.png?alt=media&token=9f5c406a-ff26-4066-b4b9-6d12abccb9d5",currentUser!+"."+nombreWeb,["Tema del Espacio","","","center","#fff9f9f9","","",""],["The last frontier","","italic","center","#fff7f7f7","","",""],["","","","","","","",""],{"div1":{"0text":["Texto","","","","","","",""],"1img":["edujc@gmail.comspace2.jpg"]},"div2":{"0text":["Texto","","","","","","",""],"1text":["Rellenar con otro texto","","","","","","",""],"2text":["Rellenar con otro texto","","","","","","",""]},"div3":{"0text":["Texto","","","","","","",""],"1video":["https://www.youtube.com/watch?v=4HGlPLYWz5A"]}},{"div1":"#c0b0b0b0","div2":"#9d0f4563","div3":"#c0b0b0b0"},"\$edujc@gmail.comspace.jpg"),
 SizedBox(height: 50),
cargaTemaPredefinido(nombreWeb,"https://firebasestorage.googleapis.com/v0/b/ejemploflutt.appspot.com/o/uploads%2Fedujc%40gmail.comPrevBlog.png?alt=media&token=94e243c1-76f8-40fe-a1dc-50d65a5f871c",currentUser!+"."+nombreWeb,["Mi blog Personal","","","center","#fff9f9f9","","",""],["","","","","","","",""],["","","","","","","",""],{"div1":{"0text":["Mi nueva receta de cocina","","","","","","",""],"1img":["edujc@gmail.comgalletas.jpg"]},"div2":{"0text":["Lecturas recomendadas","","","","","","",""],"1text":["Rellenar con otro texto","","","","","","",""],"2text":["Rellenar con otro texto","","","","","","",""]}},{"div1":"#fff4e7b4","div2":"#fff69568"},"#ff98daf8"),
 SizedBox(height: 50),
cargaTemaPredefinido(nombreWeb,"https://firebasestorage.googleapis.com/v0/b/ejemploflutt.appspot.com/o/uploads%2Fedujc%40gmail.comPrevCarniceria.png?alt=media&token=7441e8d8-9539-4faf-9e5b-54728e037473",currentUser!+"."+nombreWeb,["Carniceria Flaviu","","","center","#fff9f9f9","","",""],["","","","","","","",""],["","","","","","","",""],{"div1":{"0img":["edujc@gmail.comcarne.jpg"],"1text":["Visitanos ya!","","","","","","",""],"2text":["Puedes encontrarnos en Calle Albaricoque, 29120 Málaga","","","","","","",""]}},{"div1":"#c0b0b0b0"},"\$edujc@gmail.comcarne2.jpg"),
//cargaTemaPredefinido(nombreWeb,"https://c8.alamy.com/compes/dnhb9a/troll-aka-muneca-muneca-presa-creada-el-1959-por-thomas-dam-dnhb9a.jpg",currentUser!+"."+nombreWeb,["Mi CV Online","","","center","#fff9f9f9","","",""],["Nombre y Apellidos","","","","","","",""],["","","","","","","",""],{"div1":{"0text":["Estudios","","","","","","",""],"1text":["Ejemplo","","","","","","",""],"2text":["Idiomas","","","","","","",""],"3text":["Ejemplos de idiomas","","","","","","",""]},"div2":{"0img":[""],"1text":["Visitanos ya!","","","","","","",""],"2text":["Puedes encontrarnos en Calle Albaricoque, 29120 Málaga","","","","","","",""]}},{"div1":"#c0b0b0b0"},"\$edujc@gmail.comspace.jpg"),          
 SizedBox(height: 50),

            ],

          ),
          ),
          




          actions: <Widget>[
           
            TextButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
          ],
        );

      }

    );











}else{



showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

         return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error'),
          
          content: Text("Ya tienes una web con ese nombre"),
          actions: <Widget>[
           
            TextButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
        },
            ),
          ],
        );

      }

    );





}


















                
        },
            ),
          ],
        );

      }

    );












 










}),

),







]);



}

/** 
 * Widget _crearButtonVolver boton para volver a la página anterior
 * @return Column
*/
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