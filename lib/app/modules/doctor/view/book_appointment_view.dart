import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/profile/controllers/member_controller.dart';
import 'package:uddipan/app/modules/report/controller/report_controller.dart';
import 'package:uddipan/app/modules/report/view/add_report_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/load_pdf.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/app/widget/search_dropdown.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/appointment_model.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/models/user_report_model.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../appointments/controller/appointment_controller.dart';

class BookAppointmentView extends StatefulWidget {
  final doctorId;
  final AppoinmentModel? model;
  const BookAppointmentView({super.key, required this.doctorId, this.model});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  late AppointmentController appointmentController;
  late MemberController memberController;
  late ReportController reportController;
  @override
  void initState() {
    appointmentController = Get.put(AppointmentController());
    memberController = Get.put(MemberController());
    reportController = Get.put(ReportController());
    appointmentController.setSelectedPatient(0);
    memberController.getUserFamilyMember();
    reportController.getAllUserReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: SmallText(
            text: 'Book Apointment',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                    text: 'Select Patient', textColor: Colors.grey.shade700),

                Row(
                  children: appointmentController.patientItems
                      .asMap()
                      .entries
                      .map((entry) =>
                          buildPatientRadioType(entry.key, entry.value))
                      .toList(),
                ),
                SizedBox(height: 10.h),
                GetBuilder<AppointmentController>(builder: (controller) {
                  if (controller.patientType.value == 1) {
                    return Obx(
                      () {
                        if (memberController.isFamilyMemberLoading.value ==
                            true) {
                          return const Center(child: Text('Loading'));
                        }

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(-1, 1),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: SearchDropDown(
                                hintText: 'Select Member',
                                items: memberController.memberList.isEmpty
                                    ? ['No Member Found']
                                    : memberController.memberList
                                        .map((item) => item!.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedMember.value = newValue!;
                                  MemberModel? memberModel = memberController
                                      .memberList
                                      .where((e) => e?.name == newValue)
                                      .first;
                                  appointmentController
                                      .updateSelectedMember(memberModel!);
                                },
                                value: appointmentController
                                        .selectedMember.value.isNotEmpty
                                    ? appointmentController.selectedMember.value
                                    : null,
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                SmallText(
                    text: 'Patient Name', textColor: Colors.grey.shade700),
                SizedBox(height: 15.h),
                StatefulBuilder(builder: (context, _) {
                  return CustomTextField(
                    hintText: 'Name',
                    controller: appointmentController.patientController,
                    prefixIcon: Icons.person,
                    prefixIconSize: 20,
                  );
                }),
                // SizedBox(height: 15.h),
                // SmallText(text: 'Clinic', textColor: Colors.grey.shade700),
                // SizedBox(height: 15.h),
                // CustomTextField(
                //     hintText: 'Clinic',
                //     controller: appointmentController.clinicController,
                //     prefixIcon: Icons.local_hospital,
                //     prefixIconSize: 20),
                // SizedBox(height: 15.h),
                // SmallText(
                //     text: 'Clinic Address', textColor: Colors.grey.shade700),
                // SizedBox(height: 15.h),
                // CustomTextField(
                //     hintText: 'Address',
                //     controller: appointmentController.clinicAddressController,
                //     prefixIcon: Icons.location_on,
                //     prefixIconSize: 20),
                SizedBox(height: 15.h),
                SmallText(text: 'Age', textColor: Colors.grey.shade700),
                SizedBox(height: 15.h),
                CustomTextField(
                    hintText: 'Age',
                    inputType: TextInputType.number,
                    controller: appointmentController.ageController,
                    prefixIcon: FontAwesomeIcons.child,
                    prefixIconSize: 20),
                SizedBox(height: 15.h),
                SmallText(text: 'Phone', textColor: Colors.grey.shade700),
                SizedBox(height: 15.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(-1, 1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: IntlPhoneField(
                    languageCode: "en",
                    autofocus: false,
                    initialCountryCode: 'IN',
                    disableLengthCheck: true,
                    controller: appointmentController.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      contentPadding: const EdgeInsets.only(bottom: 5, top: 10),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 14, color: greyColor),
                      border: InputBorder.none,
                    ),
                    onChanged: (phone) {},
                    onCountryChanged: (country) {
                      log('country code + ${country.code} + country dial ${country.dialCode}');
                      appointmentController.selectedCountryCode.value =
                          country.code;
                      appointmentController.selectedDigitalCode.value =
                          country.dialCode;
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                SmallText(
                    text: 'Select Gender', textColor: Colors.grey.shade700),
                Row(
                  children: appointmentController.genderItems
                      .asMap()
                      .entries
                      .map((entry) =>
                          buildGenderRadioType(entry.key, entry.value))
                      .toList(),
                ),

                Row(
                  children: <Widget>[
                    Obx(
                      () => Checkbox(
                        value: appointmentController.hasLabReport.value,
                        onChanged: (bool? value) {
                          appointmentController.updateSelectedReport(value!);
                        },
                      ),
                    ),
                    SmallText(
                        text: 'Any Lab Report',
                        textColor: Colors.grey.shade700),
                    // Obx(
                    //   () => Checkbox(
                    //     value: appointmentController.hasPrescription.value,
                    //     onChanged: (bool? value) {
                    //       appointmentController
                    //           .updateSelectedPrescription(value!);
                    //     },
                    //   ),
                    // ),
                    // SmallText(
                    //     text: 'Any Prescription',
                    //     textColor: Colors.grey.shade700),
                  ],
                ),
                const SizedBox(height: 4),
                GetBuilder<AppointmentController>(builder: (controller) {
                  return Obx(() {
                    if (appointmentController.hasLabReport.value == true) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                              text: 'Select Lab Report',
                              textColor: Colors.grey.shade700),
                          Obx(() {
                            if (reportController.isReportListLoading.value ==
                                true) {
                              return shimmerListEffect();
                            }
                            if (reportController.reportList.isEmpty) {
                              return Column(
                                children: [
                                  const SizedBox(height: 10),
                                  LoaderButton(
                                      color: Colors.red,
                                      btnText: 'Add Report',
                                      onTap: () async {
                                        Get.to(() => const AddReportView());
                                      }),
                                ],
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: reportController.reportList.length,
                              itemBuilder: (context, index) {
                                UserReportModel? report =
                                    reportController.reportList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => PDFViewerFromUrl(
                                          url: report!.file,
                                        ));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: boxShadow,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              const DisplayImageWidget(
                                                color: Colors.red,
                                                height: 60,
                                                width: 60,
                                                child: Icon(
                                                  FontAwesomeIcons.filePdf,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      report?.name ?? '',
                                                      style: CustomFont
                                                          .regularTextPoppins,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      report?.date ?? '',
                                                      style: CustomFont
                                                          .regularTextPoppins
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    if (report != null) {
                                                      appointmentController
                                                          .updateSelectedReportFile(
                                                              report);
                                                    }
                                                  },
                                                  child: appointmentController
                                                          .selectedReportFile
                                                          .any((p0) =>
                                                              p0?.id ==
                                                              report?.id)
                                                      ? const Icon(
                                                          Icons.check_circle,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(
                                                          Icons.circle_outlined,
                                                          color: Colors.red),
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  });
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const SmallText(fontSize: 15, text: "Total Price"),
              //     const SizedBox(height: 1),
              //     SmallText(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         text: widget.model!.payment.toString()),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: LoaderButton(
                        radius: 6,
                        color: appColorPrimary,
                        btnText: "Book",
                        onTap: () async {
                          try {
                            final doctorController =
                                Get.put(DoctorController());
                            final patientId = getbox.read(userId).toString();
                            log('PatientId $patientId');
                            await appointmentController.addAppointment(
                                context: context,
                                doctorId: doctorController
                                    .selectedAvailability.value!.doctorId
                                    .toString(),
                                availabilityModel: doctorController
                                    .selectedAvailability.value!,
                                patientId: patientId);
                          } catch (e) {
                            return;
                          }
                        })),
              )
            ],
          )),
    );
  }

  Widget buildGenderRadioType(int index, String item) {
    final controller = Get.put(AppointmentController());
    return Row(
      children: [
        Obx(
          () => Radio(
            value: index,
            activeColor: const Color(0xff06B198),
            groupValue: controller.genderType.value,
            onChanged: (value) {
              controller.setSelectedGender(value!);
            },
          ),
        ),
        Text(item),
      ],
    );
  }

  Widget buildPatientRadioType(int index, String item) {
    final controller = Get.put(AppointmentController());
    return Row(
      children: [
        Obx(
          () => Radio(
            value: index,
            activeColor: const Color(0xff06B198),
            groupValue: controller.patientType.value,
            onChanged: (value) {
              controller.setSelectedPatient(value!);
            },
          ),
        ),
        Text(item),
      ],
    );
  }
}
