import 'dart:convert';

class OnboardingModel {
  String image;
  String title;
  String description;
  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  OnboardingModel copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return OnboardingModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'description': description,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      image: map['image'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnboardingModel(title: $title, description: $description)';

  @override
  bool operator ==(covariant OnboardingModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;
}
