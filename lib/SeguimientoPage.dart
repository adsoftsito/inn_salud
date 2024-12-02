import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import "MyAppState.dart";
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String linkPostMutation = """
mutation CreateRecord(\$talla : Int!,  
                      \$cintura : Int!,
                      \$cadera : Int!,
                      \$peso : Float!,  
                      \$actfisica : Int!,
                      \$actfisican : Int!,  
                      \$bebidasugar : Int!,
                      \$bebidasugarn : Int!,                      
                      ) {
  createRecord(
    talla: \$talla 
    cintura: \$cintura
    cadera: \$cadera 
    peso: \$peso
    actfisica: \$actfisica 
    actfisican: \$actfisican
    bebidasugar: \$bebidasugar 
    bebidasugarn: \$bebidasugarn
  ) {
    talla
    peso
    cintura
    cadera
    actfisica
    actfisican
    bebidasugar
    bebidasugarn
    postedBy {
      username
    }
  }
}
""";

class SeguimientoPage extends StatelessWidget {

  TextEditingController tallaController = TextEditingController();
  TextEditingController cinturaController = TextEditingController();
  TextEditingController caderaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  //TextEditingController actfisicaController = TextEditingController();
  TextEditingController actfisicanController = TextEditingController();
  //TextEditingController bebidasugarController = TextEditingController();
  TextEditingController bebidasugarnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();

    var appState = context.watch<MyAppState>();

    if (appState.token.isEmpty) {
      return Center(
        child: Text('No login yet.'),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

                Text(
                   "Bienvenido :${appState.username}",

                ),
          SizedBox(height: 20),

            Text(
                  "Seguimiento Semanal",
            ),
          SizedBox(height: 20),

            TextFormField(
                keyboardType: TextInputType.number,
                controller: tallaController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                }
                    return null;
                },


                decoration: InputDecoration(
                   labelText: 'Talla, altura (cms)',
                    border: OutlineInputBorder(),
                    hintText: 'Talla, altura (cms)',

                  ),
              ),
               SizedBox(height: 20),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: pesoController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                }
                    return null;
                },

                decoration: InputDecoration(
                   labelText: 'Peso (kg)',
                    border: OutlineInputBorder(),
                    hintText: 'Peso (kg)',

                  ),
              ),
                      SizedBox(height: 20),

             TextFormField(
                keyboardType: TextInputType.number,
                controller: cinturaController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                }
                    return null;
                },

                decoration: InputDecoration(
                   labelText: 'Medida cintura (cms)',
                    border: OutlineInputBorder(),
                    hintText: 'Medida cintura (cms)',

                  ),
              ),
                        SizedBox(height: 20),

               TextFormField(
                keyboardType: TextInputType.number,
                controller: caderaController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                }
                    return null;
                },

                decoration: InputDecoration(
                   labelText: 'Medida de cadera (cms)',
                    border: OutlineInputBorder(),
                    hintText: 'Medida de cadera (cms)',

                  ),
              ),

          SizedBox(height: 20),

             TextFormField(
                keyboardType: TextInputType.number,
                controller: actfisicanController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                  if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                  }
                    return null;
                },

                decoration: InputDecoration(
                   labelText: 'Cuantas veces realizaste actividad fisica ?',
                    border: OutlineInputBorder(),
                    hintText: 'Cuantas veces realizaste actividad fisica ?',

                  ),
              ),

                     SizedBox(height: 20),

                      TextFormField(
                keyboardType: TextInputType.number,
                controller: bebidasugarnController,
                inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only digits
                ],
                validator: (value) {
                if (value!.isEmpty || value.length < 1) {
                    return 'Please enter a number';
                }
                    return null;
                },

                decoration: InputDecoration(
                   labelText: 'Cuantas bebidas azucaradas tomaste ?',
                    border: OutlineInputBorder(),
                    hintText: 'Cuantas bebidas azucaradas tomaste ?',

                  ),
              ),
 

          SizedBox(height: 20),

           Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             Mutation(
               options: MutationOptions(
                 document: gql(linkPostMutation),
                 // ignore: void_checks
                 update: (cache, result) {
                     return cache;
                 },
                 onCompleted: (result) {
                 if (result == null) {
                      print('Completed with errors ');
                   }  else {
                     print('ok ...');
                     print(result);

                    Alert(context: context, 
                            type: AlertType.info,
                            title: appState.username, 
                            desc: "Tu registro se ha guardado correctamente",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Aceptar",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )]
                      ).show();

                   }
                 },
                 onError: (error)  {
                   print('error :');
                   appState.error = error!.graphqlErrors[0].message.toString();
                   print(error?.graphqlErrors[0].message);

                   Alert(context: context, 
                            type: AlertType.error,
                            title: appState.username, 
                            desc:  appState.error,
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Aceptar",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )]
                      ).show();

                 },

               ),
               builder: ( runMutation,  result) {

                 return ElevatedButton(
                 onPressed: ()  {
                   // ignore: await_only_futures
                   runMutation({  
                                  "talla": int.tryParse(tallaController.text),
                                  "peso": double.tryParse(pesoController.text),
                                  "cintura": int.tryParse(cinturaController.text),
                                  "cadera": int.tryParse(caderaController.text),
                                  "actfisica": 0,
                                  "actfisican": int.tryParse(actfisicanController.text),
                                  "bebidasugar" : 0,
                                  "bebidasugarn": int.tryParse(bebidasugarnController.text)

                               });
                 },
                 child: const Text('Guardar registro'),
                  );
               }          
              ),

              /*
              ElevatedButton(
                onPressed: () {
                  //appState.callModel();
                },
                child: Text('Guardar registro'),
              ),
              */
            ],
          ),
        ],
      ),
    );
  }
} 
