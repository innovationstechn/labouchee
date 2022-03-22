import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/landing_products_list.dart';
import 'package:labouchee/pages/searchbar/search_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

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
                const SliverFillRemaining(
                  child: Center(
                    child: CustomCircularProgressIndicator(),
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
      focusNode: FocusNode(),
      style: TextStyle(color: Colors.black, fontSize: 13.sp),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)?.searchYourFavouriteItem,
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
