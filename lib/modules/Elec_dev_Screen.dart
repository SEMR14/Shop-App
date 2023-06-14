import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/ShopAppCubit/Cubit.dart';
import '../layout/ShopAppCubit/States.dart';
import '../shared/componants/componants.dart';

class Elect_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopApp_Cubit, ShoopApp_States>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
                appBar: AppBar(
              leading: default_IconButton(
                function: () {
                  Navigator.pop(context);
                },
                iconData: Icons.arrow_back_ios,
              ),
              title: const Text(
                'Electrionci devices',
                style: TextStyle(color: Colors.black),
              ),
            )));
  }
}
