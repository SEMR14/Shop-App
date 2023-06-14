import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/ShopAppCubit/Cubit.dart';
import '../../../layout/ShopAppCubit/States.dart';
import '../../../models/GategoriesModel.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constant.dart';

class Catagories_Screen extends StatelessWidget {
  const Catagories_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      builder: (context, state) => ConditionalBuilder(
        condition: ShopApp_Cubit.get(context).categoriesModel != null,
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Categories_Builder(
              ShopApp_Cubit.get(context)
                  .categoriesModel!
                  .data!
                  .dataList[index]),
          separatorBuilder: (context, index) => Divider_Line(),
          itemCount:
              ShopApp_Cubit.get(context).categoriesModel!.data!.dataList.length,
        ),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      listener: (context, state) {},
    );
  }

  Widget Categories_Builder(CategoriesDataList? model) => Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(
                      model!.image ?? Sub_Image,
                    ),
                    width: 110,
                    height: 110,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.name ?? Sub_Text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  default_IconButton(
                    function: () {},
                    iconData: Icons.arrow_forward_ios,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
