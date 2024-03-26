import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/modules/transactions/view/transaction_detail_view.dart';
import 'package:uddipan/app/modules/transactions/view/widgets/transaction_widget.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../../widget/Text/small_text.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SmallText(
            text: 'Transactions',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                  future:
                      profileController.getTransactionList(context: context),
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => TransactionDetailView(
                                    transaction: transactionModel));
                              },
                              child: CustomTransactionCard(
                                transaction: transactionModel!,
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
