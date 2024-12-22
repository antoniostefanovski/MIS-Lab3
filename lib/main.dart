import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/favorites.dart';
import 'package:lab2_mis/screens/home.dart';
import 'package:lab2_mis/screens/joke.dart';
import 'package:lab2_mis/screens/random_joke.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/random_joke' : (context) => const RandomJoke(),
        // '/favorite_jokes' : (context) => const FavoritesScreen()
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/joke_details') {
          final String jokeType = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => JokeDetails(jokeType: jokeType),
          );
        }
        return null;
      },
    );
  }

}
