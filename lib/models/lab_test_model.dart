class LabTestModel {
  String testName;
  String testType;
  double testCost;
  //double discount;
  //double rating;
  String additionalDetails;
  bool isHomeCollection; // New parameter

  LabTestModel({
    required this.testName,
    required this.testType,
    required this.testCost,
    // required this.discount,
    //required this.rating,
    required this.additionalDetails,
    required this.isHomeCollection, // Include the new parameter in the constructor
  });

  LabTestModel copyWith({
    String? testName,
    String? testType,
    double? testCost,
    // double? discount,
    // double? rating,
    String? additionalDetails,
    bool? isHomeCollection, // Include the new parameter in the copyWith method
  }) {
    return LabTestModel(
      testName: testName ?? this.testName,
      testType: testType ?? this.testType,
      testCost: testCost ?? this.testCost,
      //discount: discount ?? this.discount,
      //rating: rating ?? this.rating,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      isHomeCollection:
          isHomeCollection ?? this.isHomeCollection, // Assign the new parameter
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': testName,
      'method': testType,
      'rate': testCost,
      // 'discount': discount,
      //'rating': rating,
      'comments': additionalDetails,
      'homeCollection':
          isHomeCollection, // Include the new parameter in the JSON representation
    };
  }

  factory LabTestModel.fromJson(Map<String, dynamic> json) {
    return LabTestModel(
      testName: json['name'],
      testType: json['method'],
      testCost: json['rate'],
      //   discount: json['discount'],
      // rating: json['rating'],
      additionalDetails: json['comments'],
      isHomeCollection:
          json['homeCollection'], // Parse the new parameter from JSON
    );
  }
}
