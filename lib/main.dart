//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'LoginPage.dart';
import 'LogsPage.dart';
import "SeguimientoPage.dart";
import "RecomendacionesPage.dart";
//import "HistorialPage.dart";
import "PerfilPage.dart";
import "MyAppState.dart";
//import "scanner_rostro.dart";

//import 'dart:convert';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart' show rootBundle;
//import 'package:rflutter_alert/rflutter_alert.dart';




//final HttpLink httpLink = HttpLink("https://mysite-hdva.onrender.com/graphql/");



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (context) => MyAppState(),

      


      child: MaterialApp(
        title: 'innSalud',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        ),
        home: MyHomePage(),
      ),
    );
  }
}
/*
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  var token = "";
  var username = "";

  GlobalKey? historyListKey;

  /*
  final url = Uri.parse("https://fastapi-ml-latest.onrender.com/score");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  void callModel() async {
        print('hello model...');
        try {
        final prediction_instance = {
         "age": 64,
         "sex": 1,
         "cp": 3,
         "trestbps": 120,
         "chol": 267,
         "fbs": 0,
         "restecg": 0,
        "thalach": 99,
        "exang": 1,
        "oldpeak": 1.8,
        "slope": 1,
        "ca": 2,
        "thal": 2
      };

      final res = await http.post(url, headers: headers, body: jsonEncode(prediction_instance));
    
      if (res.statusCode == 200) {
        final json_prediction = (res.body);
                 print(  json_prediction);
      }
      else {
        print('error');
      }
    } catch (e) {
      print(e.toString());
    }

 }*/

  var favorites = <WordPair>[];
  /*
  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }*/
}
*/
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    //selectedIndex = appState.selectedIndex;

    final AuthLink authLink = AuthLink(
    getToken: () async {
        print ('token ${appState.token} OK');
        return 'JWT ${appState.token}';
        },
    );
    final Link httpLink = authLink.concat(HttpLink('https://adsoftsito-api.onrender.com/graphql/'));
    //final Link httpLink = authLink.concat(HttpLink('http://localhost:8000/graphql/'));
    
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    var colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (appState.selectedIndex) {
      case 0:
        page = LoginPage();
        break;

      case 1:
        page =  SeguimientoPage();
                break;

    /*  case 2:
        page = RecomendacionesPage();
                break;
*/
      case 2:
        page = LogsPage(); //HistorialPage();
                break;

      case 3:
        page = PerfilPage();
                break;


      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
/*
var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
*/

 // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.onError,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return GraphQLProvider (
      client: client, 
      child : Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Login',
                        backgroundColor: Color.fromRGBO(0, 0, 255, 0)
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add_card),
                        label: 'Seguimiento',
                        backgroundColor: Color.fromRGBO(0, 0, 255, 0)

                      ),
            /*          BottomNavigationBarItem(
                        icon: Icon(Icons.heart_broken),
                        label: 'Recomendaciones',
                        backgroundColor: Color.fromRGBO(0, 0, 255, 0)

                      ),*/

                      BottomNavigationBarItem(
                        icon: Icon(Icons.abc_sharp),
                        label: 'Historial',
                        backgroundColor: Color.fromRGBO(0, 0, 255, 0)

                      ),
                      
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add_box),
                        label: 'Perfil',
                        backgroundColor: Color.fromRGBO(0, 0, 255, 0)

                      ),
       
                    ],
                    currentIndex: appState.selectedIndex,
                    onTap: (value) {
                      setState(() {
                        appState.selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Login'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.add_card),
                        label: Text('Seguimiento'),
                      ),
                    /*  NavigationRailDestination(
                        icon: Icon(Icons.heart_broken),
                        label: Text('Recomendaciones'),
                      ),*/

                      NavigationRailDestination(
                        icon: Icon(Icons.abc_sharp),
                        label: Text('Historial'),
                      ),
                      
                      NavigationRailDestination(
                        icon: Icon(Icons.add_box),
                        label: Text('Perfil'),
                      ),
                      
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        appState.selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
     ),
    );
  }
}



/*
class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

/*
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var pair in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      appState.removeFavorite(pair);
                    },
                  ),
                  title: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

*/

/*

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}
*/

/*
class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
}
*/
