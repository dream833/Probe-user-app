import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/e-shop/view/cart_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:uddipan/constants/color_constant.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return GestureDetector(
      onTap: () {
        Get.to(() => const CartView());
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 10),
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -10, end: -12),
          ignorePointer: false,
          onTap: () {},
          badgeContent: Obx(() => Text(
                "${eshopController.products.keys.toList().length + eshopController.cartLabTest.length}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              )),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: appColorRed,
          ),
          child: const Icon(
            Icons.shopping_cart,
            size: 24,
          ),
        ),
      ),
    );
  }
}
