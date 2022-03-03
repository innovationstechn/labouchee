import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:labouchee/landing_products_list.dart';
import 'package:labouchee/pages/searchbar/search_viewmodel.dart';
import 'package:labouchee/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'models/product.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchVM>.reactive(
      onModelReady: (model) => model.loadDefault(),
      viewModelBuilder: () => SearchVM(),
      builder: (context, searchVM, __) {

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: SearchTextField(searchVM.search)),
                  ],
                ),
              ),

              if (searchVM.isBusy)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              else
              LandingProductList(items: searchVM.searched),
            ],
          ),
        );
      },
    );
  }

  Widget SearchTextField(void Function(String) onSearch) {
    return TextFormField(
      enableSuggestions: true,
      onChanged: (String? text) {
        if (text != null && text.length > 3) onSearch(text);
      },
      autofocus: true,
      style: TextStyle(color: Colors.black, fontSize: 13.sp),
      decoration: InputDecoration(
        // prefix: const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 5.0),
        //   child: Icon(Icons.search),
        // ),
        hintText: "Search your favourite item",
        // labelText: "Search an item",
        // labelStyle: TextStyle(
        //     color: focusNode!.hasFocus
        //         ? Colors.black
        //         : Theme.of(context!).primaryColor,
        //     fontSize: 13.sp,
        //     fontWeight: FontWeight.w300),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
