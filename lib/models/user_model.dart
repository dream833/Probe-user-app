class UserModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? pin;
  String? presentAddress;
  String? permanentAddress;
  String? image;

  // Constructor
  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.pin,
    required this.presentAddress,
    required this.permanentAddress,
    required this.image,
  });

  // Factory constructor to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      email: map['email'] ?? '',
      pin: map['pin'] ?? '',
      presentAddress: map['present_address'] ?? '',
      permanentAddress: map['permanent_address'] ?? '',
    );
  }

  // Convert the UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'pin': pin,
      'present_address': presentAddress,
      'permanent_address': permanentAddress,
    };
  }
}
