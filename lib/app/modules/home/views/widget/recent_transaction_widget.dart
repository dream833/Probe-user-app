import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/modules/transactions/view/transaction_detail_view.dart';
import 'package:uddipan/app/modules/transactions/view/transaction_view.dart';
import 'package:uddipan/app/modules/transactions/view/widgets/transaction_widget.dart';
import 'package:uddipan/utils/snippet.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black)),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AllTransactionView());
                },
                child: Text('See All',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
        FutureBuilder(
            future: profileController.getTransactionList(context: context),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return shimmerListEffect();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: profileController.transactionList.length,
                  itemBuilder: (_, index) {
                    final transactionModel =
                        profileController.transactionList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>TransactionDetailView(transaction: transactionModel));
                        },
                        child: CustomTransactionCard(
                          transaction: transactionModel!,
                        ),
                      ),
                    );
                  });
            })
      ],
    );
  }
}
