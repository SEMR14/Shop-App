import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';

class Update_Profile_Screen extends StatelessWidget {
  var User_Name_controller = TextEditingController();

  var Email_controller = TextEditingController();

  var Phone_controller = TextEditingController();

  var Form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {},
      builder: (context, state) {
        User_Name_controller.text = Cubit.Settings_LoginMOdel!.data!.name!;
        Email_controller.text = Cubit.Settings_LoginMOdel!.data!.email!;
        Phone_controller.text = Cubit.Settings_LoginMOdel!.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: default_IconButton(
              function: () {
                Navigator.pop(context);
              },
              iconData: Icons.arrow_back_ios,
            ),
            title: const Text(
              'Update Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: Form_key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Default_TextFormField(
                        controller: User_Name_controller,
                        keyboardType: TextInputType.text,
                        label: 'User Name',
                        prefixIcon: Icons.person_outline,
                        validator_String: 'User Name Must Not Be Empty',
                        onFieldSubmitted: (value) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Default_TextFormField(
                        controller: Email_controller,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        validator_String: 'Email Address Must Not Be Empty',
                        onFieldSubmitted: (value) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Default_TextFormField(
                        controller: Phone_controller,
                        keyboardType: TextInputType.text,
                        label: 'Phone Number',
                        prefixIcon: Icons.phone_outlined,
                        validator_String: 'Phone Number Must Not Be Empty',
                        onFieldSubmitted: (value) {
                          if (Form_key.currentState!.validate()) {
                            Cubit.Update_Profile(
                                userName: User_Name_controller.text,
                                emailAddress: Email_controller.text,
                                phoneNumber: Phone_controller.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! UpdateProfile_Loading_State,
                        builder: (context) => Default_TextButton(
                            onPressed: () {
                              if (Form_key.currentState!.validate()) {
                                Cubit.Update_Profile(
                                    userName: User_Name_controller.text,
                                    emailAddress: Email_controller.text,
                                    phoneNumber: Phone_controller.text);
                              }
                            },
                            text: "update"),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
