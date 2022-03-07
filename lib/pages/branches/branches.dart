import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/pages/branches/branches_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class Branches extends StatelessWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Branches'),
        body: ViewModelBuilder<BranchesVM>.reactive(
          viewModelBuilder: () => BranchesVM(),
          onModelReady: (model) => model.initialize(),
          builder: (context, branchesVM, _) {
            if (branchesVM.isBusy) {
              return const Center(
                child: CircularProgressIndicator(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.home,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.name!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.contactNo!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.whatsapp!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.timing!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.email!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.pin_drop,
                  size: 17.sp,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: branch.address!, fontSize: 12.sp),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
