import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';

class Update_Address extends StatelessWidget {
  var addressNamme_Controller = TextEditingController();
  var city_Controller = TextEditingController();
  var region_Controller = TextEditingController();
  var streetAndBuilding_Controller = TextEditingController();
  var Form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);

    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
        listener: (context, state) {},
        builder: (context, state) {
          if (Cubit.get_address_model!.data!.data.isNotEmpty) {
            addressNamme_Controller.text =
                Cubit.get_address_model!.data!.data[0].name!;
            city_Controller.text = Cubit.get_address_model!.data!.data[0].city!;
            region_Controller.text =
                Cubit.get_address_model!.data!.data[0].region!;
            streetAndBuilding_Controller.text =
                Cubit.get_address_model!.data!.data[0].details!;
          }

          if (state is UpdateAddress_Success_State) {
            if (state.Update_My_Address.status!) {
              ShowToast(
                  Message: state.Update_My_Address.message!,
                  state: ToastStates.Succes);
            } else {
              ShowToast(
                  Message: state.Update_My_Address.message!,
                  state: ToastStates.Error);
            }
          }
          return Scaffold(
            appBar: AppBar(
              leading: default_IconButton(
                function: () {
                  Navigator.pop(context);
                },
                iconData: Icons.arrow_back_ios,
              ),
              title: const Text(
                'Update Address',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ConditionalBuilder(
              condition: Cubit.get_address_model!.data!.data.isNotEmpty,
              //condition: false,
              builder: (context) => Form(
                key: Form_key,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          validator_String:
                              'Street and building Must Not Be Empty',
                          onFieldSubmitted: (value) {
                            if (Form_key.currentState!.validate()) {
                              //Cubit.Get_Address();
                              Cubit.Update_My_Address(
                                addressName: addressNamme_Controller.text,
                                city: city_Controller.text,
                                region: region_Controller.text,
                                streetANDbuilding:
                                    streetAndBuilding_Controller.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          //condition: state is! GetAddress_Loading_State,
                          condition: true,
                          builder: (context) => Default_TextButton(
                              onPressed: () {
                                if (Form_key.currentState!.validate()) {
                                  Cubit.Update_My_Address(
                                    addressName: addressNamme_Controller.text,
                                    city: city_Controller.text,
                                    region: region_Controller.text,
                                    streetANDbuilding:
                                        streetAndBuilding_Controller.text,
                                  );
                                  // Cubit.Get_Address();
                                }
                              },
                              text: "Update"),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => The_Page_is_Empty(
                  icon: Icons.place, text: 'There Is No Addresses'),
            ),
          );
        });
  }
}
