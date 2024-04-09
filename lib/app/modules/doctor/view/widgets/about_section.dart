import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/models/doctor_model.dart';

class AboutSection extends StatelessWidget {
  final DoctorModel doctorModel;
  const AboutSection({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            // _doctorInfo(
            //   title: 'Specialist',
            //   data: 'Heart, Liver, Kidney.',
            // ),
            _doctorInfo(
              title: 'Experience',
              data: doctorModel.workExperience ?? '---',
            ),
            _doctorInfo(
                title: 'Speciality',
                data: doctorModel.specialist.toString() ?? ''),
            _doctorInfo(
              title: 'Description',
              data: doctorModel.biography ?? '',
            ),
          ].expand((element) => [element, const SizedBox(height: 20)]).toList(),
        ),
      ),
    );
  }

  Column _doctorInfo({required String title, required String data}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SmallText(
              text: title,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textColor: Colors.grey.shade800,
              // textColor: const Color.fromARGB(255, 110, 100, 100),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey),
              )),
        ),
      ],
    );
  }
}
