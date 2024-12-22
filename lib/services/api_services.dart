import 'package:http/http.dart' as http;

class ApiService {

  static Future<http.Response> getRandomJokes() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    return response;
  }

  static Future<http.Response> getJokeTypes() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    return response;
  }

  static Future<http.Response> getJokeWithType(String type) async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      return response;
    }
    else{
      throw Exception("Failed to load data!");
    }
  }
}