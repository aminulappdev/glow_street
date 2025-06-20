import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_street/app/modules/authentication/views/sign_in_screen.dart';
import 'package:glow_street/app/modules/home/views/home_screen.dart';
import 'package:glow_street/app/utils/responsive_size.dart';


class MainButtonNavbarScreen extends StatefulWidget {
  const MainButtonNavbarScreen({super.key});

  @override
  State<MainButtonNavbarScreen> createState() => _MainButtonNavbarScreenState();
}

class _MainButtonNavbarScreenState extends State<MainButtonNavbarScreen> {
  int selectedKey = 0;

  // List of screens for navigation
  List<Widget> screens = [
    const HomeScreen(),
    const SignInScreen(), // Replace with other screens as needed
    const SignInScreen(),
    const SignInScreen(),
    const SignInScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedKey],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Container(
          height: 70.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                selectedIcon: Icons.home,
                unselectedIcon: Icons.home_outlined,
                label: "Home",
              ),
              _buildNavItem(
                index: 1,
                selectedIcon: Icons.shopping_cart,
                unselectedIcon: Icons.shopping_cart_outlined,
                label: "Cart",
              ),
              _buildNavItem(
                index: 2,
                selectedIcon: Icons.list_alt,
                unselectedIcon: Icons.list_alt_outlined,
                label: "List",
              ),
              _buildNavItem(
                index: 3,
                selectedIcon: Icons.person,
                unselectedIcon: Icons.person_outline,
                label: "Profile",
              ),
               _buildNavItem(
                index: 4,
                selectedIcon: Icons.person,
                unselectedIcon: Icons.person_outline,
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String label,
  }) {
    bool isSelected = selectedKey == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedKey = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected)
            Container(
              height: 5.h,
              width: 55.h,
              decoration: BoxDecoration(
                color: Color(0xff0501FF),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            heightBox8,
          Icon(
            isSelected ? selectedIcon : unselectedIcon,
            color: isSelected ? Color(0xff0501FF) : Colors.black,
            size: 28.sp,
          ),
          if (isSelected)
            Text(
              label,
              style: TextStyle(
                color: Color(0xff0501FF),
                fontSize: 12.sp,
              ),
            ),
        ],
      ),
    );
  }
}