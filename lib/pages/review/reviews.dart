import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product_review.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/reviews_ui.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key,required this.reviewsModel}) : super(key: key);
  final List<ProductReviewModel> reviewsModel;
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {


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
              itemCount: widget.reviewsModel.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ReviewUI(
                      image: widget.reviewsModel[index].avatar,
                      name: widget.reviewsModel[index].name,
                      date: widget.reviewsModel[index].createdAt.toString(),
                      comment: widget.reviewsModel[index].review,
                      rating: 5,
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
