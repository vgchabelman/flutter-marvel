import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:marvel_heroes/src/constants/strings.dart';
import 'package:marvel_heroes/src/models/marvel.dart';

class ApiManager {
  final url = Uri.parse('');

  Future<Marvel?> getCharacters({int offset = 0}) async {
    var client = http.Client();

    var url = Strings.charactersUrl();
    url = _addQueryParams(url, {Strings.queryOffset: offset.toString()});

    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      return marvelFromJson(jsonResponse);
    }

    return null;
  }

  String _addQueryParams(String url, Map<String, String> queries) {
    var result = url;
    queries.forEach((key, value) {
      result = "$result&$key=$value";
    });
    return result;
  }
}
