import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/componants/constant.dart';

import '../../layout/ShopAppCubit/Cubit.dart';
import '../../models/HomeModel.dart';
import '../../modules/Product_Descreption_Screen.dart';

void NavigatToAndFinish({
  required context,
  required NextScreen,
}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => NextScreen), (route) => false);

Widget Default_TextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required IconData prefixIcon,
  required String validator_String,
  required Function onFieldSubmitted,
  IconData? suffixIcon,
  Function? sufixFunction,
  bool obscure = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text('${label}'),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  sufixFunction!();
                },
                icon: Icon(suffixIcon))
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '${validator_String}';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted(value);
      },
    );

Widget Default_TextButton({
  required Function onPressed,
  required String text,
  Color color = Colors.blue,
  double height = 45,
  double width = double.infinity,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            '${text.toUpperCase()}',
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    );

void Navigate_To({
  required context,
  required Widget NextScreen,
}) =>
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NextScreen));

void ShowToast({
  required String Message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: "${Message}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Choose_Toast_Color(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { Succes, Error, Warning }

Color Choose_Toast_Color(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.Succes:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget default_IconButton({
  required Function function,
  required IconData iconData,
  Color? color = Colors.black,
  double? size,
}) =>
    IconButton(
      onPressed: () {
        function();
      },
      icon: Icon(
        iconData,
        color: color,
        size: size,
      ),
    );

Widget Divider_Line() => Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[300],
    );

Widget Product_Item_Builder({
  required dynamic model,
  required context,
  bool isdiscont = true,
  bool information_done = true,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                GestureDetector(
                  onTap: () {
                    if (information_done) {
                      Navigator.of(context).pushNamed(
                          Product_Describtion_Screen.routeName,
                          arguments: model.id);
                    }
                  },
                  child: Image(
                    image: NetworkImage(model.image ?? Sub_Network_Image),
                    height: 100,
                    width: 130,
                  ),
                ),
                if (isdiscont)
                  if (model.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      color: Colors.red,
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      //width: 400,
                      child: Text(
                        '${model.name ?? Sub_Text}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${model.price!.round() ?? Sub_Price}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (isdiscont)
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice!.round() ?? Sub_Price}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopApp_Cubit.get(context)
                                  .changeCartStatus(model.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor:
                                  ShopApp_Cubit.get(context).cart[model.id]!
                                      ? Colors.deepOrange
                                      : Colors.grey,
                              radius: 17,
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 16,
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              ShopApp_Cubit.get(context)
                                  .changeFavorite(model.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ShopApp_Cubit.get(context)
                                      .favorites[model.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                              radius: 17,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget The_Page_is_Empty({
  required IconData icon,
  required String text,
}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
            color: Colors.grey[300],
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.grey[400]),
          )
        ],
      ),
    );

Widget GridleViewBulder(products_model? model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    Product_Describtion_Screen.routeName,
                    arguments: model!.id);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => Product_Describtion_Screen(
                //             model.id,
                //             model.name,
                //             model.images!,
                //             model.description,
                //             model.price,
                //             model.oldPrice,
                //             model.discount))));
              },
              child: Image(
                image: NetworkImage(model!.image ?? Sub_Network_Image),
                width: double.infinity,
                height: 200,
              ),
            ),
            if (model.discount != 0)
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  height: 40,
                  child: Text(
                    model.name ?? Sub_Text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${model.price!.round() ?? Sub_Price}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice!.round() ?? Sub_Price}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              ShopApp_Cubit.get(context)
                                  .changeFavorite(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShopApp_Cubit.get(context)
                                      .favorites[model.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              ShopApp_Cubit.get(context)
                                  .changeCartStatus(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  ShopApp_Cubit.get(context).cart[model.id]!
                                      ? Colors.deepOrange
                                      : Colors.grey,
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 16,
                              ),
                            )),
                      ],
                    )
                  ],
                )
              ],
            )),
      ],
    ),
  );
}
