import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/doctor/view/book_appointment_view.dart';
import 'package:uddipan/app/modules/doctor/view/widgets/about_section.dart';
import 'package:uddipan/app/modules/doctor/view/widgets/review_section.dart';
import 'package:uddipan/app/modules/doctor/view/widgets/slot_section.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/utils/custom_message.dart';

import '../../../../constants/image_contant.dart';
import '../../../widget/Text/small_text.dart';

class DoctorDetailView extends StatefulWidget {
  final DoctorModel? doctorModel;
  const DoctorDetailView({super.key, this.doctorModel});

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView> {
  late DoctorController controller;
  @override
  void initState() {
    controller = Get.put(DoctorController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              centerTitle: true,
              title: SmallText(
                  text: 'Doctor Detail',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.grey.shade700),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: blackColor,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 70, right: 20),
                    child: SizedBox(
                      height: 100,
                      // color: redColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DisplayImageWidget(
                              color: Colors.white,
                              height: 70,
                              width: 70,
                              child: Image.asset(AppImage.doctorImg2)),
                          const SizedBox(width: 15),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text:
                                      '${widget.doctorModel?.firstName} ${widget.doctorModel?.lastName}',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.grey.shade700,
                                ),
                                const SizedBox(height: 5),
                                SmallText(
                                  text: widget.doctorModel?.specialist ??
                                      "General",
                                  fontSize: 12,
                                  textColor: Colors.grey.shade700,
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // GetBuilder<DoctorController>(builder: (controller) {
                          //   return GestureDetector(
                          //     onTap: () {
                          //       if (controller.favouriteDoctors
                          //           .contains(doctorModel)) {
                          //         controller.removeFavoriteDoctor(
                          //             doctor: doctorModel, context: context);
                          //       } else {
                          //         controller.saveFavoriteDoctor(
                          //             doctor: doctorModel, context: context);
                          //       }
                          //     },
                          //     child: Container(
                          //       height: 40,
                          //       width: 40,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(12),
                          //         color: appColorPrimary,
                          //       ),
                          //       child: Obx(() => Icon(
                          //         controller.favouriteDoctors
                          //                 .contains(doctorModel)
                          //             ? Icons.favorite
                          //             : Icons.favorite_outline,
                          //         color: Colors.white,
                          //       )),
                          //     ),
                          //   );
                          // })
                          Obx(() => GestureDetector(
                                onTap: () {
                                  if (controller.favouriteDoctors.any((p0) =>
                                      p0?.id == widget.doctorModel?.id)) {
                                    controller.removeFavoriteDoctor(
                                        doctor: widget.doctorModel,
                                        context: context);
                                  } else {
                                    controller.saveFavoriteDoctor(
                                        doctor: widget.doctorModel,
                                        context: context);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: appColorPrimary,
                                  ),
                                  child: Icon(
                                    controller.favouriteDoctors.any((p0) =>
                                            p0?.id == widget.doctorModel?.id)
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white38,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   height: 30,
                          //   width: 1.5,
                          //   color: Colors.black,
                          // ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SmallText(
                          //       text: 'Rating',
                          //       fontSize: 12,
                          //       textColor: Colors.grey.shade700,
                          //     ),
                          //     const SizedBox(height: 5),
                          //     FutureBuilder<Map<String, dynamic>?>(
                          //         future: controller.getDoctorAverageRating(
                          //             doctorId: widget.doctorModel!.id!),
                          //         builder: (context, snapshot) {
                          //           if (snapshot.connectionState ==
                          //               ConnectionState.waiting) {
                          //             return horizantalShimmerLine(
                          //                 height: 10, width: 30);
                          //           }
                          //           return Row(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             children: [
                          //               const Icon(Icons.star,
                          //                   color: Colors.amber, size: 19),
                          //               SmallText(
                          //                 text:
                          //                     '${snapshot.data?['averageRating'].toString() ?? ''} (${snapshot.data?['totalReviews']})',
                          //                 fontSize: 12,
                          //                 textColor: Colors.grey.shade700,
                          //               ),
                          //             ],
                          //           );
                          //         }),
                          //   ],
                          // ),
                          // Container(
                          //   height: 30,
                          //   width: 1.5,
                          //   color: Colors.black,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: "Registration No.",
                                  fontSize: 15,
                                  textColor: Colors.grey.shade700),
                              const SizedBox(height: 5),
                              SmallText(
                                text: widget.doctorModel?.registrationNo ??
                                    "------",
                                fontSize: 15,
                                textColor: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.0),
                                border: const Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFD9D9D9), width: 1)),
                              ),
                              child: TabBar(
                                padding: EdgeInsets.zero,

                                indicator: const MyTabIndicator(
                                    indicatorWidth: 1.5, leftPadding: 9),
                                unselectedLabelColor: blackColor,
                                labelColor: appPrimaryColor,
                                indicatorColor: Theme.of(context).primaryColor,
                                // indicatorSize: TabBarIndicatorSize.label,
                                tabs: const [
                                  Tab(text: 'Slots'),
                                  Tab(text: 'About Me'),
                                  Tab(text: 'Review'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SlotSection(
                                      doctorId:
                                          widget.doctorModel!.id.toString()),
                                  AboutSection(
                                      doctorModel: widget.doctorModel!),
                                  ReviewSection(
                                      doctorModel: widget.doctorModel),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () {
            var data = Get.find<DoctorController>().availabilityList;

            if (data.isEmpty) {
              return SizedBox(
                child: Container(
                  alignment: Alignment.center,
                  height: 280.h,
                  child: const Text(
                    " No Today's Slot Found ",
                  ),
                ),
              );
            } else {
              return LoaderButton(
                btnText: 'Book Appointment',
                radius: 0,
                onTap: () async {
                  final doctorController = Get.put(DoctorController());

                  try {
                    if (doctorController.selectedAvailability.value != null) {
                      Get.to(() => const BookAppointmentView());
                    } else {
                      CustomMessage.showSnackBar('Please select slot',
                          backgroundColor: Colors.red);
                    }
                  } catch (e) {
                    CustomMessage.showSnackBar(e.toString(),
                        backgroundColor: Colors.red);
                  }
                },
              );
            }
          },
        ));
  }
}

class MyTabIndicator extends Decoration {
  final double indicatorWidth;
  final double leftPadding;

  const MyTabIndicator({
    this.indicatorWidth = 100.0, // Default width
    this.leftPadding = 20.0, // Default padding
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MyTabIndicatorPainter(this, onChanged);
  }
}

class _MyTabIndicatorPainter extends BoxPainter {
  final MyTabIndicator decoration;

  _MyTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = appPrimaryColor;

    // Access the indicator width and left padding from the decoration
    const double indicatorHeight = 4.0;
    final double indicatorWidth = rect.width / decoration.indicatorWidth;
    final double leftPadding = decoration.leftPadding;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromPoints(
          Offset(rect.left + leftPadding, rect.bottom - indicatorHeight),
          Offset(rect.left + leftPadding + indicatorWidth, rect.bottom),
        ),
        topRight: const Radius.circular(5.0),
        topLeft: const Radius.circular(5.0),
      ),
      paint,
    );
  }
}
