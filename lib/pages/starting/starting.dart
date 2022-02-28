import 'package:flutter/cupertino.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/pages/checkout/checkout.dart';
import 'package:labouchee/pages/landing/home_view.dart';
import 'package:labouchee/pages/place_order/place_order.dart';
import 'package:labouchee/pages/product_details/product_details.dart';
import 'package:labouchee/searchbar.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../app/locator.dart';
import '../../app/routes.gr.dart';
import '../cart/cart.dart';
import '../notifications/notifications.dart';

// The no worry
class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  int _currentIndex = 0;
  late PageController _pageController;
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

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
    final navigationService = locator<NavigationService>();

    return Scaffold(
      // drawer: Drawer(),
      // appBar: AppBar(
      //   leading: Builder(builder: (context) {
      //     return IconButton(
      //       icon: Icon(
      //         Icons.menu,
      //         color: primaryColor,
      //       ),
      //       onPressed: () => Scaffold.of(context).openDrawer(),
      //     );
      //   }),
      //   actions: [
      //     Container(
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.language,
      //           color: primaryColor,
      //         ),
      //         onPressed: () => navigationService.navigateTo(
      //           Routes.languageScreenRoute,
      //           arguments:
      //               LanguageViewArguments(nextPage: Routes.startingScreenRoute),
      //         ),
      //       ),
      //       margin: EdgeInsets.symmetric(horizontal: 10),
      //     ),
      //     // Ye abhi bhi login pa ja raha
      //     Container(
      //         child: Icon(
      //           Icons.shopping_cart,
      //           color: primaryColor,
      //         ),
      //         margin: EdgeInsets.symmetric(horizontal: 10)),
      //   ],
      //   title: Image.asset("assets/images/flags/logo.png"),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: SliderDrawer(
          appBar: SliderAppBar(
            trailing: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.language,
                      color: primaryColor,
                    ),
                    onPressed: () => navigationService.navigateTo(
                      Routes.languageScreenRoute,
                      arguments: LanguageViewArguments(
                          nextPage: Routes.startingScreenRoute),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Container(
                    child: Icon(
                      Icons.shopping_cart,
                      color: primaryColor,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10)),
              ],
            ),
            title: Image.asset("assets/images/flags/logo.png"),
            isTitleCenter: true,
            appBarColor: Colors.white,
          ),
          key: _key,
          sliderOpenSize: 200,
          slider: _SliderView(
            onItemClick: (title) {
              _key.currentState!.closeSlider();
              // setState(() {
              //   this.title = title;
              // });
            },
          ),
          child: SizedBox.expand(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          LandingView(),
          SearchBar(),
          // CheckOut(),
          Cart(),
          // PlaceOrder(),
          Notifications()
        ],
      ),
    ),),
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
              title: Text('Home'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              title: Text('Search'),
              icon: Icon(Icons.search)),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              title: Text('Cart'),
              icon: Icon(Icons.shopping_cart)),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              title: Text('Item Four'),
              icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
// Widget CustomAppBar(){
//   return AppBar()
// }
}

class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          // CircleAvatar(
          //   radius: 65,
          //   backgroundColor: Colors.grey,
          //   child: CircleAvatar(
          //     radius: 60,
          //     backgroundImage: AssetImage('assets/images/user_profile.jpg'),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nick',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'BalsamiqSans'),
          ),
          SizedBox(
            height: 20,
          ),
          _SliderMenuItem(
              title: 'Profile', iconData: Icons.account_circle_sharp, onTap: onItemClick),
          _SliderMenuItem(
              title: 'Add Post',
              iconData: Icons.add_circle,
              onTap: onItemClick),
          _SliderMenuItem(
              title: 'Notification',
              iconData: Icons.notifications_active,
              onTap: onItemClick),
          _SliderMenuItem(
              title: 'Likes', iconData: Icons.favorite, onTap: onItemClick),
          _SliderMenuItem(
              title: 'Setting', iconData: Icons.settings, onTap: onItemClick),
          _SliderMenuItem(
              title: 'LogOut',
              iconData: Icons.arrow_back_ios,
              onTap: onItemClick),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title));
  }
}
