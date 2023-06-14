// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/BlocObserver.dart';
import 'package:shopapp/shared/componants/constant.dart';
import 'package:shopapp/shared/network/local/ChcheHelper.dart';
import 'package:shopapp/shared/network/network/DioHelper.dart';
import 'layout/ShopAppCubit/Cubit.dart';
import 'layout/Shop_Layout/Shop_Layout.dart';
import 'modules/Login_Screen/Login_Screen.dart';
import 'modules/Onboarding_Page/Onboarding_Page.dart';
import 'modules/Product_Descreption_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.intial();
  DioHelper.intial();
  // 3434234234
  print('dfdf');
  Widget StartScreen;
  dynamic Onboarding = CacheHelper.GetData(
    key: 'onboarding',
  );

  TOKEN = CacheHelper.GetData(key: 'token');
  print(TOKEN);
  //String token = 'hello';

  if (Onboarding == true) {
    if (TOKEN != null)
      StartScreen = Shop_Layout();
    else
      StartScreen = Login_Screen();
  } else {
    StartScreen = Onboarding_page();
  }

  runApp(MyApp(
    Onboarding: Onboarding,
    StartPage: StartScreen,
  ));
}

class MyApp extends StatelessWidget {
  bool? Onboarding;
  Widget? StartPage;
  MyApp({this.Onboarding, this.StartPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopApp_Cubit()
              ..getHomeData()
              ..getCategories()
              ..Get_favorites()
              ..Get_Address()
              ..getCart()
              ..Get_Orders()
              ..getProfile()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          navigationBarTheme:
              NavigationBarThemeData(backgroundColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        home: StartPage,
        //home: Onboarding_page(),
        routes: {
          Product_Describtion_Screen.routeName: (ctx) =>
              Product_Describtion_Screen(),
        },
      ),
    );
  }
}
