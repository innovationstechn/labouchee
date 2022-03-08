import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:labouchee/pages/product_details/product_details_viewmodel.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/product_review.dart';
import '../../product_card.dart';
import '../../services/navigator.dart';
import '../../widgets/reviews_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductDetailPage extends StatefulWidget {
  final int selectedIndex;
  final List<ProductModel> similarProducts;

  const ProductDetailPage(
      {Key? key, required this.selectedIndex, required this.similarProducts})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _navigationService = locator<NavigatorService>();
  ProductModel? selectedItem;
  String? selectedSize = "SMALL";
  int quantitySelected = 1;
  int? selectedImageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = widget.similarProducts[widget.selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailsVM>.reactive(
      viewModelBuilder: () => ProductDetailsVM(product: selectedItem!),
      onModelReady: (model) async {
        await model.loadDetails();
        selectedSize = model.details.availableSizes!.size;
      },
      builder: (context, productDetailsVM, _) {
        return Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            if (productDetailsVM.isBusy) {
              return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              );
            }
            return Stack(
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.35,
                  child: SizedBox.expand(
                    child: Image.network(
                      productDetailsVM.details.images![selectedImageIndex!],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SlidingUpPanel(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  maxHeight: constraints.maxHeight * 0.7,
                  minHeight: constraints.maxHeight * 0.7,
                  panel: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              imageCards(constraints, 0, productDetailsVM),
                              const SizedBox(width: 10),
                              imageCards(constraints, 1, productDetailsVM),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: productDetailsVM.details.name,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              // Icon(
                              //   Icons.favorite,
                              //   size: 15.sp,
                              //   color: Colors.redAccent,
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: productDetailsVM.details.category ?? "",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              priceTag(productDetailsVM)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                fontWeight: FontWeight.bold,
                                text: AppLocalizations.of(context)?.description,
                                fontSize: 13.sp,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  fontSize: 12.sp,
                                  maxLines: 100,
                                  text: productDetailsVM.details.description),
                            ],
                          ),
                          Container(
                              margin: const EdgeInsetsDirectional.only(
                                  bottom: 20, top: 10),
                              child: productSizeWidget(
                                  constraints, productDetailsVM)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                size: Size(constraints.maxWidth * 0.5,
                                    constraints.maxWidth * 0.1),
                                onTap: () => productDetailsVM.addToCart(
                                  quantitySelected,
                                  selectedSize,
                                ),
                                text: AppLocalizations.of(context)?.addToCart,
                                textColor: Colors.white,
                                buttonColor: Theme.of(context).primaryColor,
                              ),
                              numberOfItems(constraints, productDetailsVM),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildReviewCard(
                              constraints,
                              productDetailsVM.productReviews,
                              productDetailsVM),
                          buildSimilarProudcts(constraints)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget productSizeWidget(
      BoxConstraints constraints, ProductDetailsVM productDetailsVM) {
    if (productDetailsVM.details.price != null) {
      String? size = "STANDARD";
      if (productDetailsVM.details.priceSmall != null) size = 'SMALL';
      if (productDetailsVM.details.priceMedium != null) size = 'MEDIUM';
      if (productDetailsVM.details.priceLarge != null) size = 'LARGE';

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CustomText(
              text: AppLocalizations.of(context)?.availableSize,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: size,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppLocalizations.of(context)?.availableSizes,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (productDetailsVM.details.priceSmall != null)
              productSize(constraints, "SMALL", productDetailsVM),
            if (productDetailsVM.details.priceMedium != null)
              productSize(constraints, "MEDIUM", productDetailsVM),
            if (productDetailsVM.details.priceLarge != null)
              productSize(constraints, "LARGE", productDetailsVM),
          ],
        ),
      ],
    );
  }

  Widget productSize(BoxConstraints constraints, String? text,
      ProductDetailsVM productDetailsVM) {
    bool isSelected = text == selectedSize;
    return GestureDetector(
      onTap: () {
        selectedSize = text;
        productDetailsVM.notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black12,
          ),
        ),
        margin: const EdgeInsetsDirectional.only(start: 10),
        width: constraints.maxWidth * 0.25,
        height: constraints.maxWidth * 0.08,
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget numberOfItems(
      BoxConstraints constraints, ProductDetailsVM productDetailsVM) {
    return Row(
      children: [
        Container(
          height: constraints.maxWidth * 0.1,
          width: constraints.maxWidth * 0.1,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).primaryColor),
          child: Center(
            child: InkWell(
              child: const Icon(Icons.add, color: Colors.white),
              onTap: () {
                quantitySelected++;
                productDetailsVM.notifyListeners();
              },
            ),
          ),
        ),
        CustomText(
          color: Colors.black,
          text: quantitySelected.toString(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Container(
          height: constraints.maxWidth * 0.1,
          width: constraints.maxWidth * 0.1,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).primaryColor),
          child: Center(
            child: InkWell(
              // alignment: Alignment.center,
              child: const Icon(Icons.remove, color: Colors.white),
              onTap: () {
                if (quantitySelected > 0) {
                  quantitySelected--;
                  productDetailsVM.notifyListeners();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget priceTag(ProductDetailsVM productDetailsVM) {
    double? price;

    if (productDetailsVM.details.price != null) {
      price = productDetailsVM.details.price!;
    } else {
      switch (selectedSize) {
        case 'SMALL':
          price = productDetailsVM.details.priceSmall!;
          break;
        case 'MEDIUM':
          price = productDetailsVM.details.priceMedium!;
          break;
        case 'LARGE':
          price = productDetailsVM.details.priceLarge!;
          break;
      }
    }

    return CustomText(
      text: price.toString()+" "+AppLocalizations.of(context)!.currency,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
  }

  Widget imageCards(BoxConstraints constraints, int index,
      ProductDetailsVM productDetailsVM) {
    return GestureDetector(
      onTap: () {
        selectedImageIndex = index;
        productDetailsVM.notifyListeners();
      },
      child: Container(
          width: constraints.maxWidth * 0.25,
          height: constraints.maxWidth * 0.2,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: selectedImageIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey)),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: SizedBox.expand(
              child: Image.network(
                productDetailsVM.details.images![index],
                fit: BoxFit.fill,
              ),
            ),
          )),
    );
  }

  Widget buildReviewCard(BoxConstraints boxConstraints,
      List<ProductReviewModel> reviews, ProductDetailsVM productDetailsVM) {
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
              rating: 4,
              onPressed: () => print("More Action $index"),
              onTap: () => setState(() {
                // isMore = !isMore;
              }),
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
            onTap: () => _showRatingAppDialog(boxConstraints, productDetailsVM),
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
        child: Container(
          height: boxConstraints.maxHeight * 0.53,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: boxConstraints.maxHeight * 0.2,
                child: SizedBox.expand(
                  child: Image.network(
                    widget.similarProducts[widget.selectedIndex].images!
                        .elementAt(0),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              CustomText(
                text: AppLocalizations.of(context)?.title,
                fontSize: 14.sp,
                padding: EdgeInsets.symmetric(vertical: 10),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text:
                AppLocalizations.of(context)?.tapAStar,
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
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  Widget buildSimilarProudcts(BoxConstraints boxConstraints) {
    double boxHeight =
        boxConstraints.maxHeight * 0.65 > boxConstraints.maxWidth * 0.4
            ? boxConstraints.maxWidth * 0.5
            : boxConstraints.maxHeight * 0.65;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppLocalizations.of(context)?.similarProducts,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: boxHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.similarProducts.length,
            itemBuilder: (context, index) {
              return index == widget.selectedIndex
                  ? Container()
                  : Container(
                      width: boxConstraints.maxWidth * 0.4,
                      padding: const EdgeInsetsDirectional.only(end: 10),
                      child: GestureDetector(
                        onTap: () {
                          _navigationService.router.popAndPush(
                            ProductScreenRoute(
                                selectedIndex: index,
                                similarProducts: widget.similarProducts),
                          );
                        },
                        child: ProductCard(
                          disableOnTap: true,
                          isSmall: false,
                          selectedItemIndex: index,
                          similarModel: widget.similarProducts,
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
