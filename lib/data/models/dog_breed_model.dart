class DogBreedModel {
  final String? id;
  final String? name;
  final String? description;
  final String? lifeSpan;
  final double? maleWeightMin;
  final double? maleWeightMax;
  final double? femaleWeightMin;
  final double? femaleWeightMax;
  final bool? hypoallergenic;

  const DogBreedModel({
    this.id,
    this.name,
    this.description,
    this.lifeSpan,
    this.maleWeightMin,
    this.maleWeightMax,
    this.femaleWeightMin,
    this.femaleWeightMax,
    this.hypoallergenic,
  });

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    return DogBreedModel(
      id: json['id'],
      name: attributes['name'] ?? '',
      description: attributes['description'] ?? '',
      lifeSpan: attributes['life_span'] ?? 'N/A',
      maleWeightMin: _parseWeight(attributes['male_weight_kgs']?['min']),
      maleWeightMax: _parseWeight(attributes['male_weight_kgs']?['max']),
      femaleWeightMin: _parseWeight(attributes['female_weight_kgs']?['min']),
      femaleWeightMax: _parseWeight(attributes['female_weight_kgs']?['max']),
      hypoallergenic: attributes['hypoallergenic'] == true,
    );
  }

  static double _parseWeight(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': {
        'name': name,
        'description': description,
        'life_span': lifeSpan,
        'male_weight_kgs': {'min': maleWeightMin, 'max': maleWeightMax},
        'female_weight_kgs': {'min': femaleWeightMin, 'max': femaleWeightMax},
        'hypoallergenic': hypoallergenic,
      },
    };
  }
}
