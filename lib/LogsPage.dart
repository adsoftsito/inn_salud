import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'blog_row.dart';
import "MyAppState.dart";

const String query = """
query   Records {
  records
  {
    talla
    peso
    cintura
    cadera
    actfisica
    actfisican
    bebidasugar
    bebidasugarn
    fecha
    postedBy {
      username
    }
  }
}
""";


class LogsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    var appState = context.watch<MyAppState>();

    if (appState.token.isEmpty) {
      return Center(
        child: Text('No login yet.'),
      );
    }
    return         
          Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{"variableName": "value"}),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(result);
                  
                  final posts = result.data!['records'];

                  if (posts.length == 0) {
                    return const Center(
                      child: Text("No logs found!"),
                    );
                  }
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final fecha = post['fecha'];
                      final talla = post['talla'];
                      final peso = post['peso'];
                      final cintura = post['cintura'];
                      final cadera = post['cadera'];
                      final actividadfisica = post['actfisican'];
                      final bebidasugar = post['bebidasugarn'];

                      //final user = post["postedBy"]["username"];
                      return BlogRow(
                        fecha: fecha,
                        talla: talla, 
                        peso: peso,  
                        cintura: cintura, 
                        cadera: cadera, 
                        actividadfisica: actividadfisica,
                        bebidasugar: bebidasugar, 

                      );
                    },
                  );
            }
          );
            
   }
}
