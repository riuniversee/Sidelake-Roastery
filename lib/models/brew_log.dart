class BrewLog {
  final int? id;
  final String beanName;
  final String origin;
  final String brewMethod;
  final String grindSize;
  final double rating;
  final String personalNote;
  final DateTime? createdAt;

  BrewLog({
    this.id,
    required this.beanName,
    required this.origin,
    required this.brewMethod,
    required this.grindSize,
    required this.rating,
    required this.personalNote,
    this.createdAt,
  });

  factory BrewLog.fromJson(Map<String, dynamic> json) {
    return BrewLog(
      id: json['id'],
      beanName: json['bean_name'] ?? '',
      origin: json['origin'] ?? '',
      brewMethod: json['brew_method'] ?? '',
      grindSize: json['grind_size'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      personalNote: json['personal_note'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'bean_name': beanName,
      'origin': origin,
      'brew_method': brewMethod,
      'grind_size': grindSize,
      'rating': rating,
      'personal_note': personalNote,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}