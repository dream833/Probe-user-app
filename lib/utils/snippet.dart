import 'dart:developer';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

String? Function(String?) get passwordValidator => (String? password) {
      if (password == null || password.isEmpty) {
        return "Password cannot be empty";
      } else if (password.length < 8) {
        return "Password should be at least 8 characters";
      }
      return null; // Indicates password is valid
    };

bool isValidEmail(String email) {
  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email);
}

String? Function(String?) get numberValidator =>
    (String? number) => number?.isEmpty ?? true
        ? "This field is mandatory"
        : RegExp(r"^[0-9]*$").hasMatch(number ?? "")
            ? null
            : "Enter a valid number";

TimeOfDay convertStringToTimeOfDay(String timeString) {
  List<String> timeParts = timeString.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

String formatTime(String time) {
  DateTime parsedTime = DateFormat("HH:mm").parse(time);
  return DateFormat("h:mm a").format(parsedTime);
}

String formatDate(DateTime? date) {
  if (date != null) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    return '$year-$month-$day';
  }
  return '';
}

Widget getLoader() => const Center(child: CircularProgressIndicator());
RoundedRectangleBorder getRoundShape({double? val}) =>
    RoundedRectangleBorder(borderRadius: getRoundBorder(val: val));
BorderRadius getRoundBorder({double? val}) => BorderRadius.circular(val ?? 30);
String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return 'Good morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}

String capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}

final Color baseColor = Colors.grey[300]!;
final Color highlightColor = Colors.grey[100]!;
Widget getShimmer({
  double height = 12,
  double width = 40,
  double itemElevation = 0,
  double itemBorderRadius = 5,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Card(
      elevation: itemElevation,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemBorderRadius),
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    ),
  );
}

Widget shimmerHorizontalList({
  double itemSpacing = 30,
  double itemHeight = 150,
  double itemWidth = 250,
  int itemCount = 10,
  double itemBorderRadius = 5,
}) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    clipBehavior: Clip.hardEdge,
    itemCount: itemCount,
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        width: itemSpacing,
      );
    },
    itemBuilder: (context, index) {
      return getShimmer(
        height: itemHeight,
        width: itemWidth,
        itemBorderRadius: itemBorderRadius,
      );
    },
  );
}

Shimmer shimmerTableEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemHeight = 40,
  int itemCount = 20,
  double itemBorderRadius = 20,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Padding(
      padding: padding,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(itemBorderRadius)),
            ),
            child: SizedBox(height: itemHeight),
          );
        },
      ),
    ),
  );
}

Shimmer shimmerGridEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemAspectRatio = 1,
  int itemCount = 20,
  double itemBorderRadius = 5,
  int crossAxisCount = 2,
  double mainAxisSpacing = 10,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: itemAspectRatio,
            crossAxisSpacing: 4),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(itemBorderRadius),
            ),
            child: const SizedBox(),
          );
        },
      ),
    ),
  );
}

Shimmer shimmerListEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  int itemCount = 20,
  double itemBorderRadius = 5,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Padding(
      padding: padding,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(itemBorderRadius),
              ),
              child: Container(height: 80),
            ),
          );
        },
      ),
    ),
  );
}

Shimmer sliderShimmer() {
  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Stack(
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
          height: 130.h,
          width: double.infinity,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget horizantalShimmerLine({
  required double height,
  required double width,
}) {
  return SizedBox(
    height: height, // Height of the shimmer line
    width: width, // Width of the shimmer line
    child: Shimmer.fromColors(
      baseColor: baseColor, // Base color of the shimmer
      highlightColor: highlightColor, // Highlight color of the shimmer
      child: Container(
        color: Colors.white, // Color of the container behind the shimmer
      ),
    ),
  );
}

Future<void> delayDuration() async {
  await Future.delayed(
      const Duration(seconds: 3)); // Simulate a delay of 2 seconds
}

Map<String, String> getCurrentDateAndDay() {
  DateTime now = DateTime.now();
  String dayOfWeek = getDayOfWeek(now.weekday);
  String formattedDate =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  return {'date': formattedDate, 'day': dayOfWeek};
}

String getDayOfWeek(int day) {
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}

class PickedPDF {
  final File file;
  final String fileName;

  PickedPDF({required this.file, required this.fileName});
}

Future<PickedPDF?> pickPDFFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      String filePath = platformFile.path!;
      String fileName = platformFile.name;
      File file = File(filePath);
      return PickedPDF(file: file, fileName: fileName);
    } else {
      // User canceled the picker
      return null;
    }
  } catch (e) {
    log('Error picking PDF file: $e');
    return null;
  }
}

Future<void> customLaunch(String receiptUrl) async {
  final Uri url = Uri.parse(receiptUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    debugPrint(' could not launch $url');
  }
}
