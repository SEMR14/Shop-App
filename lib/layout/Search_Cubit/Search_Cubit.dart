import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Search_model.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/network/DioHelper.dart';
import 'Search_States.dart';

class Search_Cubit extends Cubit<Search_States> {
  Search_Cubit() : super(Intial_Search_State());

  static Search_Cubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Get_Search_Resualts(text) {
    emit(Loading_Search_State());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: TOKEN,
    ).then((value) {
      print("Done");
      searchModel = SearchModel.fromJson(value.data);
      //print(searchModel!.data!.data!.length);
      emit(Success_Search_State());
    }).catchError((error) {
      print(error);
      emit(Error_Search_State());
    });
  }
}
