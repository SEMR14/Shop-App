import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/AboutUs_model.dart';
import '../../models/Cart_Get_Model.dart';
import '../../models/Cart_model.dart';
import '../../models/Contacts_model.dart';
import '../../models/FavoriteModel.dart';
import '../../models/GategoriesModel.dart';
import '../../models/Get_Address_Model.dart';
import '../../models/Get_Orders_Model.dart';
import '../../models/HomeModel.dart';
import '../../models/Post_Address_Model.dart';
import '../../models/Post_Complaint_Model.dart';
import '../../models/Post_Order_Model.dart';
import '../../models/QA_Model.dart';
import '../../models/Update_Profile_Model.dart';
import '../../models/favorites_get_model.dart';
import '../../models/loginmodel.dart';
import '../../modules/Shop_Screens/Cart_Screen.dart';
import '../../modules/Shop_Screens/Catagories/Catagories.dart';
import '../../modules/Shop_Screens/Favoirtes/Favorites.dart';
import '../../modules/Shop_Screens/Home/Home.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/network/DioHelper.dart';
import 'States.dart';

// ignore: camel_case_types
class ShopApp_Cubit extends Cubit<ShoopApp_States> {
  ShopApp_Cubit() : super(Intial_ShoopApp_States_State());

  static ShopApp_Cubit get(context) => BlocProvider.of(context);

  bool ispasswordshow = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void Change_Suffix_Icon() {
    ispasswordshow = !ispasswordshow;
    suffixIcon = ispasswordshow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(Suffix_Icon_State());
  }

  void Data_null() {
    //  Cubit.getHomeData();
    //           Cubit.getCategories();
    //           Cubit.getProfile();
    //           Cubit.Get_favorites();
    //           Cubit.getCart();
    //           Cubit.Get_Address();
    //           Cubit.getProfile();
    //           Cubit.Get_Orders();
    categoriesModel = null;
    homepage_model = null;
    cartGetModel = null;
    emit(Home_Loading_State());
  }

  LoginModel? loginModel_;

  void postLogin({
    required String email,
    required String password,
  }) {
    emit(post_login_loding_state());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel_ = LoginModel.fromJson(value.data);
      emit(post_login_success_state(loginModel_!));

      print(loginModel_!.data!.name);
    }).catchError((error) {
      print(error.toString());
      emit(post_login_error_state(error.toString()));
    });
  }

  LoginModel? loginmodel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(post_login_loding_state());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginmodel = LoginModel.fromJson(value.data);
      emit(post_login_success_state(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(post_login_error_state(error.toString()));
    });
  }

  // ignore: non_constant_identifier_names
  int Current_Index = 0;

  List<Widget> Screens = [
    Home_Screen(),
    const Catagories_Screen(),
    const Cart_Screen(),
    const Favorites_Screen(),
  ];

  void changeNavigatBar(index) {
    Current_Index = index;
    emit(Change_NavigatBar_State());
  }

  HomePage_Model? homepage_model;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

  void getHomeData() {
    emit(Home_Loading_State());
    DioHelper.GetData(
      url: HOME,
      token: TOKEN,
    ).then((value) {
      homepage_model = HomePage_Model.fromJson(value.data);

      // ignore: avoid_function_literals_in_foreach_calls
      homepage_model!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      homepage_model!.data!.products!.forEach((element) {
        cart.addAll({
          element.id!: element.inCart!,
        });
      });
      emit(Home_Success_State());
    }).catchError((error) {
      emit(Home_Error_State(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(Loading_Categories_state());
    DioHelper.GetData(
      url: Categories,
      token: TOKEN,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(Categories_Success_State());
    }).catchError((error) {
      emit(Categories_Error_State(error.toString()));
    });
  }

  favorite_model? favoriteModel;

  void changeFavorite(productId) {
    favorites[productId] = !favorites[productId]!;
    emit(Favorite_Success_State());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: TOKEN,
    ).then((value) {
      favoriteModel = favorite_model.fromjson(value.data);
      //print(value.data);
      if (!favoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        Get_favorites();
      }
      emit(Change_Favorite_Success_State(favoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(Favorite_Error_State(error.toString()));
    });
  }

  // GET FAVORITES
  Favorites_get_model? favoritesGetModel;

  void Get_favorites() {
    emit(Loading_favorite_state());
    DioHelper.GetData(
      url: FAVORITES,
      token: TOKEN,
    ).then((value) {
      favoritesGetModel = Favorites_get_model.fromJson(value.data);
      emit(Get_favorites_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Get_favorites_Error_State(error.toString()));
    });
  }

  Cart_Model? cartModel;

  void changeCartStatus(id) {
    cart[id] = !cart[id]!;
    emit(Cart_Change_Loading_State());
    DioHelper.postData(
      url: CARTS,
      data: {'product_id': id},
      token: TOKEN,
    ).then((value) {
      cartModel = Cart_Model.fromJson(value.data);
      if (!cartModel!.status!) {
        cart[id] = !cart[id]!;
      } else {
        getCart();
      }
      emit(Cart_Change_Success_State(cartModel!));
    }).catchError((error) {
      cart[id] = !cart[id]!;
      emit(Cart_Change_Error_State());
    });
  }

  Cart_Get_Model? cartGetModel;
  void getCart() {
    emit(Cart_Get_Loading_State());
    DioHelper.GetData(
      url: CARTS,
      token: TOKEN,
    ).then((value) {
      cartGetModel = Cart_Get_Model.fromJson(value.data);
      emit(Cart_Get_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Cart_Get_Error_State());
    });
  }

  Post_Order_Model? post_order_model;
  void Post_Order() {
    emit(Order_postOrder_Loading_State());
    DioHelper.postData(
      url: ORDERS,
      data: {
        'address_id': 1,
        'payment_method': 1,
        'use_points': false,
      },
      token: TOKEN,
    ).then((value) {
      post_order_model = Post_Order_Model.fromJson(value.data);
      print(post_order_model!.data!.total);
      print(post_order_model!.data!.paymentMethod);
      cartGetModel!.data!.cartItems!.clear();
      //favorites.clear();
      getHomeData();
      getCart();
      emit(Order_postOrder_Success_State());
    }).catchError((error) {
      emit(Order_postOrder_Error_State());
    });
  }

  Post_Address_Model? post_address_model;
  void Post_Address({
    required String addressName,
    required String city,
    required String region,
    required String streetANDbuilding,
  }) {
    emit(postAddress_Loading_State());
    DioHelper.postData(
      url: ADDRESSES,
      data: {
        "name": addressName,
        "city": city,
        "region": region,
        "details": streetANDbuilding,
        "notes": "nnnnnnn",
        "latitude": "00000000",
        "longitude": "00000000",
      },
      token: TOKEN,
    ).then((value) {
      post_address_model = Post_Address_Model.fromJson(value.data);
      emit(postAddress_Success_State(post_address_model!));
    }).catchError((error) {
      emit(postAddress_Error_State());
    });
  }

  Get_Address_Model? get_address_model;
  void Get_Address() {
    emit(GetAddress_Loading_State());
    DioHelper.GetData(
      url: ADDRESSES,
      token: TOKEN,
    ).then((value) {
      get_address_model = Get_Address_Model.fromJson(value.data);
      emit(GetAddress_Success_State(get_address_model!));
      //print(get_address_model!.data!.data!.length);
    }).catchError((error) {
      print(error.toString());
      emit(GetAddress_Error_State());
    });
  }

  LoginModel? Settings_LoginMOdel;
  void getProfile() {
    emit(Settings_lodingGetProfile_State());
    DioHelper.GetData(
      url: PROFILE,
      token: TOKEN,
    ).then((value) {
      Settings_LoginMOdel = LoginModel.fromJson(value.data);
      print(Settings_LoginMOdel!.data!.name);
      emit(Settings_succsessGetProfile_State());
    }).catchError((error) {
      emit(Settings_errorGetProfile_State());
    });
  }

  Update_Profile_Model? update_profile_model;
  void Update_Profile({
    required String userName,
    required String emailAddress,
    required String phoneNumber,
  }) {
    emit(UpdateProfile_Loading_State());
    DioHelper.putdata(
      url: Update_My_Profile,
      token: TOKEN,
      data: {
        'name': userName,
        'email': emailAddress,
        'phone': phoneNumber,
      },
    ).then((value) {
      update_profile_model = Update_Profile_Model.fromJson(value.data);
      getProfile();
      emit(UpdateProfile_Success_State(update_profile_model!));
    }).catchError((error) {
      emit(UpdateProfile_Error_State());
    });
  }

  Post_Address_Model? Update_My_address_model;
  void Update_My_Address({
    required String addressName,
    required String city,
    required String region,
    required String streetANDbuilding,
  }) {
    emit(UpdateAddress_Loading_State());
    DioHelper.putdata(
      url: Update_Address_URL,
      data: {
        "name": addressName,
        "city": city,
        "region": region,
        "details": streetANDbuilding,
        "latitude": "00000000",
        "longitude": "00000000",
        "notes": "nnnnnnn",
      },
      token: TOKEN,
    ).then((value) {
      post_address_model = Post_Address_Model.fromJson(value.data);
      emit(UpdateAddress_Success_State(post_address_model!));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateAddress_Error_State());
    });
  }

  Get_Orders_Model? get_orders_model;
  void Get_Orders() {
    emit(GetOrder_Loading_State());
    DioHelper.GetData(
      url: ORDERS,
      token: TOKEN,
    ).then((value) {
      get_orders_model = Get_Orders_Model.fromJson(value.data);
      emit(GetOrder_Success_State(get_orders_model!));
    }).catchError((error) {
      emit(GetOrder_Error_State());
    });
  }

  Post_Complaint_Model? post_complaint_model;
  void Post_Complaint({
    required String name,
    required String phone,
    required String email,
    required String message,
  }) {
    emit(Complaint_Loading_State());
    DioHelper.postData(
            url: COMPLAINTS,
            data: {
              "name": name,
              "phone": phone,
              "email": email,
              "message": message,
            },
            token: TOKEN)
        .then((value) {
      post_complaint_model = Post_Complaint_Model.fromJson(value.data);
      emit(Complaint_Success_State(post_complaint_model!));
      print(post_complaint_model!.message);
    }).catchError((error) {
      emit(Complaint_Error_State());
    });
  }

  QA_Model? qa_model;
  void Get_FAQs() {
    emit(FAQs_Loading_State());
    DioHelper.GetData(
      url: FAQs,
      token: TOKEN,
    ).then((value) {
      qa_model = QA_Model.fromJson(value.data);
      emit(FAQs_Success_State());
    }).catchError((error) {
      emit(FAQs_Error_State());
    });
  }

  AboutUs_Model? aboutUs_Model;
  void Get_AboutUs() {
    emit(AboutUs_Loading_State());
    DioHelper.GetData(
      url: ABOUT_US,
    ).then((value) {
      aboutUs_Model = AboutUs_Model.fromJson(value.data);
      emit(AboutUs_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(AboutUs_Error_State());
    });
  }

  Contacts_Model? contacts_model;
  void Get_Contacts() {
    emit(Contacts_Loading_State());
    DioHelper.GetData(
      url: CONTACTS,
    ).then((value) {
      aboutUs_Model = AboutUs_Model.fromJson(value.data);
      emit(Contacts_Success_State());
    }).catchError((error) {
      emit(Contacts_Error_State());
    });
  }

  bool isShow = true;

  void Change_Password_Eye() {
    isShow = !isShow;
    emit(Register_ChagnePasswordIcon_State());
  }

  LoginModel? RegisterModel;

  void Post_Register({
    required String userName,
    required String emailAddress,
    required String password,
    required String phoneNumber,
  }) {
    emit(Register_Loading_State());
    DioHelper.postData(
      url: REGISTER,
       data: {
      'name': userName,
      'email': emailAddress,
      'password': password,
      'phone': phoneNumber,
    }).then((value) {
      RegisterModel = LoginModel.fromJson(value.data);
      emit(Register_Success_State(RegisterModel!));
    }).catchError((error) {
      print(error != null ? error.toString() : null);
      emit(Register_Error_State());
    });
  }

  int activeSlide = 0;
  void Change_Page_ProductDetials(index) {
    activeSlide = index;
    emit(OnPageChanged_ProductDetails_State());
  }
}
