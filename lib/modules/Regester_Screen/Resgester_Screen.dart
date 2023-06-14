import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../layout/Shop_Layout/Shop_Layout.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/local/ChcheHelper.dart';
import '../Order_Screens/Adress_Screen.dart';

class Regester_Screen extends StatelessWidget {
  var User_Name_controller = TextEditingController();

  var Email_controller = TextEditingController();

  var Password_controller = TextEditingController();

  var Phone_controller = TextEditingController();

  var Form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {
        if (state is Register_Success_State) {
          if (state.loginModel.status!) {
            ShowToast(
                Message: state.loginModel.message!, state: ToastStates.Succes);
            Cubit.postLogin(
              email: Email_controller.text,
              password: Password_controller.text,
            );

            CacheHelper.SaveData(
                    key: 'token', value: Cubit.loginmodel!.data!.token)
                .then((value) {
              TOKEN = Cubit.loginmodel!.data!.token;
              Cubit.getHomeData();
              Cubit.getCategories();
              Cubit.getProfile();
              Cubit.Get_favorites();
              Cubit.getCart();
              Cubit.Get_Address();
              Cubit.Get_Orders();
              Cubit.getProfile();
              Future.delayed(const Duration(seconds: 2), () {
                ShopApp_Cubit.get(context).Current_Index = 0;
                NavigatToAndFinish(context: context, NextScreen: Shop_Layout());
              });
            });
          } else {
            ShowToast(
                Message: state.loginModel.message!, state: ToastStates.Error);
          }
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
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
                      'REGISTER',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Login now to browse our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
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
                      controller: Password_controller,
                      keyboardType: TextInputType.text,
                      label: 'Password',
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: Cubit.isShow
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      obscure: Cubit.isShow,
                      sufixFunction: () {
                        Cubit.Change_Password_Eye();
                      },
                      validator_String: 'Password Must Not Be Empty',
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
                          Cubit.Post_Register(
                              userName: User_Name_controller.text,
                              emailAddress: Email_controller.text,
                              password: Password_controller.text,
                              phoneNumber: Phone_controller.text);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is! Register_Loading_State,
                      builder: (context) => Default_TextButton(
                          onPressed: () {
                            if (Form_key.currentState!.validate()) {
                              Cubit.Post_Register(
                                  userName: User_Name_controller.text,
                                  emailAddress: Email_controller.text,
                                  password: Password_controller.text,
                                  phoneNumber: Phone_controller.text);
                            }
                          },
                          text: "register"),
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
      ),
    );
  }
}
