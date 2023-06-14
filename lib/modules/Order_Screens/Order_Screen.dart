import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';
import 'Order_Done_Screen.dart';

class Order_Screen extends StatelessWidget {
  const Order_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);

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
            'Order',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ConditionalBuilder(
          condition: state is GetAddress_Success_State,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    radius: 60,
                    child: Icon(
                      Icons.done,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text_title_A(title_A: 'Total price'),
                const SizedBox(
                  height: 10,
                ),
                Text_title_B(
                    title_B:
                        //   'ddd',
                        // ),

                        '${ShopApp_Cubit.get(context).cartGetModel!.data!.total} TL'),
                Divder_Line_(),
                Text_title_A(title_A: 'Payment Method'),
                const SizedBox(
                  height: 10,
                ),
                Text_title_B(title_B: 'Cash'),
                Divder_Line_(),
                Text_title_A(title_A: 'Address Name'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  // 'dd',
                  '  ${ShopApp_Cubit.get(context).get_address_model!.data!.data[0].name}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divder_Line_(),
                const SizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                    condition: state is! Order_postOrder_Loading_State,
                    builder: (context) => Default_TextButton(
                          onPressed: () {
                            Cubit.Post_Order();

                            NavigatToAndFinish(
                                context: context,
                                NextScreen: const Order_Done_Screen());
                          },
                          text: 'confirm',
                          color: Colors.deepOrange,
                        ),
                    fallback: (conext) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        )),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }

  Widget Text_title_A({
    required String title_A,
  }) =>
      Text(
        '- ${title_A}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget Text_title_B({
    required String title_B,
  }) =>
      Text(
        '  ${title_B}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget Divder_Line_() => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Divider_Line(),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
