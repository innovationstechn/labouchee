import 'dart:io';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/pages/branches/branches_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import '../../app/locator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Branches extends StatefulWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  final _snackbarService = locator<SnackbarService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.branches),
        body: ViewModelBuilder<BranchesVM>.reactive(
          viewModelBuilder: () => BranchesVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, branchesVM, _) {
            if (branchesVM.isBusy) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: branchesVM.branches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: branchCard(branchesVM.branches[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget branchCard(BranchModel branch) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            customRow(Icons.home, branch.name ?? "", () {}),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.phone, branch.contactNo ?? "", () {
              openPhone(branch.contactNo ?? "");
            }),
            const SizedBox(
              height: 5,
            ),
            customWhatsappRow(branch.whatsapp ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.watch_later_outlined, branch.timing ?? "", () {}),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.email, branch.email ?? "", () {
              openMail(branch.email ?? "");
            }),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.pin_drop, branch.address ?? "", () {
              openMap(branch.address ?? "");
            }),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(IconData icon, String title, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 17.sp,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
            child: CustomText(
          onTap: () => onTap(),
          text: title,
          fontSize: 12.sp,
          maxLines: 2,
        )),
      ],
    );
  }

  Widget customWhatsappRow(String? phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 17.sp,
            height: 17.sp,
            child: Image.asset(
              'assets/images/flags/whatsapp_icon.png',
              fit: BoxFit.cover,
            )),
        const SizedBox(
          width: 10,
        ),
        Flexible(
            child: CustomText(
          onTap: () => openWhatsapp(phone ?? ""),
          text: phone,
          fontSize: 12.sp,
          maxLines: 2,
        )),
      ],
    );
  }

  openPhone(String phone) async {
    final url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      copyToClipboard(phone);
    }
  }

  openMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      copyToClipboard(googleUrl);
    }
  }

  openMail(String email) async {
    final mailUrl = 'mailto:$email';
    try {
      await launch(mailUrl);
    } catch (e) {
      copyToClipboard(email);
    }
  }

  openWhatsapp(String phoneNo) async {
    var whatsappURlAndroid = "whatsapp://send?phone=" + phoneNo + "&text=Hi";
    var whatsappURLIos = "https://wa.me/$phoneNo?text=${Uri.parse("Hi")}";
    if (Platform.isIOS) {
      if (await canLaunch(whatsappURLIos)) {
        await launch(whatsappURLIos, forceSafariVC: false);
      } else {
        copyToClipboard(phoneNo);
      }
    } else {
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        copyToClipboard(phoneNo);
      }
    }
  }

  copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _snackbarService.showSnackbar(message: "Copied");
  }
}
