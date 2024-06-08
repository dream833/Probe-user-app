import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:uddipan/app/modules/prescription/controller/prescription_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';

class PrescriptionListView extends StatefulWidget {
  final int? index;
  const PrescriptionListView({
    super.key,
    this.index,
  });

  @override
  State<PrescriptionListView> createState() => _PrescriptionListViewState();
}

class _PrescriptionListViewState extends State<PrescriptionListView> {
  List<dynamic> prescriptions = [];
  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    String token = getbox.read(userToken);
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final patientId = getbox.read(userId).toString();
    print('Patient ID: $patientId');
    final url = 'https://api.esplshowcase.in/api/user/prescriptions/$patientId';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        prescriptions = data;
      });
      print("Fetch success $data");
      return data;
    } else {
      print(
          'Error: ${response.statusCode} ${response.reasonPhrase.toString()}');
      throw Exception('Failed to Fetch');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrescriptionController());

    onRefresh() async {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        return const CircularProgressIndicator();
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const SmallText(
              text: 'Prescriptions',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textColor: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              // const SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       child: CustomTextField(
              //           prefixIcon: Icons.search, hintText: 'Search Doctors'),
              //     ),
              //     const SizedBox(width: 10),
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: const BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: boxShadow,
              //           shape: BoxShape.circle),
              //       child: Icon(
              //         Icons.filter_alt_outlined,
              //         color: appPrimaryColor,
              //         size: 25,
              //       ),
              //     )
              //   ],
              // ),
              const SizedBox(height: 20),
              ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemCount: prescriptions.length,
                  itemBuilder: (context, index) {
                    var prescription = prescriptions[index];
                    var medicines = prescription['medicines'];

                    String medicineNames = medicines
                        .map((medicine) => medicine['name'])
                        .join(', ');
                    String duration = medicines
                        .map((medicine) => medicine['duration'])
                        .join(', ');
                    String absorption = medicines
                        .map((medicine) => medicine['absorption'])
                        .join(', ');
                    String dosage = medicines
                        .map((medicine) => medicine['dosage'])
                        .join(', ');
                    String quantity = medicines
                        .map((medicine) => medicine['quantity'])
                        .join(', ');

                    // String medicine_time = medicines.map((medicine) => medicine['duration']).join(', ');

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((context) {
                              return Wrap(children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                        child: Text(
                                      "More Info",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const Center(
                                                      child: Text(
                                                    "Prescribed Medicine",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Medicine",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(medicineNames
                                                        .toString()),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Dosage",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing:
                                                        Text(dosage.toString()),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Duration",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(
                                                        duration.toString()),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Quantity",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(
                                                        quantity.toString()),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Absorption",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(
                                                        absorption.toString()),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            }));
                                      },
                                      leading: const Text("Prescribed medicine",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const Center(
                                                      child: Text(
                                                    "Appointment update",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  // ListTile(
                                                  //   leading: const Text("Doctor Name",style: TextStyle(fontWeight: FontWeight.bold)),
                                                  //   trailing: Text("${prescription['doctor']['first_name']} ${prescription['doctor']['last_name']}"),
                                                  // ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Case History",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(prescription[
                                                        'case_history']),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Vital Update",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(prescription[
                                                        'vital_update']),
                                                  ),
                                                  ListTile(
                                                    leading: const Text(
                                                        "Diagnosis",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    trailing: Text(prescription[
                                                        'diagnosis']),
                                                  ),
                                                  // ListTile(
                                                  //   leading: const Text("Absorption",style: TextStyle(fontWeight: FontWeight.bold)),
                                                  //   trailing: Text(absorption.toString()),
                                                  // ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            }));
                                      },
                                      leading: const Text("Appointment update",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              ]);
                            }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: boxShadow,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  DisplayImageWidget(
                                      color: Colors.white,
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(AppImage.doctorImg2)),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "Dr. ${prescription['doctor']['first_name']} ${prescription['doctor']['last_name']}",
                                          //   style: GoogleFonts.poppins(
                                          //     color: Colors.black,
                                          //     fontSize: 15,
                                          //   ),
                                          // ),
                                          Text(
                                            prescription['diagnosis'] ?? '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            prescription['vital_update'] ?? '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            prescription['case_history'] ?? '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        medicineNames.isNotEmpty
                                            ? medicineNames.toString()
                                            : 'No given medicine',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        duration.isNotEmpty
                                            ? duration.toString()
                                            : 'No Duration',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ]),
          ),
        ));
  }
}
