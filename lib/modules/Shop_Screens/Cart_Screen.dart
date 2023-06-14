import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';
import '../Order_Screens/Adress_Screen.dart';
import '../Order_Screens/Order_Screen.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
        listener: (context, state) {},
        builder: (context, state) {
          // Cubit.getCart();
          return Scaffold(
            body: ConditionalBuilder(
              //condition: state is Cart_Get_Success_State,
              condition: Cubit.cartGetModel!.data!.cartItems != null,
              builder: (context) => ShopApp_Cubit.get(context)
                      .cartGetModel!
                      .data!
                      .cartItems!
                      .isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ConditionalBuilder(
                              condition: true,
                              //condition: Cubit.cartGetModel!.data!.cartItems != null,
                              builder: (context) => ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    Product_Item_Builder(
                                  model: ShopApp_Cubit.get(context)
                                      .cartGetModel!
                                      .data!
                                      .cartItems![index]
                                      .product,
                                  context: context,
                                ),
                                separatorBuilder: (conext, index) =>
                                    Divider_Line(),
                                itemCount: ShopApp_Cubit.get(context)
                                    .cartGetModel!
                                    .data!
                                    .cartItems!
                                    .length,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              )),
                            ),
                          ),
                          Default_TextButton(
                              onPressed: () {
                                // Cubit.Get_Address();
                                // if (Cubit.get_address_model!.data!.data.isEmpty
                                //     //true
                                //     ) {
                                //   Navigate_To(
                                //       context: context,
                                //       NextScreen: Address_Form_Screen());
                                // } else {
                                //   // if (state is GetAddress_Success_State) {
                                //   Navigate_To(
                                //       context: context,
                                //       NextScreen: const Order_Screen());
                                //   //}
                                // }

                                //ShopApp_Cubit.get(context).Get_Address();

                                if (ShopApp_Cubit.get(context)
                                    .get_address_model!
                                    .data!
                                    .data
                                    .isEmpty) {
                                  Navigate_To(
                                      context: context,
                                      NextScreen: Address_Form_Screen());
                                } else {
                                  Cubit.Get_Address();
                                  Navigate_To(
                                      context: context,
                                      NextScreen: const Order_Screen());
                                }
                                ;
                              },
                              text: 'Order Now',
                              color: Colors.deepOrange),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : The_Page_is_Empty(
                      icon: Icons.shopping_cart_outlined,
                      text: 'YOUR CART IS EMPTY'),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
