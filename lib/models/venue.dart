class Venue {
  Venue({
    required this.state,
    required this.nameV2,
    required this.postalCode,
    required this.name,
    required this.address,
    required this.country,
    required this.city,
    required this.extendedAddress,
    required this.displayLocation,
  });

  late final String state;
  late final String nameV2;
  late final String postalCode;
  late final String name;
  late final String address;
  late final String country;
  late final String city;
  late final String extendedAddress;
  late final String displayLocation;

  Venue.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    nameV2 = json['name_v2'];
    postalCode = json['postal_code'];
    name = json['name'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    extendedAddress = json['extended_address'];
    displayLocation = json['display_location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['state'] = state;
    data['name_v2'] = nameV2;
    data['postal_code'] = postalCode;
    data['name'] = name;
    data['address'] = address;
    data['country'] = country;
    data['city'] = city;
    data['extended_address'] = extendedAddress;
    data['display_location'] = displayLocation;
    return data;
  }
}
