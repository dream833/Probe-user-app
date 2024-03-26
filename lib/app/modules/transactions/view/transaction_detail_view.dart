import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/transaction_model.dart';
import 'package:uddipan/utils/snippet.dart';

class TransactionDetailView extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetailView({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transaction Info',
          style: CustomFont.mediumTextRaleway.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SvgPicture.asset(AppImage.bg1, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF06B198),
                    radius: 32,
                    child: Text(
                        transaction.doctor.firstName.toString().substring(0, 1),
                        style: CustomFont.mediumTextPoppins.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      '${transaction.doctor.firstName} ${transaction.doctor.lastName}',
                      style: CustomFont.mediumTextPoppins.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 8),
                Text(
                  'NA',
                  style: CustomFont.regularTextPoppins.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'successfullyCharged',
                  style: CustomFont.regularTextPoppins.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: appColorPrimary,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.9 / 1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFE4E4E4)),
                      child: Center(
                        child: Text(
                          "BDT${transaction.amount.toString()}",
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (transaction.receiptUrl.isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          // print(transaction.receiptUrl);
                          await customLaunch(transaction.receiptUrl);
                        },
                        child: Container(
                            height: 40,
                            width: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFF06B198),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(AppImage.fileIcon),
                            )),
                      ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        getSheetListItem(
                            a: 'Card Holder Name',
                            b: transaction.cardHolderName,
                            c: 'Account',
                            d: "**** **** ${transaction.last4digit}"),
                        const SizedBox(height: 10),
                        const Divider(color: Color(0xFFF3F3F3)),
                        const SizedBox(height: 10),
                        getSheetListItem(
                            a: 'Amount',
                            b: '${transaction.amount} BDT',
                            c: 'Card Type',
                            d: transaction.cardType),
                        const SizedBox(height: 10),
                        const Divider(color: Color(0xFFF3F3F3)),
                        const SizedBox(height: 10),
                        getSheetListItem(
                            a: 'Patient',
                            b: transaction.appointment.patientName.toString(),
                            c: 'Appointment Date',
                            d: formatDate(transaction.createdAt)),
                        // const SizedBox(height: 5),
                        // const Divider(color: Color(0xFFF3F3F3)),
                        // const SizedBox(height: 5),
                        // getSheetListItem(
                        //     a: 'tax'.tr(),
                        //     b: "€ ${transaction.tax.toStringAsFixed(2)}",
                        //     c: "",
                        //     d: ""),
                        // const SizedBox(height: 5),
                        // const Divider(color: Color(0xFFF3F3F3)),
                        // const SizedBox(height: 10),
                        // getSheetListItem(
                        //     a: "Date",
                        //     b: parseDateTime(transaction.createdAt),
                        //     c: " ",
                        //     d: " "),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getSheetListItem(
    {required String a,
    required String b,
    required String c,
    required String d}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            a,
            style: CustomFont.regularTextPoppins.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          if (c.isNotEmpty) const SizedBox(height: 5),
          Text(
            c,
            style: CustomFont.regularTextPoppins.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            b,
            style: CustomFont.regularTextPoppins.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          if (d.isNotEmpty) const SizedBox(height: 5),
          Text(
            d,
            style: CustomFont.regularTextPoppins.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
      ),
    ],
  );
}
