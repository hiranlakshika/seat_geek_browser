class Performer {
  Performer({
    required this.name,
    required this.image,
  });

  late final String name;
  late final String image;

  Performer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
