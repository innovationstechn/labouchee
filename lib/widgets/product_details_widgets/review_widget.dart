import 'package:flutter/cupertino.dart';
import 'package:labouchee/models/product.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:labouchee/pages/product_details/product_details_viewmodel.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/product_review.dart';
import '../../services/navigator.dart';
import '../../widgets/reviews_ui.dart';
import '../custom_button.dart';
import '../custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsReviewCard extends StatefulWidget {
  final ProductDetailsVM productDetailsVM;
  final List<ProductModel> similarProducts;
  final int selectedIndex;

  const ProductDetailsReviewCard(
      {Key? key,
      required this.productDetailsVM,
      required this.similarProducts,
      required this.selectedIndex})
      : super(key: key);

  @override
  State<ProductDetailsReviewCard> createState() =>
      _ProductDetailsReviewCardState();
}

class _ProductDetailsReviewCardState extends State<ProductDetailsReviewCard> {
  final _navigationService = locator<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return buildReviewCard(boxConstraints, widget.productDetailsVM.productReviews);
    });
  }

  Widget buildReviewCard(BoxConstraints boxConstraints,
      List<ProductReviewModel> reviews) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppLocalizations.of(context)?.reviews,
              padding: EdgeInsets.all(10),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            if (reviews.length > 2)
              CustomText(
                text: AppLocalizations.of(context)?.viewAll,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                onTap: () {
                  _navigationService.router.navigate(
                    ReviewsScreenRoute(
                      reviewsModel: reviews,
                    ),
                  );
                },
              ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          itemCount: reviews.length > 2 ? 2 : reviews.length,
          itemBuilder: (context, index) {
            final review = reviews.elementAt(index);

            return ReviewUI(
              image: review.avatar!,
              name: review.name!,
              date: review.createdAt!.toString(),
              comment: review.review!,
              rating: 5,
              onPressed: () => print("More Action $index"),
              onTap: () {},
              isLess: false,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1.0,
              color: Colors.black12,
            );
          },
        ),
        Center(
          child: CustomButton(
            text: AppLocalizations.of(context)?.addREVIEW,
            onTap: () => _showRatingAppDialog(boxConstraints,widget.productDetailsVM),
            buttonColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  void _showRatingAppDialog(
      BoxConstraints boxConstraints, ProductDetailsVM productDetailsVM) {
    final TextEditingController comment = TextEditingController();
    double? rating = 3;

    final _dialog = AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.expand(
              child: Image.network(
                widget.similarProducts[widget.selectedIndex].images!
                    .elementAt(0),
                fit: BoxFit.fill,
              ),
            ),
            CustomText(
              text: AppLocalizations.of(context)?.title,
              fontSize: 14.sp,
              padding: EdgeInsets.symmetric(vertical: 10),
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: AppLocalizations.of(context)?.tapAStar,
              fontSize: 12.sp,
              maxLines: 3,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              fontWeight: FontWeight.normal,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(0xffDE970B),
              ),
              itemSize: 0.08 * boxConstraints.maxWidth,
              onRatingUpdate: (rate) {
                rating = rate;
              },
            ),
            TextFormField(
                controller: comment,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.comment,
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                )),
            CustomButton(
              onTap: () async {
                if (comment.text.isEmpty) {
                  productDetailsVM.postProductReview("N/A", rating!.toInt());
                } else {
                  productDetailsVM.postProductReview(
                      comment.text, rating!.toInt());
                }
                Navigator.of(context).pop();
              },
              text: AppLocalizations.of(context)?.submit,
              padding: const EdgeInsetsDirectional.only(top: 10),
            )
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
