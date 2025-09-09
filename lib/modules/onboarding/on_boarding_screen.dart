
import 'package:event_app/core/constants/assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/local_storage_keys.dart';
import 'package:event_app/core/services/local_storage_services.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

final int _numPages = 3;
final PageController _pageController = PageController(initialPage: 0);
int _currentPage = 0;

List<Widget> _buildPageIndicator(BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < _numPages; i++) {
    list.add(
      i == _currentPage
          ? _indicator(true, context)
          : _indicator(false, context),
    );
  }
  return list;
}

Widget _indicator(bool isActive, BuildContext context) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 6.0,
    width: isActive ? 24.0 : 10.0,
    decoration: BoxDecoration(
      color: isActive
          ? AppColors.primaryColor
          : (Provider.of<SettingProvider>(context).isDark()
                ? AppColors.lightBackgroundColor
                : AppColors.darkBackGroundColor),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: _currentPage != _numPages - 1
          ? FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                _completeOnboarding();
              },
              child: Text(
                local.skip,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 20,
                ),
              ),
            )
          : Text(""),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 25,
          top: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(Assets.onboarding1),
                      Text(
                        local.find_event,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding1Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? AppColors.lightBackgroundColor
                                : AppColors.darkBackGroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(Assets.onboarding2),
                      Text(
                        local.effortless,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding2Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? AppColors.lightBackgroundColor
                                : AppColors.darkBackGroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(Assets.onboarding3),
                      Text(
                        local.connect,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding3Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? AppColors.lightBackgroundColor
                                : AppColors.darkBackGroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _currentPage == 0
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,

                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: AppColors.primaryColor),
                      ),
                      child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(context),
                  ),
                  GestureDetector(
                    onTap: _currentPage == _numPages - 1
                        ? () {
                            _completeOnboarding();
                          }
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: AppColors.primaryColor),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    await LocalStorageServices.setBool(
      LocalStorageKeys.onboardingSeenKey,
      true,
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutesName.login,
      (route) => false,
    );
  }
}
