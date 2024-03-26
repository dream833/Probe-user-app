// ignore_for_file: constant_identifier_names

enum MedicineType {
  Tablet,
  Injection,
  Syrup,
  BabyProduct,
  SurgeryItem,
}
class MedicineModel {
  String medicineId;
  String name;
  String company;
  DateTime expiryDate;
  double price;
  String dosage;
  String description;
  String activeIngredient;
  String usageInstructions;
  String storageConditions;
  bool requiresPrescription;
  List<String> sideEffects;
  String chemicalName;
  MedicineType type;
  String image;
  int selectedQuantity; // Added customerReviews property
  List<CustomerReview> customerReviews;
  int totalReviews;
  double discount;
  CategoryModel category;
  List<String> images; // Added list of images
  MedicineModel({
    required this.medicineId,
    required this.name,
    required this.company,
    required this.expiryDate,
    required this.price,
    required this.dosage,
    required this.description,
    required this.activeIngredient,
    required this.usageInstructions,
    required this.storageConditions,
    required this.requiresPrescription,
    required this.sideEffects,
    required this.chemicalName,
    required this.type,
    required this.image,
    this.selectedQuantity = 1,
    this.customerReviews = const [], // Initialize with an empty list
    this.totalReviews = 0, // Initialize with 0
    this.discount = 0.0,
    required this.category,
    required this.images, // Initialize with 0.0 // Default selected quantity to 1
  });
  MedicineModel copyWith({
    String? medicineId,
    String? name,
    String? company,
    DateTime? expiryDate,
    double? price,
    String? dosage,
    String? description,
    String? activeIngredient,
    String? usageInstructions,
    String? storageConditions,
    bool? requiresPrescription,
    List<String>? sideEffects,
    String? chemicalName,
    MedicineType? type,
    String? image,
    int? selectedQuantity,
    List<CustomerReview>? customerReviews,
    int? totalReviews,
    double? discount,
    CategoryModel? category,
    List<String>? images,
  }) {
    return MedicineModel(
        medicineId: medicineId ?? this.medicineId,
        name: name ?? this.name,
        company: company ?? this.company,
        expiryDate: expiryDate ?? this.expiryDate,
        price: price ?? this.price,
        dosage: dosage ?? this.dosage,
        description: description ?? this.description,
        activeIngredient: activeIngredient ?? this.activeIngredient,
        usageInstructions: usageInstructions ?? this.usageInstructions,
        storageConditions: storageConditions ?? this.storageConditions,
        requiresPrescription: requiresPrescription ?? this.requiresPrescription,
        sideEffects: sideEffects ?? List.from(this.sideEffects),
        chemicalName: chemicalName ?? this.chemicalName,
        type: type ?? this.type,
        image: image ?? this.image,
        selectedQuantity: selectedQuantity ?? this.selectedQuantity,
        customerReviews: customerReviews ?? List.from(this.customerReviews),
        totalReviews: totalReviews ?? this.totalReviews,
        discount: discount ?? this.discount,
        category: category ?? this.category,
        images: images ?? this.images);
  }
  // Create Medicine object from a map
  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      medicineId: map['medicineId'],
      name: map['name'],
      company: map['company'],
      expiryDate: DateTime.parse(map['expiryDate']),
      price: map['price'].toDouble(),
      dosage: map['dosage'],
      description: map['description'],
      activeIngredient: map['activeIngredient'],
      usageInstructions: map['usageInstructions'],
      storageConditions: map['storageConditions'],
      requiresPrescription: map['requiresPrescription'],
      sideEffects: List<String>.from(map['sideEffects']),
      chemicalName: map['chemicalName'],
      type: MedicineType.values[map['type']],
      image: map['image'],
      selectedQuantity: map['selectedQuantity'] ?? 1,
      category: CategoryModel.fromMap(map['category']),
      images: map['images'],
    );
  }
  // Convert Medicine object to a map
  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'company': company,
      'expiryDate': expiryDate.toIso8601String(),
      'price': price,
      'dosage': dosage,
      'description': description,
      'activeIngredient': activeIngredient,
      'usageInstructions': usageInstructions,
      'storageConditions': storageConditions,
      'requiresPrescription': requiresPrescription,
      'sideEffects': sideEffects,
      'chemicalName': chemicalName,
      'type': type.index,
      'image': image,
      'selectedQuantity': selectedQuantity
    };
  }
}
class CustomerReview {
  String username;
  String review;
  int rating;
  CustomerReview({
    required this.username,
    required this.review,
    required this.rating,
  });
}
class CategoryModel {
  String categoryId;
  String categoryName;
  String categoryImage; // Added categoryImage property
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });
  // Create Category object from a map
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      categoryImage: map['categoryImage'], // Added mapping for categoryImage
    );
  }
  // Convert Category object to a map
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage, // Added serialization for categoryImage
    };
  }
}