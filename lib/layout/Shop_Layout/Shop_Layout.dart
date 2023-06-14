import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/Search_Page/Search.dart';
import '../../modules/Shop_Screens/Settings/Settings.dart';
import '../../shared/componants/componants.dart';
import '../ShopAppCubit/Cubit.dart';
import '../ShopAppCubit/States.dart';

class Shop_Layout extends StatelessWidget {
  int first_Page = 0;
  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);

    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'ShopApp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              // default_IconButton(
              //   function: () {},
              //   iconData: Icons.shopping_cart_outlined,
              //   color: Colors.black,
              // ),
              default_IconButton(
                function: () {
                  Navigate_To(context: context, NextScreen: Search_Page());
                },
                iconData: Icons.search_outlined,
                color: Colors.black,
              ),
              default_IconButton(
                function: () {
                  // Cubit.Get_AboutUs();
                  // Cubit.Get_Contacts();
                  Navigate_To(context: context, NextScreen: Settings_Screen());
                },
                iconData: Icons.settings_outlined,
                color: Colors.black,
              ),
            ],
          ),
          body: Cubit.Screens[Cubit.Current_Index],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: Cubit.Current_Index,
              onTap: (index) {
                Cubit.changeNavigatBar(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Catagories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: 'My Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ]),
        );
      },
    );
  }
}
