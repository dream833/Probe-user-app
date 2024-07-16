import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/profile/controllers/member_controller.dart';
import 'package:uddipan/app/modules/profile/view/add_member_view.dart';

import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/utils/snippet.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
    controller.getUserFamilyMember();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Members ',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            Obx(() {
              if (controller.isFamilyMemberLoading.value == true) {
                return shimmerListEffect();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: controller.memberList.length,
                itemBuilder: (context, index) {
                  MemberModel? member = controller.memberList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: boxShadow,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(
                            children: [
                              DisplayImageWidget(
                                color: member?.gender == 'Male'
                                    ? appColorBlue
                                    : appColorPrimary,
                                height: 60,
                                width: 60,
                                child: Icon(
                                  member?.gender == 'Male'
                                      ? Icons.person
                                      : FontAwesomeIcons.personDress,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member?.name ?? '',
                                    style: CustomFont.regularTextPoppins,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    member?.relationship ?? '',
                                    style: CustomFont.regularTextPoppins
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          )
                        ]),
                      ),
                    ),
                  );
                },
              );
            }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Get.to(() => const AddMemberView());
        },
        backgroundColor: appColorBlue,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
      ),
    );
  }
}
