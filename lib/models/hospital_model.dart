class Hospital {
  final String name;
  final String address;
  final String phoneNumber;
  final String website;
  final int bedCount;
  final bool hasEmergencyServices;
  final String imageUrl; // New image parameter

  Hospital({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.website,
    required this.bedCount,
    required this.hasEmergencyServices,
    required this.imageUrl,
  });
}
