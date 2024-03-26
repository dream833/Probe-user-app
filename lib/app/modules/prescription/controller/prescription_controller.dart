import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/models/prescription_model.dart';

class PrescriptionController extends GetxController {
  final isLoading = false.obs;
  final controller = TextEditingController();
  final RxInt selectedTabIndex = 1.obs;
  changeTab(int index) {
    selectedTabIndex.value = index;
  }

  final List<String> listOfPrescriptionType = [
    'Previous Prescription',
    'Write new Prescription',
  ];
  final List<String> prescriptionItemList = [
    'Vital Update',
    'Case History',
    'Diagnosis',
    'Lab Test',
    'Medicine',
    'Follow Up Date',
    'Referral',
  ];
  var selectedIndexOfPrescription = 0.obs;
  var selectedPrescriptionItemName = "".obs;
  var selectedIndex = 0.obs;
  var selectedItemName = "".obs;
  void setSelectedIndexForPrescription(int index) {
    selectedIndexOfPrescription.value = index;
    selectedPrescriptionItemName.value = prescriptionItemList[index];
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedItemName.value = listOfPrescriptionType[index];
  }

  RxList<RxBool> isExpandList = <RxBool>[].obs;
  void toggleExpansion(int index) {
    closePreviouslyExpandedItems(index);
    if (index >= isExpandList.length) {
      isExpandList.addAll(
          List.generate(index - isExpandList.length + 1, (index) => false.obs));
    }
    isExpandList[index].value = !isExpandList[index].value;
    update();
  }

  void closePreviouslyExpandedItems(int currentIndex) {
    for (int i = 0; i < isExpandList.length; i++) {
      if (i != currentIndex && isExpandList[i].value == true) {
        isExpandList[i].value = false;
      }
    }
  }

  List<Medicine> medicineList = [
    Medicine(
      description: 'Pain reliever for headaches and mild pain',
      name: 'Acetaminophen',
      time: '8:00 AM',
      quantity: 1,
      duration: '7 days',
    ),
    Medicine(
      description: 'Antibiotic for bacterial infections',
      name: 'Amoxicillin',
      time: '12:00 PM',
      quantity: 1,
      duration: '10 days',
    ),
    Medicine(
      description: 'Anti-inflammatory for arthritis',
      name: 'Ibuprofen',
      time: '3:00 PM',
      quantity: 1,
      duration: '14 days',
    ),
    Medicine(
      description: 'Antihistamine for allergy relief',
      name: 'Cetirizine',
      time: '6:00 PM',
      quantity: 1,
      duration: '30 days',
    ),
    Medicine(
      description: 'Blood pressure medication',
      name: 'Lisinopril',
      time: '9:00 PM',
      quantity: 1,
      duration: '60 days',
    ),
    Medicine(
      description: 'Anti-diabetic medication',
      name: 'Metformin',
      time: '10:30 AM',
      quantity: 1,
      duration: '90 days',
    ),
    Medicine(
      description: 'Thyroid hormone replacement',
      name: 'Levothyroxine',
      time: '7:30 AM',
      quantity: 1,
      duration: '120 days',
    ),
    Medicine(
      description: 'Cough syrup for respiratory issues',
      name: 'Dextromethorphan',
      time: '2:30 PM',
      quantity: 1,
      duration: '5 days',
    ),
    Medicine(
      description: 'Antacid for indigestion',
      name: 'Omeprazole',
      time: '5:30 PM',
      quantity: 1,
      duration: '15 days',
    ),
    Medicine(
      description: 'Anti-anxiety medication',
      name: 'Alprazolam',
      time: '8:30 PM',
      quantity: 1,
      duration: '20 days',
    ),
  ];
  List<PrescriptionModel> prescriptions = [
    PrescriptionModel(
      patientFullName: 'John Doe',
      patientDateOfBirth: '1990-05-15',
      patientGender: 'Male',
      patientContactInformation: '+9103223111',
      doctorName: 'Dr. Smith',
      medicalLicenseNumber: 'MD12345',
      doctorContactInformation: '987-654-3210',
      clinicOrHospitalName: 'ABC Clinic',
      medicines: [
        Medicine(
          description: 'Painkiller',
          name: 'Medicine A',
          time: 'Morning',
          quantity: 2,
          duration: '7 days',
        ),
        Medicine(
          description: 'Antibiotic',
          name: 'Medicine B',
          time: 'Evening',
          quantity: 1,
          duration: '10 days',
        ),
      ],
      diagnosis: 'Common Cold',
      specialInstructions: 'Take plenty of rest.',
      followUpDate: '2024-01-20',
      followUpTime: '10:00 AM',
      emergencyContact: '111-222-3333',
    ),
  ];
}
