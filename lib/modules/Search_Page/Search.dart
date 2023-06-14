import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/Search_Cubit/Search_Cubit.dart';
import '../../layout/Search_Cubit/Search_States.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../shared/componants/componants.dart';

class Search_Page extends StatelessWidget {
  var SearchController = TextEditingController();
  var Form_Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Search_Cubit(),
      child: BlocConsumer<Search_Cubit, Search_States>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: Form_Key,
              child: Column(
                children: [
                  TextFormField(
                    controller: SearchController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Search for anything";
                      }
                      return null;
                    },
                    onFieldSubmitted: (text) {
                      //print("ok");
                      Search_Cubit.get(context).Get_Search_Resualts(text);
                    },
                    decoration: const InputDecoration(
                      label: Text("Search"),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is Loading_Search_State) LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is Success_Search_State)
                    Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                Product_Item_Builder(
                                  model: Search_Cubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data![index],
                                  context: context,
                                  isdiscont: false,
                                  // information_done: false,
                                  // images: ShopApp_Cubit.get(context)
                                  //     .homepage_model!
                                  //     .data!
                                  //     .products![index]
                                  //     .images!
                                ),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: Search_Cubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
