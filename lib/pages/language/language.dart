import 'package:flutter/material.dart';
import 'package:labouchee/pages/language/language_viewmodel.dart';
import 'package:labouchee/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageView extends StatefulWidget {
  String nextPage;

  LanguageView({Key? key, required this.nextPage}) : super(key: key);

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  int? radioButtonValue;
  String? language;

  @override
  Widget build(BuildContext context) {
    language = Localizations.localeOf(context).toString();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text("Select Language"),
        ),
        body: ViewModelBuilder<LanguageVM>.reactive(
          viewModelBuilder: () => LanguageVM(),
          builder: (context, languageVM, _) {
            radioButtonValue = language == "en" ? 1 : 0;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/images/flags/sa_flag.jpg",
                      ),
                    ),
                    trailing: Radio(
                      value: 0,
                      groupValue: radioButtonValue,
                      onChanged: (int) => update(languageVM, 'ar'),
                    ),
                    title: const Text("Arabic"),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/images/flags/us_flag.jpg",
                      ),
                    ),
                    trailing: Radio(
                      value: 1,
                      groupValue: radioButtonValue,
                      onChanged: (int) => update(languageVM, 'en'),
                    ),
                    title: const Text("English"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    // padding: EdgeInsets.symmetric(vertical: 5),
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    text: AppLocalizations.of(context)!.submit,
                    size: Size(80.w, 7.h),
                    textFontSize: 12.sp,
                    onTap: () => languageVM.languageSelection(language!, widget.nextPage),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void update(LanguageVM languageVM, String language) {
    this.language = language;
    languageVM.update();
  }
}
