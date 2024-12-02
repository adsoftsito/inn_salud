import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'MyAppState.dart';

const String query = """
query   Profile {
  profile
  {
     nombre
    apellido
    sexo
    edad
    email
    diabetes
    diabetesp
    postedBy {
      username
    }
   
  }
}
""";

String createProfileMutation = """
mutation CreateProfile(\$nombre : String!,  \$apellido : String!, \$edad : Int!,
\$sexo : Int!,  \$email : String!, \$diabetes : Int!, , \$diabetesp : Int!) {
  createProfile(
    nombre: \$nombre 
    apellido: \$apellido 
    edad: \$edad 
    sexo: \$sexo 
    email: \$email 
    diabetes: \$diabetes 
    diabetesp: \$diabetesp 
  ) {
     nombre
    apellido
    edad
    sexo
    email
    diabetes
    diabetesp   
  }
}
""";

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {


//class PerfilPage extends /*StatelessWidget*/ Stateful {

//class PerfilPage extends /*StatelessWidget*/ Stateful {

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();

  TextEditingController edadController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController diabetesController = TextEditingController();
  TextEditingController diabetespController = TextEditingController();


List<DropdownMenuItem<String>> get sexoItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Masculino"),value: "0"),
    DropdownMenuItem(child: Text("Femenino"),value: "1"),
  ];
  return menuItems;
}
String selectedSexo = '0';

List<DropdownMenuItem<String>> get dItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Si"),value: "1"),
    DropdownMenuItem(child: Text("No"),value: "0"),
  ];
  return menuItems;
}
String selectedD = '0';


 List<DropdownMenuItem<String>> get diabItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Ninguno"),value: "0"),
    DropdownMenuItem(child: Text("Papa"),value: "1"),
    DropdownMenuItem(child: Text("Mama"),value: "2"),
    DropdownMenuItem(child: Text("Ambos"),value: "3"),

  ];
  return menuItems;
}
String selectedDiab = '0';



  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();

    if (appState.token.isEmpty) {
      return Center(
        child: Text('No login yet.'),
      );
    }



  /*
 Future.delayed(Duration.zero,()  
 {
    showDialog(
      context: context,
      builder: (BuildContext context) {

      return Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{"variableName": "value"}),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  final profile = result.data!['profile'];
                  print('profile...');
                  print(profile);

                  if (profile == null) {
                      print(profile);

                  }
                  else {
                            nombreController.text = "adsoftsito";
   /* apellidoController.text = profile["apellido"];
        edadController.text = profile["edad"].toString();
        sexoController.text = profile["sexo"].toString();
        emailController.text = profile["email"];
        diabetesController.text = profile["diabetes"].toString();
        diabetespController.text = profile["diabetesp"].toString();*/

                  }
                  
                  return const Center(
                      child: Text("querying profile!"),
                    );

                }
                );
    }
      
  );
  
  */


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       
                Text(
                   "Perfil :${appState.username}",
                ),
          SizedBox(height: 20),
            TextFormField(
                keyboardType: TextInputType.text,
                controller: nombreController,
                decoration: InputDecoration(
                   labelText: 'nombre',
                    border: OutlineInputBorder(),
                    hintText: 'nombre',

                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: apellidoController,
                decoration: InputDecoration(
                   labelText: 'apellido',
                    border: OutlineInputBorder(),
                    hintText: 'apellido',

                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter apellido';
                  }
                  return null;
                },
              ),            
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: edadController,
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
                   labelText: 'edad',
                    border: OutlineInputBorder(),
                    hintText: 'edad',

                  ),

                onChanged: (value) => {

                },
              )          

            ,
                        Text(
                  "Sexo ?",
            ),

              DropdownButton(
                  value: selectedSexo,
                  onChanged: (String? newValue){
                  setState(() {
                        selectedSexo = newValue!;
                  });
                  },
                  items: sexoItems
              ),
            //SizedBox(height: 20),
           // Text('Selected Value: $selectedSexo'),

              TextFormField(
                keyboardType: TextInputType.text,
                controller: emailController,
                decoration: InputDecoration(
                   labelText: 'e-mail',
                    border: OutlineInputBorder(),
                    hintText: 'e-mail',

                  ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email ';
                  }
                  return null;
                },
              ),            


            Text(
                  "Padeces diabetes ?",
            ),
              DropdownButton(
                  value: selectedD,
                  onChanged: (String? newValue){
                  setState(() {
                        selectedD = newValue!;
                  });
                  },
                  items: dItems
              ),
            //SizedBox(height: 20),
            //Text('Selected Value: $selectedD'),
             Text(
                  "Padeces diabetes tus padres?",
            ),

              DropdownButton(
                  value: selectedDiab,
                  onChanged: (String? newValue){
                  setState(() {
                        selectedDiab = newValue!;
                  });
                  },
                  items: diabItems
              ),
            //SizedBox(height: 20),
            //Text('Selected Value: $selectedDiab'),
            Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                            Mutation(
                options: MutationOptions(
                  document: gql(createProfileMutation),
                  // ignore: void_checks
                  update: (cache, result) {
                      return cache;
                  },
                  onCompleted: (result) {
                      if (result == null) {
                         print('Completed with errors ');
                       }
                      else {
                          print('ok ...');
                          //appState.username = userNameController.text;
                          //appState.token = result["tokenAuth"]["token"].toString();
                          print(result);
                          Alert(context: context, 
                            type: AlertType.info,
                            title: appState.username, 
                            desc: "Tus datos de perfil han sido actualizados",
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
                    //appState.error = error!.graphqlErrors[0].message.toString();
                      print(error?.graphqlErrors[0].message);

                      appState.error = error!.graphqlErrors[0].message.toString();

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
                                  "nombre":   nombreController.text, 
                                  "apellido": apellidoController.text,
                                  "edad":     int.parse(edadController.text),
                                  "sexo":    int.parse(selectedSexo), 
                                  "email":    emailController.text,
                                  "diabetes": int.parse(selectedD),
                                  "diabetesp": int.parse(selectedDiab)
                                  
                                });
                  },
                  child: const Text('Update Profile'),
                   );
                }           
            ),

            ],
          ),

          Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{"variableName": "value"},
                    onComplete: (result) {
                      if (result == null) {
                         print('Completed with errors ');
                       }
                      else {
                          print('completed ...');
                          //appState.username = userNameController.text;
                          //appState.token = result["tokenAuth"]["token"].toString();
                          //print(result['profile']);

                          final profile = result['profile'];
                  print('profile...');
                  print(profile);

                  if (profile == null) {
                      print(profile);

                  }
                  else {


            nombreController.text = profile["nombre"];
            apellidoController.text = profile["apellido"];
            edadController.text = profile["edad"].toString();
            //selectedSexo = profile["sexo"].toString();
            emailController.text = profile["email"];
            
                  setState(() {
                        selectedSexo = profile["sexo"].toString();
                        selectedD = profile["diabetes"].toString();
                        selectedDiab = profile["diabetesp"].toString();

                  });


                  }




                     }
                  },
                  onError: (error)  {
                      print('error :');
                    //appState.error = error!.graphqlErrors[0].message.toString();
                      print(error?.graphqlErrors[0].message);
                  },
                    ),
                  builder: (result, {fetchMore, refetch}) {
                        if (result.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                  }
                  return const Center(
                      child: Text(""),
                    );

                }),

        ],
      ),
    );
  }
} 
