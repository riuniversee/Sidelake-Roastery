class CoffeeBean {
  final String id;
  final String name;
  final String origin;
  final String process;
  final String roastLevel;
  final String flavorNotes;
  final double price;
  final String imageUrl;

  CoffeeBean({
    required this.id,
    required this.name,
    required this.origin,
    required this.process,
    required this.roastLevel,
    required this.flavorNotes,
    required this.price,
    required this.imageUrl,
  });

  factory CoffeeBean.fromJson(Map<String, dynamic> json) {
    return CoffeeBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown Bean',
      origin: json['origin'] ?? 'Indonesia',
      process: json['process'] ?? 'Natural',
      roastLevel: json['roast_level'] ?? 'Medium Roast',
      flavorNotes: json['flavor_notes'] ?? 'Fruity, Sweet',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500',
    );
  }
}