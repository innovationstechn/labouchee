import 'package:flutter/cupertino.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/pages/categories_listing/categories_listing.dart';
import 'package:labouchee/pages/landing/home_view.dart';
import 'package:labouchee/searchbar.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../../services/navigator.dart';
import '../../widgets/custom_text.dart';
import '../cart/cart.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../notifications/notifications.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  int _currentIndex = 0;
  late PageController _pageController;
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
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
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
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
                  child: Icon(
                    Icons.shopping_cart,
                    color: primaryColor,
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
                  // CategoriesListing(),
                  const Cart(),
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
                    title: const Text('Home'),
                    icon: const Icon(Icons.home)),
                BottomNavyBarItem(
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.grey,
                    title: const Text('Search'),
                    icon: const Icon(Icons.search)),
                BottomNavyBarItem(
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.grey,
                    title: const Text('Cart'),
                    icon: const Icon(Icons.shopping_cart)),
                BottomNavyBarItem(
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.grey,
                    title: const Text('Item Four'),
                    icon: const Icon(Icons.settings)),
              ],
            ),
          )),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                  // child: Image.asset(
                  //   'assets/images/flutter_logo.png',
                  // ),
                  child: const FlutterLogo(),
                ),
                const CustomText(
                  text: "NAME",
                  padding: EdgeInsets.only(bottom: 10),
                ),
                const CustomText(
                    text: "EMAIL", padding: EdgeInsets.only(bottom: 10)),
                ListTile(
                  onTap: () {
                    navigationService.router.navigate(ProfileScreenRoute());
                  },
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Profile'),
                ),
                ListTile(
                  onTap: () {
                    _pageController.jumpToPage(2);
                    _advancedDrawerController.hideDrawer();
                  },
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                ),
                ListTile(
                  onTap: () {
                    navigationService.router.navigate(BranchesScreenRoute());
                  },
                  leading: const Icon(Icons.description),
                  title: const Text('Branches'),
                ),
                ListTile(
                  onTap: () {
                    navigationService.router
                        .navigate(CustomerSupportScreenRoute());
                  },
                  leading: const Icon(Icons.message),
                  title: const Text('Inquiry Form'),
                ),
                ListTile(
                  onTap: () {
                    navigationService
                        .router.navigate(CouponsSupportScreenRoute());
                  },
                  leading: const Icon(Icons.card_giftcard),
                  title: const Text('Coupons'),
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
                  title: const Text('Languages'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
