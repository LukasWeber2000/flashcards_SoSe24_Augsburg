class Deck {
  final String name;

  Deck({required this.name});

  // Convert a Deck instance into a map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  // A factory constructor for creating a new Deck instance from a map structure.
  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      name: json['name'], // Make sure to use the same key you used in toJson
    );
  }
}
