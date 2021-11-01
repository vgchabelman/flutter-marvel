
import 'package:marvel_heroes/src/constants/config.dart';

class Strings {
  static const String baseUrl = 'https://gateway.marvel.com/v1/public';
  static const String apikey = 'c81f6350e5072be3dda96c8bff99064e';

  static String charactersUrl() {
    var timestampHash = Config.getHash();
    var url = baseUrl + '/characters?ts=' + timestampHash.item1 + '&hash=' + timestampHash.item2 + '&apikey=' + apikey;
    return url;
  }
}
