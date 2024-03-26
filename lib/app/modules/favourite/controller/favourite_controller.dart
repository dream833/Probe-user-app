import 'package:get/get.dart';
import 'package:uddipan/models/hospital_model.dart';

class FavouriteController extends GetxController {
  List<Hospital> indianHospitals = [
  Hospital(
    name: 'Apollo Hospital',
    address: '123 Health Lane, Bangalore',
    phoneNumber: '555-5678',
    website: 'www.apollohospital.in',
    bedCount: 300,
    hasEmergencyServices: true,
    imageUrl: 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?q=80&w=1856&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Hospital(
    name: 'Fortis Hospital',
    address: '456 Wellness Street, Mumbai',
    phoneNumber: '555-7890',
    website: 'www.fortishospital.in',
    bedCount: 250,
    hasEmergencyServices: true,
    imageUrl: 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Hospital(
    name: 'Max Healthcare',
    address: '789 Care Avenue, Delhi',
    phoneNumber: '555-1234',
    website: 'www.maxhealthcare.in',
    bedCount: 400,
    hasEmergencyServices: true,
    imageUrl: 'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Hospital(
    name: 'Columbia Asia Hospital',
    address: '101 Healing Street, Pune',
    phoneNumber: '555-2345',
    website: 'www.columbiaasia.in',
    bedCount: 150,
    hasEmergencyServices: false,
    imageUrl: 'https://images.unsplash.com/photo-1517120026326-d87759a7b63b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Hospital(
    name: 'AIIMS New Delhi',
    address: '321 Medical Plaza, New Delhi',
    phoneNumber: '555-3456',
    website: 'www.aiims.edu',
    bedCount: 600,
    hasEmergencyServices: true,
    imageUrl: 'https://images.unsplash.com/photo-1628372095387-017d1099fc19?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Hospital(
    name: 'Narayana Health',
    address: '567 Healing Circle, Bengaluru',
    phoneNumber: '555-4567',
    website: 'www.narayanahealth.org',
    bedCount: 350,
    hasEmergencyServices: true,
    imageUrl: 'https://example.com/narayana_health_image.jpg',
  ),
  Hospital(
    name: 'Kokilaben Dhirubhai Ambani Hospital',
    address: '876 Wellness Boulevard, Mumbai',
    phoneNumber: '555-5678',
    website: 'www.kokilabenhospital.in',
    bedCount: 280,
    hasEmergencyServices: true,
    imageUrl: 'https://example.com/kokilaben_hospital_image.jpg',
  ),
  Hospital(
    name: 'Manipal Hospitals',
    address: '543 Care Road, Bengaluru',
    phoneNumber: '555-6789',
    website: 'www.manipalhospitals.com',
    bedCount: 200,
    hasEmergencyServices: true,
    imageUrl: 'https://example.com/manipal_hospitals_image.jpg',
  ),
  Hospital(
    name: 'Artemis Hospitals',
    address: '432 Health Square, Gurugram',
    phoneNumber: '555-7890',
    website: 'www.artemishospitals.com',
    bedCount: 180,
    hasEmergencyServices: true,
    imageUrl: 'https://example.com/artemis_hospitals_image.jpg',
  ),
  Hospital(
    name: 'Ruby Hall Clinic',
    address: '210 Medical Gardens, Pune',
    phoneNumber: '555-8901',
    website: 'www.rubyhall.com',
    bedCount: 220,
    hasEmergencyServices: true,
    imageUrl: 'https://example.com/ruby_hall_clinic_image.jpg',
  ),
];

}
