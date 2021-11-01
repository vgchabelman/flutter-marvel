

import 'comics_item.dart';

class Comics {
  Comics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int? available;
  String? collectionUri;
  List<ComicsItem>? items;
  int? returned;

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "returned": returned,
  };
}
