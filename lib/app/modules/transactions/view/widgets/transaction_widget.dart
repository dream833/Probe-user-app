import 'package:flutter/material.dart';
import 'package:uddipan/constants/color_constant.dart';

import 'package:uddipan/models/transaction_model.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../../../../constants/theme_constant.dart';

class CustomTransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const CustomTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: appColorPrimary,
              radius: 24,
              child: const Icon(
                Icons.arrow_outward,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transaction.doctor.firstName} ${transaction.doctor.lastName} ',
                  style: CustomFont.mediumTextRaleway.copyWith(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "BDT ${transaction.amount.toString()}",
                  style: CustomFont.regularTextPoppins.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDate(transaction.createdAt),
                  style: CustomFont.regularTextPoppins.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
