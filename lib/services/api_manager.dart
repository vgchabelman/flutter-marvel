import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel_heroes/constants/strings.dart';
import 'package:marvel_heroes/models/marvel.dart';

class ApiManager {
  final url = Uri.parse('');

  Future<Marvel?> getCharacters() async {
    var client = http.Client();

    var response = await client.get(Uri.parse(Strings.charactersUrl));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var jsonMap = json.decode(jsonResponse);
      return marvelFromJson(jsonMap);
    }

    return null;
  }
}