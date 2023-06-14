import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/local/ChcheHelper.dart';
import 'Order_Screen.dart';

class Address_Form_Screen extends StatelessWidget {
  // Address_Form_Screen(this.email, this.password);
  var addressNamme_Controller = TextEditingController();
  var city_Controller = TextEditingController();
  var region_Controller = TextEditingController();
  var streetAndBuilding_Controller = TextEditingController();
  var Form_key = GlobalKey<FormState>();
  // String email;
  // String password;

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);

    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {
        if (state is postAddress_Success_State) {
          Cubit.Get_Address();
          ShowToast(
              Message: 'Your Address Added, Let Is Confirm Your Order',
              state: ToastStates.Succes);
          Navigate_To(context: context, NextScreen: Order_Screen());
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: default_IconButton(
            function: () {
              Navigator.pop(context);
            },
            iconData: Icons.arrow_back_ios,
          ),
          title: const Text(
            'Address',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
          key: Form_key,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Add your current address, You can update it from settings.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Default_TextFormField(
                    controller: addressNamme_Controller,
                    keyboardType: TextInputType.text,
                    label: 'Address Name',
                    prefixIcon: Icons.text_fields,
                    validator_String: 'Address Name Must Not Be Empty',
                    onFieldSubmitted: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Default_TextFormField(
                    controller: city_Controller,
                    keyboardType: TextInputType.text,
                    label: 'City ',
                    prefixIcon: Icons.place,
                    validator_String: 'City Must Not Be Empty',
                    onFieldSubmitted: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Default_TextFormField(
                    controller: region_Controller,
                    keyboardType: TextInputType.text,
                    label: 'Region',
                    prefixIcon: Icons.square_foot_sharp,
                    validator_String: 'Region Must Not Be Empty',
                    onFieldSubmitted: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Default_TextFormField(
                    controller: streetAndBuilding_Controller,
                    keyboardType: TextInputType.text,
                    label: 'Street and building',
                    prefixIcon: Icons.location_city,
                    validator_String: 'Street and building Must Not Be Empty',
                    onFieldSubmitted: (value) {
                      if (Form_key.currentState!.validate()) {
                        Cubit.Post_Address(
                          addressName: addressNamme_Controller.text,
                          city: city_Controller.text,
                          region: region_Controller.text,
                          streetANDbuilding: streetAndBuilding_Controller.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: state is! postAddress_Loading_State &&
                        state is! postAddress_Error_State,
                    builder: (context) => Default_TextButton(
                        color: Colors.blue,
                        onPressed: () {
                          if (Form_key.currentState!.validate()) {
                            Cubit.Post_Address(
                              addressName: addressNamme_Controller.text,
                              city: city_Controller.text,
                              region: region_Controller.text,
                              streetANDbuilding:
                                  streetAndBuilding_Controller.text,
                            );
                          }
                        },
                        text: "add address"),
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
  }
}
