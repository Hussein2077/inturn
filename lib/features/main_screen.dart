import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/coming_soon.dart';
import 'package:inturn/features/home/presentation/componants/applications.dart';
import 'package:inturn/features/home/presentation/componants/companies.dart';
import 'package:inturn/features/home/presentation/home_screen.dart';
import 'package:inturn/features/profile/presentation/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static int mainIndex = 0;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ApplicationsScreen(),
      const CompaniesScreen(),
      const ProfileScreen(),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: AppSize.defaultSize!*2.7,
        ),
        title: StringManager.home.tr(),
        textStyle:  TextStyle(fontSize: AppSize.defaultSize!*1.2),
        activeColorPrimary: AppColors.secondaryColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon:   Icon(
          Icons.sticky_note_2_outlined,
          size: AppSize.defaultSize!*2.7,
        ),
        title: StringManager.applications.tr(),
        textStyle:  TextStyle(fontSize: AppSize.defaultSize!*1.2),

        activeColorPrimary: AppColors.secondaryColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon:   Icon(
          Icons.warehouse_outlined,
          size: AppSize.defaultSize!*2.7,
        ),
        title: StringManager.companies.tr(),
        activeColorPrimary: AppColors.secondaryColor,
        inactiveColorPrimary: CupertinoColors.white,
        textStyle:  TextStyle(fontSize: AppSize.defaultSize!*1.2),

      ),
      PersistentBottomNavBarItem(
        icon:   Icon(
          Icons.person_outline,
          size: AppSize.defaultSize!*2.7,
        ),
        title: StringManager.profile.tr(),
        textStyle:  TextStyle(fontSize: AppSize.defaultSize!*1.2),
        activeColorPrimary: AppColors.secondaryColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),


    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: MainScreen.mainIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      drawerScrimColor: AppColors.greyColor,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor:AppColors.homeColor,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultSize!),
          colorBehindNavBar:AppColors.homeColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
