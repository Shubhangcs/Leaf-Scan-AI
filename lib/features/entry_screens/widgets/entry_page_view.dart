import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class EntryPageView extends StatefulWidget {
  final TabController tabController;
  final PageController pageController;
  const EntryPageView(
      {super.key, required this.tabController, required this.pageController});

  @override
  State<EntryPageView> createState() => _EntryPageViewState();
}

class _EntryPageViewState extends State<EntryPageView> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          controller: widget.pageController,
          children: [
            _customPageWidget(
                "assets/Animation - 1739076505565.json", "Scan The Leaf"),
            _customPageWidget(
                "assets/Animation - 1739076652592.json", "Get Information"),
            _customPageWidget(
                "assets/Animation - 1739076815389.json", "Ask Qustions")
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SmoothPageIndicator(
              controller: widget.pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.lightGreyColor,
                activeDotColor: AppColors.greenColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.topRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Text(_currentPageIndex == 2 ? "Done" :
                    "Skip",
                    style: GoogleFonts.workSans(
                      color: AppColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_right_rounded,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _customPageWidget(String assetName, String assetText) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: LottieBuilder.asset(assetName),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              assetText,
              style: GoogleFonts.workSans(
                fontSize: 22,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
