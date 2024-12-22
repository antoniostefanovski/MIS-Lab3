import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/favorites.dart';
import 'package:lab2_mis/screens/random_joke.dart';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../services/api_services.dart';
import '../widgets/home/joke_types_card.dart';
import '../widgets/home/route_button.dart';
import 'joke.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await Firebase.initializeApp();
    getJokeTypes();
    _initializeFirebase();
    _initializeLocalNotifications();
  }

  void _initializeFirebase() async {
    await Firebase.initializeApp();

    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    scheduleDailyNotification();
  }

  Future<void> scheduleDailyNotification() async {
    var time = Time(8, 0, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Reminder',
      'Check out today\'s joke!',
      time,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification_channel',
          'Daily Notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  void _showLocalNotification(RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id', 'your_channel_name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  void getJokeTypes() async {
    ApiService.getJokeTypes().then((response) {
      var data = json.decode(response.body);
      setState(() {
        jokeTypes = List<String>.from(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('211137 - Jokes'),
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          RouteButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RandomJoke(),
                ),
              );
            }, btnText: 'Random Joke',
          ),
          RouteButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteJokes(),
                ),
              );
            }, btnText: 'Favorite Jokes',
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypesCard(
                  jokeType: jokeTypes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeDetails(
                          jokeType: jokeTypes[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
