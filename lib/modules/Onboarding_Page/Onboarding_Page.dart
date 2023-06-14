import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/componants/componants.dart';
import '../../shared/network/local/ChcheHelper.dart';
import '../Login_Screen/Login_Screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class Onboarding_page extends StatefulWidget {
  @override
  State<Onboarding_page> createState() => _Onboarding_pageState();
}

class _Onboarding_pageState extends State<Onboarding_page> {
  bool islast = false;

  var BoardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX24880446.jpg',
      title: 'Let\'s go to see our hot offers',
      body: 'Let\'s go to see our hot offers Let\'s go to see our hot offers'
          'Let\'s go to see our hot offers Let\'s go to see our hot offers',
    ),
    BoardingModel(
      image: 'https://www.shutterstock.com/image-vector/happy-family-enjoys-shopping-cartoon-260nw-767921632.jpg',
      title: 'About us',
      body: 'About us About us About us About us About us About us About us'
          'About us About us About us About us About us About us About us',
    ),
    BoardingModel(
      image: 'https://static.vecteezy.com/system/resources/previews/004/786/659/original/illustration-of-a-young-guy-with-purchases-positive-flat-illustration-in-cartoon-style-discounts-and-sales-shopaholic-shopping-a-young-man-talking-on-the-phone-shopping-vector.jpg',
      title: 'Thx for downloading the App',
      body:
          'Thank you for downloading our App Thank you for downloading our  App'
          'Thank you for downloading our App Thank you for downloading our App ',
    ),
  ];

  void submit() {
    CacheHelper.SaveData(
      key: 'onboarding',
      value: true,
    ).then((value) {
      if (value) {
        NavigatToAndFinish(context: context, NextScreen: Login_Screen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: BoardingController,
                itemBuilder: (context, index) => item(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    //print('Last Screen');
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
              ),
            ),
           Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: islast ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
          onPressed: () {
            if (islast == true) {
                      submit();
                    } else {
                      BoardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.linear,
                      );
                    }
          },
          child: const Text(
            'Continue',
            style:  TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
    ),
    const SizedBox(
      height: 15,
    ),
    Center(
      child: SmoothPageIndicator(
                    controller: BoardingController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 7.5,
                      spacing: 5,
                      expansionFactor: 3,
                    ),
                  ),
    ),
    const SizedBox(
      height: 20,
    ),
          ],
        ),
      ),
    );
  }

  Widget item(BoardingModel m) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(
              '${m.image}',
            ),
            height: 250,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${m.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${m.body}',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      );
}
