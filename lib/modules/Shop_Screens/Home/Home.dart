//import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../layout/ShopAppCubit/Cubit.dart';
import '../../../layout/ShopAppCubit/States.dart';
import '../../../models/GategoriesModel.dart';
import '../../../models/HomeModel.dart';
import '../../../models/model.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constant.dart';
import '../../Product_Descreption_Screen.dart';

class Home_Screen extends StatelessWidget {
  var Scaffold_Key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {
        if (state is Change_Favorite_Success_State) {
          if (!state.model.status!) {
            ShowToast(Message: state.model.message!, state: ToastStates.Error);
          }
        }
        if (state is Cart_Change_Success_State) {
          if (!state.cartModel.status!) {
            ShowToast(
                Message: state.cartModel.message!, state: ToastStates.Error);
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: ShopApp_Cubit.get(context).homepage_model != null &&
            ShopApp_Cubit.get(context).categoriesModel != null,
        builder: (context) => Homebuilder(
            ShopApp_Cubit.get(context).homepage_model,
            ShopApp_Cubit.get(context).categoriesModel,
            context),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget Homebuilder(HomePage_Model? model, CategoriesModel? model2, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image ?? Sub_Network_Image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(
                  seconds: 4,
                ),
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              //key: Scaffold_Key,
              ' Categories',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    CategoriesBulder(model2!.data!.dataList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 15,
                ),
                itemCount: model2!.data!.dataList.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              ' New products',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                    model.data!.products!.length,
                    (index) => GridleViewBulder(
                      model.data!.products![index],
                      context,
                    ),
                  ),
                ))
          ],
        ),
      );
  Widget CategoriesBulder(CategoriesDataList? model) => Container(
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model!.image ?? Sub_Network_Image),
              height: 100,
              width: 100,
            ),
            Container(
              width: 100,
              height: 20,
              color: Colors.black.withOpacity(0.7),
              child: Text(
                model.name ?? Sub_Text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      );

  // ignore: non_constant_identifier_names

}
