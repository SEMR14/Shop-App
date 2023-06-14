import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../shared/componants/componants.dart';

class Languages_Screen extends StatelessWidget {
  const Languages_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: default_IconButton(
          function: () {
            Navigator.pop(context);
          },
          iconData: Icons.arrow_back_ios,
        ),
        title: const Text(
          'Languages',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_box,
                  size: 22.5,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'English',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
