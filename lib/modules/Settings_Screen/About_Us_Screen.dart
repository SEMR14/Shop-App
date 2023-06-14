import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/ShopAppCubit/Cubit.dart';
import '../../layout/ShopAppCubit/States.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';

class About_Us_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopApp_Cubit Cubit = ShopApp_Cubit.get(context);
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
                  'About Us',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                // condition: state is AboutUs_Success_State &&
                //     state is Contacts_Success_State,
                // condition: Cubit.aboutUs_Model!.data!.about != null &&
                //     Cubit.contacts_model!.data!.data != null,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 425,
                          width: double.infinity,
                          child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lo',
                            //'${Cubit.aboutUs_Model!.data!.terms}',
                            maxLines: 18,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Contect with us', //'${ShopApp_Cubit.get(context).aboutUs_Model!.data!.about}',

                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Column(
                              children: [
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    Sub_Network_Image,
                                  ),
                                  radius: 35,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  width: 100,
                                  child: const Center(
                                    child: Text(
                                      // Cubit.contacts_model!.data!
                                      //     .data![index].value!,
                                      'C',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 15,
                            ),
                            itemCount: 8,
                            // Cubit
                            //     .contacts_model!
                            //     .data!
                            //     .data!
                            //     .length
                          ),
                        ),
                        Center(
                          child: Text(
                            'Developed by ...',
                            style: TextStyle(
                              fontSize: 17.5,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ]),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ));
  }
}
