import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../layout/ShopAppCubit/Cubit.dart';
import '../layout/ShopAppCubit/States.dart';
import '../models/HomeModel.dart';
import '../shared/componants/componants.dart';

class Product_Describtion_Screen extends StatelessWidget {
  static const routeName = '/product-details-screen';
  var Scaffold_Key = GlobalKey<ScaffoldState>();
  var controller_ = ScrollController();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    List<products_model>? list =
        ShopApp_Cubit.get(context).homepage_model!.data!.products;
    final data = list!.firstWhere((element) => element.id == id);
    print(data.description);
    List<String> imagesList = data.images!;
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: Scaffold_Key,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ShopApp_Cubit.get(context).activeSlide = 0;
                Navigator.pop(context);
              },
              icon: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 28,
                    )
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: imagesList.length,
                                itemBuilder: (context, index, realIndex) {
                                  String image = imagesList[index];
                                  return Picture_Builder(image: image);
                                },
                                options: CarouselOptions(
                                    height: 320,
                                    initialPage: 0,
                                    viewportFraction: 1,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, reason) {
                                      ShopApp_Cubit.get(context)
                                          .Change_Page_ProductDetials(index);
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex:
                                    ShopApp_Cubit.get(context).activeSlide,
                                count: imagesList.length,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: Colors.blue,
                                  dotColor: Colors.grey,
                                  dotHeight: 9,
                                  dotWidth: 8,
                                  spacing: 4,
                                  expansionFactor: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 320,
                                  height: 75,
                                  //color: Colors.red,
                                  child: Text(
                                    data.name!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      ShopApp_Cubit.get(context)
                                          .changeFavorite(id);
                                    },
                                    icon: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          ShopApp_Cubit.get(context)
                                                  .favorites[id]!
                                              ? Colors.blue
                                              : Colors.grey,
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${data.price.round()} TL',
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                if (data.discount != 0)
                                  Text(
                                    '${data.oldPrice.round()} TL',
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider_Line(),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              height: 170,
                              //color: Colors.blue,
                              child: Text(
                                data.description!,
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  Scaffold_Key.currentState!.showBottomSheet(
                                      (context) =>
                                          showButtonBuilder(data.description!));
                                },
                                child:  Row(
                                  children: [
                                    Text(
                                      'More details',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      ShopApp_Cubit.get(context).changeCartStatus(id);
                    },
                    child: Container(
                      child: Text(
                        ShopApp_Cubit.get(context).cart[id]!
                            ? 'Remove from cart'
                            : 'Add to cart',
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Picture_Builder({
    required String image,
  }) =>
      Container(
        //margin: EdgeInsets.symmetric(
        //horizontal: 10,
        // ),
        height: 320,
        width: 700,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Image(
          image: NetworkImage(
            image,
          ),
        ),
      );

  Widget showButtonBuilder(String description) => Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(30),
            topEnd: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
        ),
      );
}
