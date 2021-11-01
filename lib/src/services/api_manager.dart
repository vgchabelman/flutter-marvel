import 'package:http/http.dart' as http;
import 'package:marvel_heroes/src/constants/strings.dart';
import 'package:marvel_heroes/src/models/marvel.dart';

class ApiManager {
  final url = Uri.parse('');

  Future<Marvel?> getCharacters() async {
    var client = http.Client();

    var response = await client.get(Uri.parse(Strings.charactersUrl()));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      return marvelFromJson(jsonResponse);
    }

    return null;
  }
}