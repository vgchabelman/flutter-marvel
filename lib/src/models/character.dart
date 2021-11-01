
import 'comics.dart';
import 'marvel.dart';

class Character {
  Character({
    required this.id,
    required this.name,
    // this.description,
    // this.modified,
    required this.thumbnail,
    // this.resourceUri,
    // this.comics,
    // this.series,
    // this.stories,
    // this.events,
    // this.urls,
  });

  int id;
  String name;
  // String? description;
  // String? modified;
  Thumbnail thumbnail;
  // String? resourceUri;
  // Comics? comics;
  // Comics? series;
  // Stories? stories;
  // Comics? events;
  // List<Url>? urls;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json["id"],
    name: json["name"],
    // description: json["description"],
    // modified: json["modified"],
    thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    // resourceUri: json["resourceURI"],
    // comics: Comics.fromJson(json["comics"]),
    // series: Comics.fromJson(json["series"]),
    // stories: Stories.fromJson(json["stories"]),
    // events: Comics.fromJson(json["events"]),
    // urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    // "description": description,
    // "modified": modified,
    // "thumbnail": thumbnail?.toJson(),
    // "resourceURI": resourceUri,
    // "comics": comics?.toJson(),
    // "series": series?.toJson(),
    // "stories": stories?.toJson(),
    // "events": events?.toJson(),
    // "urls": List<dynamic>.from(urls!.map((x) => x.toJson())),
  };
}

class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });

  String path;
  Extension extension;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: extensionValues.map[json["extension"]]!,
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "extension": extensionValues.reverse[extension],
  };

  String getImageUrl() {
    return '$path.${extensionValues.reverse[extension]}';
  }
}

enum Extension { jpg, gif }

final extensionValues = EnumValues({
  "gif": Extension.gif,
  "jpg": Extension.jpg
});