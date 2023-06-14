import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../layout/Shop_Layout/Shop_Layout.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/local/ChcheHelper.dart';
import '../Regester_Screen/Resgester_Screen.dart';

class Login_Screen extends StatelessWidget {
  var Email_Controller = TextEditingController();
  var Password_Controller = TextEditingController();
  var Form_Key = GlobalKey<FormState>();
  bool showen = false;

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);

    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (BuildContext context, Object? state) {
        if (state is post_login_success_state) {
          if (state.loginmodel.status!) {
            CacheHelper.SaveData(
                    key: 'token', value: state.loginmodel.data!.token)
                .then((value) {
              TOKEN = state.loginmodel.data!.token;
              // Cubit.loginModel_ = null;
              // Cubit.cartGetModel = null;
              // Cubit.favoritesGetModel = null;
              //Cubit.Data_null();
              Cubit.getHomeData();
              Cubit.getCategories();
              Cubit.getProfile();
              Cubit.Get_favorites();
              Cubit.getCart();
              Cubit.Get_Address();
              Cubit.getProfile();
              Cubit.Get_Orders();
              // Future.delayed(const Duration(seconds: 2), () {
              //   ShopApp_Cubit.get(context).Current_Index = 0;
              //   NavigatToAndFinish(context: context, NextScreen: Shop_Layout());
              // });
              Cubit.Current_Index = 0;

              NavigatToAndFinish(context: context, NextScreen: Shop_Layout());

              //print(TOKEN);
            });
            ShowToast(
                Message: '${state.loginmodel.message}',
                state: ToastStates.Succes);
          } else {
            print(state.loginmodel.message);
            ShowToast(
              Message: '${state.loginmodel.message}',
              state: ToastStates.Error,
            );
          }
        } else if (state is post_login_error_state) {
          ShowToast(Message: state.error, state: ToastStates.Error);
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: Form_Key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
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
                          controller: Email_Controller,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validator_String: 'Email Address Must Not Be Empty',
                          onFieldSubmitted: (value) {}),
                      const SizedBox(
                        height: 10,
                      ),
                      Default_TextFormField(
                          controller: Password_Controller,
                          keyboardType: TextInputType.text,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: Cubit.suffixIcon,
                          sufixFunction: () {
                            Cubit.Change_Suffix_Icon();
                          },
                          validator_String: 'Password Must Not Be Empty',
                          obscure: Cubit.ispasswordshow,
                          onFieldSubmitted: (value) {
                            // if (Form_Key.currentState!.validate()) {
                            //   Cubit.userLogin(
                            //       email: Email_Controller.text,
                            //       password: Password_Controller.text);
                            //   // Cubit.getHomeData();
                            //   // Cubit.getCategories();
                            //   // Cubit.getProfile();
                            //   // Cubit.Get_favorites();
                            //   // Cubit.getCart();
                            //   // Cubit.Get_Address();
                            //   // Cubit.getProfile();

                            //   NavigatToAndFinish(
                            //       context: context, NextScreen: Shop_Layout());
                            // }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilderRec(
                        condition: state is! post_login_loding_state,
                        builder: (context) => Default_TextButton(
                            onPressed: () {
                              if (Form_Key.currentState!.validate()) {
                                Cubit.postLogin(
                                    email: Email_Controller.text,
                                    password: Password_Controller.text);
                              }
                            },
                            text: 'login'),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t Have An Account ?'),
                          TextButton(
                              onPressed: () {
                                Navigate_To(
                                    context: context,
                                    NextScreen: Regester_Screen());
                              },
                              child: const Text(
                                'Regester Now',
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
