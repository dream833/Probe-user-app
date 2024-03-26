class LabTestModel {
  String testName;
  String testType;
  double testCost;
  double discount;
  double rating;
  String additionalDetails;
  bool isHomeCollection; // New parameter

  LabTestModel({
    required this.testName,
    required this.testType,
    required this.testCost,
    required this.discount,
    required this.rating,
    required this.additionalDetails,
    required this.isHomeCollection, // Include the new parameter in the constructor
  });

  LabTestModel copyWith({
    String? testName,
    String? testType,
    double? testCost,
    double? discount,
    double? rating,
    String? additionalDetails,
    bool? isHomeCollection, // Include the new parameter in the copyWith method
  }) {
    return LabTestModel(
      testName: testName ?? this.testName,
      testType: testType ?? this.testType,
      testCost: testCost ?? this.testCost,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      isHomeCollection:
          isHomeCollection ?? this.isHomeCollection, // Assign the new parameter
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'testType': testType,
      'testCost': testCost,
      'discount': discount,
      'rating': rating,
      'additionalDetails': additionalDetails,
      'isHomeCollection':
          isHomeCollection, // Include the new parameter in the JSON representation
    };
  }

  factory LabTestModel.fromJson(Map<String, dynamic> json) {
    return LabTestModel(
      testName: json['testName'],
      testType: json['testType'],
      testCost: json['testCost'],
      discount: json['discount'],
      rating: json['rating'],
      additionalDetails: json['additionalDetails'],
      isHomeCollection:
          json['isHomeCollection'], // Parse the new parameter from JSON
    );
  }
}
