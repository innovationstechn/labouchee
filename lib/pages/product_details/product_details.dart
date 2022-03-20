import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:labouchee/pages/product_details/product_details_viewmodel.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:labouchee/widgets/product_details_widgets/price_tag.dart';
import 'package:labouchee/widgets/product_details_widgets/product_size.dart';
import 'package:labouchee/widgets/product_details_widgets/review_widget.dart';
import 'package:labouchee/widgets/product_details_widgets/similar_products.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import '../../models/product.dart';
import '../../widgets/custom_cached_image.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
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
  ProductModel? selectedItem;
  String? selectedSize = "SMALL";
  int quantitySelected = 1;
  int? selectedImageIndex = 0;
  ScrollController scrollController = ScrollController();
  PanelController panelController = PanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = widget.similarProducts[widget.selectedIndex];
    WidgetsBinding.instance!
        .addPostFrameCallback((_){
      scrollController.addListener(() {
        if(scrollController.position.pixels> scrollController.position.maxScrollExtent/2){
          panelController.animatePanelToPosition(1.0,duration:Duration(milliseconds:200 ),curve: Curves.linear);
        }else if(scrollController.position.pixels == scrollController.position.minScrollExtent){
          panelController.close();
        }
      });
    });
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
                child: CustomCircularProgressIndicator(),
              );
            }
            return Stack(
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.35,
                  child: CustomCachedImage(
                    image: productDetailsVM.details.images![selectedImageIndex!],
                  ),
                ),
                SlidingUpPanel(
                  backdropEnabled: true,
                  panelSnapping: true,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  maxHeight: constraints.maxHeight*0.85,
                  minHeight: constraints.maxHeight * 0.66,
                  controller: panelController,
                  panel: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                              PriceTag(
                                  productDetailsVM: productDetailsVM,
                                  selectedSize: selectedSize ?? "")
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
                          ProductSize(
                            selectedSize: selectedSize ?? "",
                            productDetailsVM: productDetailsVM,
                            onSizeChanged: (size) {
                              selectedSize = size;
                              productDetailsVM.notifyListeners();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                textFontSize: 14.sp,
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
                          ProductDetailsReviewCard(
                              productDetailsVM: productDetailsVM,
                              similarProducts: widget.similarProducts,
                              selectedIndex: widget.selectedIndex),
                          const SizedBox(
                            height: 10,
                          ),
                          SimilarProducts(
                            similarProducts: widget.similarProducts,
                            selectedIndex: widget.selectedIndex,
                          ),
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
          child:CustomCachedImage(
            image: productDetailsVM.details.images![index],
          )
        ),
      ),
    );
  }
}
