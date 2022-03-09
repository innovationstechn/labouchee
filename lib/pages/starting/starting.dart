import 'package:flutter/cupertino.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/pages/categories_listing/categories_listing.dart';
import 'package:labouchee/pages/landing/home_view.dart';
import 'package:labouchee/pages/my_orders/my_orders.dart';
import 'package:labouchee/pages/starting/starting_viewmodel.dart';
import 'package:labouchee/widgets/custom_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_text.dart';
import '../cart/cart.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../notifications/notifications.dart';
import '../searchbar/searchbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  int _currentIndex = 0;
  late PageController _pageController;
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final navigationService = locator<NavigatorService>();

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/images/flags/logo.png"),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    color: Colors.black,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.language,
                  color: primaryColor,
                ),
                onPressed: () => navigationService.router.navigate(
                  LanguageScreenRoute(nextPage: StartingScreenRoute()),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
                child: IconButton(
                  icon:Icon(Icons.shopping_cart),
                  color: primaryColor,
                  onPressed: (){
                    _pageController.jumpToPage(2);
                    _advancedDrawerController.hideDrawer();
                  },
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10)),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                LandingView(),
                SearchBar(),
                Cart(),
                Notifications()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                  title: CustomText(text:AppLocalizations.of(context)?.home,),
                  icon: const Icon(Icons.home)),
              BottomNavyBarItem(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                  title: CustomText(text:AppLocalizations.of(context)?.search),
                  icon: const Icon(Icons.search)),
              BottomNavyBarItem(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                  title: CustomText(text:AppLocalizations.of(context)?.cart,),
                  icon: const Icon(Icons.shopping_cart)),
              BottomNavyBarItem(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                  title: CustomText(text:AppLocalizations.of(context)?.notifications),
                  icon: const Icon(Icons.notifications)),
            ],
          ),
        ),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            children: [
              ViewModelBuilder<StartingStreamVM>.reactive(
                viewModelBuilder: () => StartingStreamVM(),
                onModelReady: (model) => model.refresh(),
                builder: (context, startingVM, _) {
                  if (startingVM.isBusy) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  }

                  if (startingVM.hasError || startingVM.data == null) {
                    return const Icon(Icons.error);
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 128.0,
                        height: 128.0,
                        margin: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 20.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(startingVM.data!.avatar!,fit: BoxFit.fill,),
                      ),
                      CustomText(
                        text: startingVM.data!.name,
                        color:Colors.white,
                        fontSize:12.sp,
                        fontWeight:FontWeight.bold,
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      CustomText(
                        text: startingVM.data!.email,
                        color:Colors.white,
                        fontSize:12.sp,
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                    ],
                  );
                },
              ),
              ListTile(
                onTap: () => navigationService.router
                    .navigate(const ProfileScreenRoute()),
                leading: const Icon(Icons.account_circle_rounded),
                title: CustomText(text:AppLocalizations.of(context)?.profile,color: Colors.white,),
              ),
              ListTile(
                onTap: () {
                  _pageController.jumpToPage(2);
                  _advancedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.shopping_cart),
                title: CustomText(text:AppLocalizations.of(context)?.cart,color: Colors.white,),
              ),
              ListTile(
                onTap: () {
                  navigationService.router.navigateNamed('/my-orders');
                },
                leading: const Icon(Icons.receipt_long_outlined),
                title: CustomText(text:AppLocalizations.of(context)?.myOrders,color: Colors.white,),
              ),
              ListTile(
                onTap: () =>
                    navigationService.router.navigate(BranchesScreenRoute()),
                leading: const Icon(Icons.description),
                title: CustomText(text:AppLocalizations.of(context)?.branches,color: Colors.white,),
              ),
              ListTile(
                onTap: () {
                  navigationService.router
                      .navigate(CustomerSupportScreenRoute());
                },
                leading: const Icon(Icons.message),
                title: CustomText(text:AppLocalizations.of(context)?.inquiryForm,color: Colors.white,),
              ),
              ListTile(
                onTap: () {
                  navigationService.router
                      .navigate(CouponsSupportScreenRoute());
                },
                leading: const Icon(Icons.card_giftcard),
                title: CustomText(text:AppLocalizations.of(context)?.coupons,color: Colors.white,),
              ),
              ListTile(
                onTap: () {
                  navigationService.router.navigate(
                    LanguageScreenRoute(
                      nextPage: StartingScreenRoute(),
                    ),
                  );
                },
                leading: const Icon(Icons.language),
                title: CustomText(text:AppLocalizations.of(context)?.languages,color: Colors.white,),
              ),
              ViewModelBuilder<StartingStreamVM>.reactive(
                viewModelBuilder: () => StartingStreamVM(),
                onModelReady: (model) => model.refresh(),
                builder: (context, startingVM, _) {
                  return               ListTile(
                    onTap: () {
                      startingVM.logout();
                    },
                    leading: const Icon(Icons.logout),
                    title: CustomText(text:AppLocalizations.of(context)?.logout,color: Colors.white,),
                  );
                }
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
