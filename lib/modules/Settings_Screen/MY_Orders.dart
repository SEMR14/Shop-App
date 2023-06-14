import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';

class My_Orders_Screen extends StatelessWidget {
  const My_Orders_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: default_IconButton(
            function: () {
              Navigator.pop(context);
            },
            iconData: Icons.arrow_back_ios,
          ),
          title: const Text(
            'My Orders',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ConditionalBuilder(
          condition: ShopApp_Cubit.get(context)
              .get_orders_model!
              .data!
              .data!
              .isNotEmpty,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Get_Orders_Item(
                  ShopApp_Cubit.get(context)
                      .get_orders_model!
                      .data!
                      .data![index]),
              separatorBuilder: (context, index) => Divider_Line(),
              itemCount: ShopApp_Cubit.get(context)
                  .get_orders_model!
                  .data!
                  .data!
                  .length),
          fallback: (context) => The_Page_is_Empty(
              icon: Icons.shopping_cart_checkout_sharp,
              text: 'There Is No Orders Yet'),
        ),
      ),
    );
  }

  Widget Get_Orders_Item(model) => Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 7.5,
              ),
              const Icon(
                Icons.shopping_cart_checkout,
                size: 100,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${model.date}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${model.total.round()} TL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.blur_circular,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${model.status}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
