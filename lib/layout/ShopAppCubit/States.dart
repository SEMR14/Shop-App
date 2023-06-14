

import '../../models/Cart_model.dart';
import '../../models/FavoriteModel.dart';
import '../../models/Get_Address_Model.dart';
import '../../models/Get_Orders_Model.dart';
import '../../models/Post_Address_Model.dart';
import '../../models/Post_Complaint_Model.dart';
import '../../models/Update_Profile_Model.dart';
import '../../models/loginmodel.dart';

abstract class ShoopApp_States {}

class Intial_ShoopApp_States_State extends ShoopApp_States {}

class Change_Screens_State extends ShoopApp_States {}

class Change_NavigatBar_State extends ShoopApp_States {}

class Home_Loading_State extends ShoopApp_States {}

class Home_Success_State extends ShoopApp_States {}

class Home_Error_State extends ShoopApp_States {
  final String error;
  Home_Error_State(this.error);
}

class Categories_Success_State extends ShoopApp_States {}

class Categories_Error_State extends ShoopApp_States {
  final String error;
  Categories_Error_State(this.error);
}

class Change_Favorite_Success_State extends ShoopApp_States {
  final favorite_model model;
  Change_Favorite_Success_State(this.model);
}

class Favorite_Success_State extends ShoopApp_States {}

class Favorite_Error_State extends ShoopApp_States {
  final String error;
  Favorite_Error_State(this.error);
}

class Get_favorites_Success_State extends ShoopApp_States {}

class Get_favorites_Error_State extends ShoopApp_States {
  final String Error;
  Get_favorites_Error_State(this.Error);
}

class Loading_favorite_state extends ShoopApp_States {}

class Loading_Categories_state extends ShoopApp_States {}

class Cart_Change_Loading_State extends ShoopApp_States {}

class Cart_Change_Success_State extends ShoopApp_States {
  final Cart_Model cartModel;
  Cart_Change_Success_State(this.cartModel);
}

class Cart_Change_Error_State extends ShoopApp_States {}

class Cart_Get_Loading_State extends ShoopApp_States {}

class Cart_Get_Success_State extends ShoopApp_States {}

class Cart_Get_Error_State extends ShoopApp_States {}

class Order_postOrder_Loading_State extends ShoopApp_States {}

class Order_postOrder_Success_State extends ShoopApp_States {}

class Order_postOrder_Error_State extends ShoopApp_States {}

class postAddress_Loading_State extends ShoopApp_States {}

class postAddress_Success_State extends ShoopApp_States {
  final Post_Address_Model post_address_model;
  postAddress_Success_State(this.post_address_model);
}

class postAddress_Error_State extends ShoopApp_States {}

class GetAddress_Loading_State extends ShoopApp_States {}

class GetAddress_Success_State extends ShoopApp_States {
  final Get_Address_Model get_address_model;
  GetAddress_Success_State(this.get_address_model);
}

class GetAddress_Error_State extends ShoopApp_States {}

class Settings_lodingGetProfile_State extends ShoopApp_States {}

class Settings_succsessGetProfile_State extends ShoopApp_States {}

class Settings_errorGetProfile_State extends ShoopApp_States {}

class Suffix_Icon_State extends ShoopApp_States {}

class post_login_success_state extends ShoopApp_States {
  final LoginModel loginmodel;

  post_login_success_state(this.loginmodel);
}

class post_login_error_state extends ShoopApp_States {
  final String error;
  post_login_error_state(this.error);
}

class post_login_loding_state extends ShoopApp_States {}

class UpdateProfile_Loading_State extends ShoopApp_States {}

class UpdateProfile_Success_State extends ShoopApp_States {
  final Update_Profile_Model update_profile_model;
  UpdateProfile_Success_State(this.update_profile_model);
}

class UpdateProfile_Error_State extends ShoopApp_States {}

class UpdateAddress_Loading_State extends ShoopApp_States {}

class UpdateAddress_Success_State extends ShoopApp_States {
  final Post_Address_Model Update_My_Address;
  UpdateAddress_Success_State(this.Update_My_Address);
}

class UpdateAddress_Error_State extends ShoopApp_States {}

class GetOrder_Loading_State extends ShoopApp_States {}

class GetOrder_Success_State extends ShoopApp_States {
  final Get_Orders_Model get_orders_model;
  GetOrder_Success_State(this.get_orders_model);
}

class GetOrder_Error_State extends ShoopApp_States {}

class Complaint_Loading_State extends ShoopApp_States {}

class Complaint_Success_State extends ShoopApp_States {
  final Post_Complaint_Model post_complaint_model;
  Complaint_Success_State(this.post_complaint_model);
}

class Complaint_Error_State extends ShoopApp_States {}

class FAQs_Loading_State extends ShoopApp_States {}

class FAQs_Success_State extends ShoopApp_States {}

class FAQs_Error_State extends ShoopApp_States {}

class AboutUs_Loading_State extends ShoopApp_States {}

class AboutUs_Success_State extends ShoopApp_States {}

class AboutUs_Error_State extends ShoopApp_States {}

class Contacts_Loading_State extends ShoopApp_States {}

class Contacts_Success_State extends ShoopApp_States {}

class Contacts_Error_State extends ShoopApp_States {}

class Register_ChagnePasswordIcon_State extends ShoopApp_States {}

class Register_Loading_State extends ShoopApp_States {}

class Register_SuccessIsNotLogin_State extends ShoopApp_States {
  LoginModel loginModel;
  Register_SuccessIsNotLogin_State(this.loginModel);
}

class Register_Error_State extends ShoopApp_States {}

class OnPageChanged_ProductDetails_State extends ShoopApp_States {}

class Register_Success_State extends ShoopApp_States {
  LoginModel loginModel;
  Register_Success_State(this.loginModel);
}
