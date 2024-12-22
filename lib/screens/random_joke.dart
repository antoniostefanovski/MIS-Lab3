import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lab2_mis/services/api_services.dart';
import 'package:lab2_mis/widgets/random_joke/random_joke_title.dart';

import '../models/joke.dart';
import '../widgets/back_home_btn.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();

}

class _RandomJokeState extends State<RandomJoke> {
    late Future<Joke> joke;

    @override
  void initState() {
    super.initState();
    joke = getRandomJoke();}

    Future<Joke> getRandomJoke() async {
      var response = await ApiService.getRandomJokes();
      var data = json.decode(response.body);
      return Joke(id: data['id'],
                  type: data['type'],
                  setup: data['setup'],
                  punchline: data['punchline']);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Random Joke'),
        ),
        body: FutureBuilder<Joke>(
            future: joke,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final joke = snapshot.data!;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RandomJokeType(id: joke.id, type: joke.type),
                      Text(
                        joke.setup,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        joke.punchline,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      const BackHomeBtn(),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Joke does not exist'));
              }
            },
        ),
      );
    }

}