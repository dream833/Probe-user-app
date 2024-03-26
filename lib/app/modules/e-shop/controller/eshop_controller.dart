import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/lab_test_model.dart';
import 'package:uddipan/models/medicine_model.dart';
import 'package:uddipan/utils/custom_message.dart';

class EShopController extends GetxController {
  RxDouble totalAmount = 0.0.obs;
  RxInt totalCount = 0.obs;

  RxList<MedicineModel?> medicineList = <MedicineModel?>[].obs;
  RxMap<String, RxList<MedicineModel>> products =
      <String, RxList<MedicineModel>>{}.obs;

  RxList<LabTestModel?> cartLabTest = <LabTestModel?>[].obs;
  RxList<LabTestModel?> bookTestLab = <LabTestModel?>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllMedicineList();
  }

  void bookedLabTest() {
    LabTestModel model = LabTestModel(
      testName: 'CBC (Complete Blood Count)',
      testType: 'Blood Test',
      testCost: 120.0,
      discount: 15.0,
      rating: 4.8,
      isHomeCollection: true,
      additionalDetails:
          'Fasting is not required. Drink water before the test.',
    );
    bookTestLab.add(model);
  }

  Future<void> addLabTestToCart(LabTestModel model) async {
    if (cartLabTest.contains(model)) {
      CustomMessage.showSnackBar('LabTest is already added',
          backgroundColor: Colors.red);
    } else {
      totalAmount.value += model.testCost;
      cartLabTest.add(model);

      CustomMessage.showSuccessSnackBar('LabTest is added',
          backgroundColor: appPrimaryColor);
      update();
    }
  }

  List<IconData> iconList = [
    FontAwesomeIcons.kitMedical,
    FontAwesomeIcons.syringe,
    FontAwesomeIcons.bottleWater,
    FontAwesomeIcons.baby,
    FontAwesomeIcons.handHoldingMedical,
    FontAwesomeIcons.teethOpen,
  ];

  List<String> imgList = [
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1515350540008-a3f566782a3e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  void cartCount() {
    // Assuming products is a Map<String, dynamic>
    products.refresh();
    products.forEach((key, value) {
      totalCount += key.length;
    });

    totalCount += cartLabTest.length;
    update();
  }

  void removeProduct(MedicineModel product) {
    totalAmount.value -= product.price *
        products[product.medicineId]![
                products[product.medicineId]!.indexOf(product)]
            .selectedQuantity;
    products[product.medicineId]?.remove(product);
    if (products[product.medicineId]?.isEmpty ?? false) {
      products.remove(product.medicineId);
    }
    products.refresh();
  }

  bool addProduct(MedicineModel product) {
    if (products.containsKey(product.medicineId)) {
      if (products[product.medicineId]!.contains(product)) {
        CustomMessage.showSuccessSnackBar(
            'Product is already added to the cart',
            backgroundColor: Colors.red,
            title: 'Cart ');

        return false;
      } else {
        if (product.selectedQuantity >= 1) {
          products[product.medicineId]!.add(product);
          totalAmount.value += product.price * product.selectedQuantity;

          CustomMessage.showSnackBar('Product is Added To the Cart',
              backgroundColor: appColorPrimary, title: 'Cart');
          return true;
        } else {
          return false;
        }
      }
    } else {
      if (product.selectedQuantity >= 1) {
        products.addAll({
          product.medicineId: <MedicineModel>[product].obs
        });
        totalAmount.value += product.price * product.selectedQuantity;
        CustomMessage.showSnackBar('Product is Added To the Cart',
            backgroundColor: appColorPrimary, title: 'Cart');

        return true;
      } else {
        return false;
      }
    }
  }

  // Method to show a SnackBar
  void showSnackBar(String message) {
    Get.snackbar('Cart Message', message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey);
  }

  void increaseQuantity(MedicineModel product) {
    products[product.medicineId]![
            products[product.medicineId]!.indexOf(product)]
        .selectedQuantity += 1;
    totalAmount.value += product.price;
    products.refresh();
  }

  void decreaseQuantity(MedicineModel product) {
    int index = products[product.medicineId]!.indexOf(product);
    int newQuantity = products[product.medicineId]![index].selectedQuantity - 1;

    if (newQuantity <= 0) {
      removeProduct(product);
    } else {
      products[product.medicineId]![index].selectedQuantity = newQuantity;
      totalAmount.value -= product.price;
    }
    products.refresh();
  }

  List<String> categoriesInfo = [
    'Commonly used for minor injuries and emergencies.', // First Aid
    'Administered by healthcare professionals.', // Injections
    'Liquid medications for cough and cold symptoms.', // Syrups
    'Products specially formulated for infants and toddlers.', // Baby Care
    'Medical supplies for surgical procedures.', // Surgery
    'Products recommended by dentists for oral hygiene.', // Dental Care
    'Products for skincare routines and minor dermatological issues.', // Skin Care
    'Hair care products for general use.', // Hair Care
  ];

  List<CategoryModel> categories = [
    CategoryModel(
      categoryId: '1',
      categoryName: 'First Aid',
      categoryImage: 'https://example.com/category_images/pain_relievers.jpg',
    ),
    CategoryModel(
      categoryId: '2',
      categoryName: 'Injections',
      categoryImage: 'https://example.com/category_images/injections.jpg',
    ),
    CategoryModel(
      categoryId: '3',
      categoryName: 'Syrups',
      categoryImage: 'https://example.com/category_images/cough_and_cold.jpg',
    ),
    CategoryModel(
      categoryId: '4',
      categoryName: 'Baby Care',
      categoryImage: 'https://example.com/category_images/baby_care.jpg',
    ),
    CategoryModel(
      categoryId: '5',
      categoryName: 'Surgery',
      categoryImage: 'https://example.com/category_images/medical_supplies.jpg',
    ),
    CategoryModel(
      categoryId: '6',
      categoryName: 'Dental Care',
      categoryImage: 'https://example.com/category_images/dental_care.jpg',
    ),
    CategoryModel(
      categoryId: '8',
      categoryName: 'Skin Care',
      categoryImage: 'https://example.com/category_images/skin_care.jpg',
    ),
    CategoryModel(
      categoryId: '9',
      categoryName: 'Hair Care',
      categoryImage: 'https://example.com/category_images/hair_care.jpg',
    ),
  ];

  List<LabTestModel> labTests = [
    LabTestModel(
      testName: 'CBC (Complete Blood Count)',
      testType: 'Blood Test',
      testCost: 120.0,
      discount: 15.0,
      rating: 4.8,
      additionalDetails:
          'Fasting is not required. Drink water before the test.',
      isHomeCollection: false,
    ),
    LabTestModel(
      testName: 'Lipid Profile',
      testType: 'Blood Test',
      testCost: 180.0,
      discount: 10.0,
      rating: 4.5,
      additionalDetails: 'Fasting for 10-12 hours is required before the test.',
      isHomeCollection: true,
    ),
    LabTestModel(
      testName: 'Thyroid Function Test',
      testType: 'Blood Test',
      testCost: 90.0,
      discount: 20.0,
      rating: 4.2,
      additionalDetails: 'Fasting is not required. Take medications as usual.',
      isHomeCollection: true,
    ),
    LabTestModel(
      testName: 'HbA1c (Glycated Hemoglobin)',
      testType: 'Blood Test',
      testCost: 75.0,
      discount: 5.0,
      rating: 4.9,
      additionalDetails:
          'Fasting is not required. Regular diet before the test.',
      isHomeCollection: false,
    ),
    LabTestModel(
      testName: 'Liver Function Test',
      testType: 'Blood Test',
      testCost: 150.0,
      discount: 10.0,
      rating: 4.7,
      additionalDetails:
          'Fasting is not required. Avoid alcohol 24 hours before the test.',
      isHomeCollection: true,
    ),
    LabTestModel(
      testName: 'Kidney Function Test',
      testType: 'Blood Test',
      testCost: 110.0,
      discount: 8.0,
      rating: 4.4,
      additionalDetails:
          'Fasting is not required. Drink water before the test.',
      isHomeCollection: false,
    ),
    LabTestModel(
      testName: 'Dengue NS1 Antigen Test',
      testType: 'Blood Test',
      testCost: 100.0,
      discount: 12.0,
      rating: 4.6,
      additionalDetails: 'Fasting is not required. No specific instructions.',
      isHomeCollection: true,
    ),
    LabTestModel(
      testName: 'Cholesterol Test',
      testType: 'Blood Test',
      testCost: 80.0,
      discount: 5.0,
      rating: 4.3,
      additionalDetails: 'Fasting for 10-12 hours is required before the test.',
      isHomeCollection: false,
    ),
    LabTestModel(
      testName: 'Urine Routine Examination',
      testType: 'Urine Test',
      testCost: 50.0,
      discount: 3.0,
      rating: 4.0,
      additionalDetails: 'Collect the first morning urine sample for the test.',
      isHomeCollection: true,
    ),
    LabTestModel(
      testName: 'Pregnancy Test',
      testType: 'Urine Test',
      testCost: 30.0,
      discount: 2.0,
      rating: 4.1,
      additionalDetails: 'Use the first-morning urine for accurate results.',
      isHomeCollection: false,
    ),
  ];

  List<MedicineModel> medicines = [
    MedicineModel(
      medicineId: '1',
      name: 'Panadol',
      company: 'GlaxoSmithKline',
      expiryDate: DateTime(2023, 12, 31),
      price: 5.99,
      dosage: '500mg',
      description:
          'Panadol is a common over-the-counter pain reliever and fever reducer.',
      activeIngredient: 'Paracetamol',
      usageInstructions:
          'Take 1-2 tablets every 4-6 hours as needed for pain or fever relief.',
      storageConditions: 'Store in a cool, dry place.',
      requiresPrescription: false,
      sideEffects: ['Nausea', 'Headache', 'Allergic reactions'],
      chemicalName: 'Acetaminophen',
      type: MedicineType.Tablet,
      image:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      selectedQuantity: 1,
      customerReviews: [],
      totalReviews: 0,
      discount: 0.0,
      category: CategoryModel(
        categoryId: '1',
        categoryName: 'Pain Relievers',
        categoryImage: 'https://example.com/category_images/pain_relievers.jpg',
      ),
      images: [
        'https://example.com/images/panadol_image1.jpg',
        'https://example.com/images/panadol_image2.jpg',
        'https://example.com/images/panadol_image3.jpg',
      ],
    ),
    MedicineModel(
      medicineId: '2',
      name: 'Amoxicillin',
      company: 'Generic Pharma',
      expiryDate: DateTime(2024, 8, 15),
      price: 12.99,
      dosage: '500mg',
      description: 'Used to treat bacterial infections.',
      activeIngredient: 'Amoxicillin',
      usageInstructions:
          'Administer as per healthcare professional\'s instructions.',
      storageConditions: 'Store in a refrigerator.',
      requiresPrescription: true,
      sideEffects: ['Redness at injection site', 'Fever', 'Allergic reactions'],
      chemicalName: 'Amoxicillin',
      type: MedicineType.Injection,
      image:
          'https://virinchihospitals.com/wp-content/uploads/2018/12/Compressed_Internal-medicine.jpg',
      selectedQuantity: 1,
      customerReviews: [],
      totalReviews: 0,
      discount: 0.0,
      category: CategoryModel(
        categoryId: '2',
        categoryName: 'Injections',
        categoryImage: 'https://example.com/category_images/injections.jpg',
      ),
      images: [
        'https://example.com/images/amoxicillin_injection_image1.jpg',
        'https://example.com/images/amoxicillin_injection_image2.jpg',
      ],
    ),
    MedicineModel(
      medicineId: '3',
      name: 'Cough Syrup',
      company: 'Health Solutions',
      expiryDate: DateTime(2023, 10, 1),
      price: 8.49,
      dosage: '10ml',
      description: 'Relieves cough and soothes throat irritation.',
      activeIngredient: 'Dextromethorphan',
      usageInstructions: 'Take 10ml every 4-6 hours as needed.',
      storageConditions: 'Store at room temperature.',
      requiresPrescription: false,
      sideEffects: ['Drowsiness', 'Dizziness', 'Dry mouth'],
      chemicalName: 'Dextromethorphan Syrup',
      type: MedicineType.Syrup,
      image:
          'https://www.swlondoner.co.uk/wp-content/uploads/2021/08/poisoning-pill-bottle.jpeg',
      selectedQuantity: 1,
      customerReviews: [],
      totalReviews: 0,
      discount: 0.0,
      category: CategoryModel(
        categoryId: '3',
        categoryName: 'Cough and Cold',
        categoryImage: 'https://example.com/category_images/cough_and_cold.jpg',
      ),
      images: [
        'https://example.com/images/cough_syrup_image1.jpg',
        'https://example.com/images/cough_syrup_image2.jpg',
        'https://example.com/images/cough_syrup_image3.jpg',
      ],
    ),
    MedicineModel(
      medicineId: '4',
      name: 'Baby Diapers',
      company: 'Happy Babies Inc.',
      expiryDate: DateTime(2025, 5, 15),
      price: 25.99,
      dosage: 'N/A',
      description: 'Soft and comfortable diapers for babies.',
      activeIngredient: 'N/A',
      usageInstructions: 'Use as needed for baby hygiene.',
      storageConditions: 'Store in a dry place.',
      requiresPrescription: false,
      sideEffects: [],
      chemicalName: 'Baby Diapers',
      type: MedicineType.BabyProduct,
      image:
          'https://retailpharmacymagazine.com.au/wp-content/uploads/2020/05/dexamethasone-retail-pharmacy.jpg',
      selectedQuantity: 1,
      customerReviews: [],
      totalReviews: 0,
      discount: 0.0,
      category: CategoryModel(
        categoryId: '4',
        categoryName: 'Baby Care',
        categoryImage: 'https://example.com/category_images/baby_care.jpg',
      ),
      images: [
        'https://example.com/images/baby_diapers_image1.jpg',
        'https://example.com/images/baby_diapers_image2.jpg',
      ],
    ),
    MedicineModel(
      medicineId: '5',
      name: 'Surgical Gloves',
      company: 'MediCare Supplies',
      expiryDate: DateTime(2024, 6, 30),
      price: 18.75,
      dosage: 'N/A',
      description: 'Disposable surgical gloves for medical procedures.',
      activeIngredient: 'N/A',
      usageInstructions: 'Use as needed for medical procedures.',
      storageConditions: 'Store in a clean and dry place.',
      requiresPrescription: false,
      sideEffects: [],
      chemicalName: 'Latex Surgical Gloves',
      type: MedicineType.SurgeryItem,
      image:
          'https://www.beuc.eu/sites/default/files/shutterstock_medicine_tablets.jpg',
      selectedQuantity: 1,
      customerReviews: [],
      totalReviews: 0,
      discount: 0.0,
      category: CategoryModel(
        categoryId: '5',
        categoryName: 'Medical Supplies',
        categoryImage:
            'https://example.com/category_images/medical_supplies.jpg',
      ),
      images: [
        'https://example.com/images/surgical_gloves_image1.jpg',
        'https://example.com/images/surgical_gloves_image2.jpg',
      ],
    ),
  ];

  void getAllMedicineList() {
    log('getAllMedicineList');
    medicineList.addAll(medicines);
    log('Medicine List Length ${medicineList.length}');
  }
}
