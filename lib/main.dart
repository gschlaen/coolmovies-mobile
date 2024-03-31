import 'package:coolmovies/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));

  // final HttpLink httpLink = HttpLink(
  //   Platform.isAndroid
  //       ? 'http://10.0.2.2:5001/graphql'
  //       : 'http://localhost:5001/graphql',
  // );

  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //   GraphQLClient(
  //     link: httpLink,
  //     cache: GraphQLCache(store: InMemoryStore()),
  //   ),
  // );

  // runApp(GraphQLProvider(
  //   client: client,
  //   child: const MyApp(),
  // ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Coolmovies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final ValueNotifier<Map<String, dynamic>?> _data = ValueNotifier(null);
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   void _fetchData() async {
//     print('Fetching data...');
//     var client = GraphQLProvider.of(context).value;

//     final QueryResult result = await client.query(QueryOptions(
//       document: gql(r"""
//           query AllMovies {
//             allMovies {
//               nodes {
//                 id
//                 imgUrl
//                 movieDirectorId
//                 userCreatorId
//                 title
//                 releaseDate
//                 nodeId
//                 userByUserCreatorId {
//                   id
//                   name
//                   nodeId
//                 }
//               }
//             }
//           }
//         """),
//     ));

//     if (result.hasException) {
//       print(result.exception.toString());
//     }

//     if (result.data != null) {
//       _data.value = result.data!['allMovies'];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.only(top: 36.0),
//                   child: Text(
//                     """Thank you for taking the time to take our test. We really appreciate it.
// All the information on what is required can be found in the README at the root of this repo.
// Please dont spend ages on this and just get through as much of it as you can.
// Good luck! :)""",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextButton.icon(
//                   onPressed: _incrementCounter,
//                   icon: const Icon(Icons.add),
//                   label: Text('Increment: $_counter'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue,
//                   ),
//                 ),
//                 OutlinedButton.icon(
//                   onPressed: _fetchData,
//                   icon: const Icon(Icons.download),
//                   label: const Text('Fetch data'),
//                 ),
//                 const SizedBox(height: 16),
//                 ValueListenableBuilder(
//                     valueListenable: _data,
//                     builder: (BuildContext context, Map<String, dynamic>? data,
//                         Widget? _) {
//                       return data != null
//                           ? Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   border: Border.all(
//                                       color: Colors.grey.shade700, width: 1),
//                                   borderRadius: BorderRadius.circular(4)),
//                               child: Text(data.toString()),
//                             )
//                           : Container();
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ), 
//     );
//   }
// }
