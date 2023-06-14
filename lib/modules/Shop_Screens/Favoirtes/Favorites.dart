import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/ShopAppCubit/Cubit.dart';
import '../../../layout/ShopAppCubit/States.dart';
import '../../../models/favorites_get_model.dart';
import '../../../shared/componants/componants.dart';

class Favorites_Screen extends StatelessWidget {
  const Favorites_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        //condition: true,
        condition: ShopApp_Cubit.get(context).favoritesGetModel != null,
        builder: (context) =>
            ShopApp_Cubit.get(context).favoritesGetModel!.data!.data!.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider_Line(),
                    itemBuilder: (context, index) => Product_Item_Builder(
                      model: ShopApp_Cubit.get(context)
                          .favoritesGetModel!
                          .data!
                          .data![index]
                          .product!,
                      // images: ShopApp_Cubit.get(context)
                      //     .homepage_model!
                      //     .data!
                      // .products![index]
                      // .images!,
                      context: context,
                    ),
                    itemCount: ShopApp_Cubit.get(context)
                        .favoritesGetModel!
                        .data!
                        .data!
                        .length,
                  )
                : The_Page_is_Empty(
                    icon: Icons.favorite_outline,
                    text: "THERE IS NO FAVORITES"),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
