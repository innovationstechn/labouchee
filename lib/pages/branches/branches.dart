import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/pages/branches/branches_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Branches extends StatelessWidget {
  const Branches({Key? key}) : super(key: key);

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
            customRow(Icons.home, branch.name ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.phone, branch.contactNo ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.phone, branch.whatsapp ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.watch_later_outlined, branch.timing ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.email, branch.email ?? ""),
            const SizedBox(
              height: 5,
            ),
            customRow(Icons.pin_drop, branch.address ?? ""),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(IconData icon, String title) {
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
          text: title,
          fontSize: 12.sp,
          maxLines: 2,
        )),
      ],
    );
  }
}
