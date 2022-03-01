import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/reviews_ui.dart';

class ReviewModel {
  String? image, name, date, comment;
  double? rating;

  ReviewModel({this.image, this.date, this.name, this.comment, this.rating});
}

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final List<ReviewModel> reviewModel = [
    ReviewModel(
      image: "assets/images/flags/sa_flags.jpg",
      name: "Umer",
      date: "dasa",
      comment: "asjkdaskjdasjkdjaksdkjasdkhasdhkaskdh",
      rating: 4,
    ),
    ReviewModel(
      image: "assets/images/flags/sa_flags.jpg",
      name: "Umer",
      date: "dasa",
      comment: "asjkdaskjdasjkdjaksdkjasdkhasdhkaskdh",
      rating: 4,
    ),
    ReviewModel(
      image: "assets/images/flags/sa_flags.jpg",
      name: "Umer",
      date: "dasa",
      comment: "asjkdaskjdasjkdjaksdkjasdkhasdhkaskdh",
      rating: 4,
    ),
    ReviewModel(
      image: "assets/images/flags/sa_flags.jpg",
      name: "Umer",
      date: "dasa",
      comment: "asjkdaskjdasjkdjaksdkjasdkhasdhkaskdh",
      rating: 4,
    ),
    ReviewModel(
      image: "assets/images/flags/sa_flags.jpg",
      name: "Umer",
      date: "dasa",
      comment: "asjkdaskjdasjkdjaksdkjasdkhasdhkaskdh",
      rating: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title:'Reviews'),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "REVIEWS",
              padding: EdgeInsets.all(10),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: reviewModel.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ReviewUI(
                      image: reviewModel[index].image,
                      name: reviewModel[index].name,
                      date: reviewModel[index].date,
                      comment: reviewModel[index].comment,
                      rating: reviewModel[index].rating,
                      onPressed: () => print("More Action $index"),
                      onTap: () => setState(() {}),
                      isLess: false,
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.black12,
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
