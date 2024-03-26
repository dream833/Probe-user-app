import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/color_constant.dart';
import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: Image.asset(
              "assets/images/doctor.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50,),
              ),
            ),
            child: const Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Text(
                "Welcome To Uddipan Probe User Application",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 80,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Get.toNamed("/login");
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColor.secondaryColor,borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding:  EdgeInsets.symmetric(horizontal:  40.0,vertical: 20.0),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: (){
                    Get.toNamed("/signup");
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColor.litt,borderRadius: BorderRadius.circular(10)),
                  child:  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal:  40.0,vertical: 20.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        color: AppColor.green,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
