import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';
import '../../auths/login/login.dart';
import '../../auths/register/register.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    checkLogin();
    _pageController = PageController(initialPage: 0);
    _nbreSlides = demoData.length;
    super.initState();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString("role");
    if (role != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Container(),
        ),
        (route) => false,
      );
    }
  }

  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _pageIndex = 0;
  late int _nbreSlides;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular background
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: 120,
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: appColor.withOpacity(.2),
                      ),
                    ),
                    // Tags
                    Positioned(
                      top: 50,
                      left: 30,
                      child: _buildTag("#Enseignants", Colors.purple),
                    ),
                    Positioned(
                      bottom: 120,
                      right: 30,
                      child: _buildTag("#Écoles", appColor),
                    ),
                    Positioned(
                      top: 130,
                      left: 70,
                      child: _buildTag("#Parents", Colors.blue),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 20,
                      child: _buildTag("#Tracking", Colors.orange),
                    ),
                    Positioned(
                      top: 100,
                      right: 40,
                      child: _buildTag("#Paiments", Colors.green),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => TestScreenContent(
                    titre: demoData[index].titre,
                    subTitre: demoData[index].subTitre,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'avant',
                    shape: CircleBorder(),
                    onPressed: () {
                      if (_pageIndex == 0) {
                        return;
                      }
                      _pageController.previousPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: Icon(
                      Icons.navigate_before_outlined,
                      color: appColor,
                      size: 20.sp,
                    ),
                  ),
                  Spacer(),
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton.small(
                    heroTag: 'next',
                    shape: CircleBorder(),
                    onPressed: () {
                      if (_pageIndex + 1 == _nbreSlides) {
                        return;
                      }
                      _pageController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: Icon(
                      Icons.navigate_next_outlined,
                      color: appColor,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              Gap(3.h),
              SubmitButton(
                AppConstants.btnLogin,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              Gap(2.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Vous n'avez pas de compte? ",
                      style: TextStyle(
                        color: appBlack,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: "S'enregistrer",
                      style: TextStyle(
                        color: appColor,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              Gap(2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class TestScreenContent extends StatelessWidget {
  const TestScreenContent({
    super.key,
    required this.titre,
    required this.subTitre,
  });

  final String titre, subTitre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titre,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appBlack,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
            Gap(2.w),
            Text(
              subTitre,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appBlack,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String titre, subTitre;

  Onboard({
    required this.titre,
    required this.subTitre,
  });
}

final List<Onboard> demoData = [
  Onboard(
    titre: "E-School parent.",
    subTitre:
        "E-School vous permet de gagner du temps dans le suivi du niveau de votre fils.",
  ),
  Onboard(
    titre: "E-School Teacher.",
    subTitre:
        "E-School vous permet de gagner du temps dans le suivi de vos classes.",
  ),
  Onboard(
    titre: "E-School Student.",
    subTitre:
        "E-School vous permet de gagner du temps dans le suivi des cours de votre école.",
  ),
];

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: isActive ? 3.w : 2.w,
      width: 3.w,
      decoration: BoxDecoration(
        color: isActive ? appColor : appColor.withOpacity(.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
