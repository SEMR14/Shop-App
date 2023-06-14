import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/ShopAppCubit/Cubit.dart';
import '../../../layout/ShopAppCubit/States.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/network/local/ChcheHelper.dart';
import '../../Login_Screen/Login_Screen.dart';
import '../../Settings_Screen/About_Us_Screen.dart';
import '../../Settings_Screen/Languages_Screen.dart';
import '../../Settings_Screen/MY_Orders.dart';
import '../../Settings_Screen/QA_Screen.dart';
import '../../Settings_Screen/Update_My_Address.dart';
import '../../Settings_Screen/Update_Profile.dart';

// ignore: camel_case_types
class Settings_Screen extends StatelessWidget {
  var Scaffold_Key = GlobalKey<ScaffoldState>();
  var Complaint_Controller = TextEditingController();
  bool Complaint_sent = false;
  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {
        if (state is Complaint_Success_State) {
          if (state.post_complaint_model.status!) {
            ShowToast(
                Message: state.post_complaint_model.message!,
                state: ToastStates.Succes);
          } else {
            ShowToast(
                Message: state.post_complaint_model.message!,
                state: ToastStates.Error);
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: Cubit.Settings_LoginMOdel != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => Scaffold(
          key: Scaffold_Key,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: const Text(
              "Settings",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              "${ShopApp_Cubit.get(context).Settings_LoginMOdel!.data!.image}"
                              //'https://media.istockphoto.com/id/1283504873/photo/mosque-and-bosphorus-bridge.jpg?b=1&s=170667a&w=0&k=20&c=D5AwrHMbPX8u4MUXYPx3dlCAz0KeKclxq9CJqSTmJ10='
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          width: 300,
                          child: Center(
                            child: Text(
                              ShopApp_Cubit.get(context)
                                  .Settings_LoginMOdel!
                                  .data!
                                  .name!,
                              //'dfsfsd',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ShopApp_Cubit.get(context)
                              .Settings_LoginMOdel!
                              .data!
                              .email!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  settingItem(
                      //key: Scaffold_Key,
                      icon: Icons.person,
                      text: "Update Profile",
                      function: () {
                        Navigate_To(
                            context: context,
                            NextScreen: Update_Profile_Screen());
                      }),
                  settingItem(
                      icon: Icons.home_outlined,
                      text: "My Adress",
                      function: () {
                        //Cubit.Get_Address();
                        // if (state is GetAddress_Success_State) {
                        Navigate_To(
                            context: context, NextScreen: Update_Address());
                        //  } else {
                        //const Center(child: CircularProgressIndicator());
                        //  }
                      }),
                  settingItem(
                      icon: Icons.shopping_cart_checkout,
                      text: "My Orders",
                      function: () {
                        Cubit.Get_Orders();
                        Navigate_To(
                            context: context, NextScreen: My_Orders_Screen());
                      }),
                  settingItem(
                      icon: Icons.language_outlined,
                      text: "Languages",
                      function: () {
                        Navigate_To(
                            context: context, NextScreen: Languages_Screen());
                      }),
                  settingItem(
                      icon: Icons.question_answer_outlined,
                      text: "FAQs",
                      function: () {
                        Cubit.Get_FAQs();
                        Navigate_To(context: context, NextScreen: QA_Screen());
                      }),
                  settingItem(
                      icon: Icons.line_axis_outlined,
                      text: "Your Complaints",
                      function: () {
                        bool send = false;
                        Scaffold_Key.currentState!.showBottomSheet(
                          (context) => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Default_TextFormField(
                                          controller: Complaint_Controller,
                                          keyboardType: TextInputType.text,
                                          label: 'Your Complaint',
                                          prefixIcon: Icons.line_axis_outlined,
                                          validator_String:
                                              'You Must write your complaint',
                                          onFieldSubmitted: () {}),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          ShopApp_Cubit.get(context)
                                              .Post_Complaint(
                                            name: Cubit.Settings_LoginMOdel!
                                                .data!.name!,
                                            phone: Cubit.Settings_LoginMOdel!
                                                .data!.phone!,
                                            email: Cubit.Settings_LoginMOdel!
                                                .data!.email!,
                                            message: Complaint_Controller.text,
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            height: 40,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Send',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      ),
                                    ])),
                          ),
                        );
                      }),
                  settingItem(
                      icon: Icons.people_outlined,
                      text: "About Us",
                      function: () {
                        // Cubit.Get_AboutUs();
                        // Cubit.Get_Contacts();
                        Navigate_To(
                            context: context, NextScreen: About_Us_Screen());
                      }),
                  TextButton(
                      onPressed: () {
                        Scaffold_Key.currentState!
                            .showBottomSheet((context) => Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(30),
                                      topEnd: Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Do you want to logout?',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Default_TextButton(
                                                  onPressed: () {
                                                    CacheHelper.removeData(
                                                            key: 'token')
                                                        .then((value) {
                                                      if (value) {
                                                        NavigatToAndFinish(
                                                            context: context,
                                                            NextScreen:
                                                                Login_Screen());
                                                      }
                                                    });
                                                  },
                                                  text: 'YES',
                                                  color: Colors.red,
                                                  height: 40,
                                                  width: 150),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Default_TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: 'NO',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 150),
                                            ],
                                          )
                                        ]),
                                  ),
                                ));
                      },
                      child: Container(
                        height: 42.5,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget settingItem({
    required String text,
    required IconData icon,
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
    Function? function,
    Key? key,
  }) =>
      TextButton(
        //key: ,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          function!();
        },
        child: Container(
          height: 42.5,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 7.5,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22.5,
                  color: iconColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15.5,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ),
      );
}

// Center(
//         child: default_IconButton(
//             function: () {
//               CacheHelper.removeData(key: 'token').then((value) {
//                 if (value) {
//                   NavigatToAndFinish(
//                       context: context, NextScreen: Login_Screen());
//                 }
//               });
//               // CacheHelper.clearAll().then((value) {
//               //   NavigatToAndFinish(
//               //       context: context, NextScreen: Onboarding_page());
//               // });
//             },
//             iconData: Icons.logout));