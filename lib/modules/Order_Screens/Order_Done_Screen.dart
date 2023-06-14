import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../layout/Shop_Layout/Shop_Layout.dart';
import '../../shared/componants/componants.dart';

class Order_Done_Screen extends StatelessWidget {
  const Order_Done_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 90,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 150,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Thank you for you purchase',
              style: TextStyle(
                fontSize: 22.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            IconButton(
                onPressed: () {
                  NavigatToAndFinish(
                      context: context, NextScreen: Shop_Layout());
                },
                icon: const Icon(
                  Icons.home_outlined,
                  size: 40,
                  color: Colors.blue,
                ))
          ],
        ),
      ),
    );
  }
}
