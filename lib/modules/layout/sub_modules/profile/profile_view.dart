import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:event_app/core/constants/assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AppLocalizations localization;
  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    localization = AppLocalizations.of(context)!;
  }

  final List<String> _language = ["English", "عربي"];

  final List<String> _themes = ["Light", "Dark"];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          padding: EdgeInsets.only(left: 16, right: 16, top: 30),
          decoration: BoxDecoration(
            color: Provider.of<SettingProvider>(context).isDark()? AppColors.darkBackGroundColor : AppColors.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(1000),
                    bottomLeft: Radius.circular(1000),
                    bottomRight: Radius.circular(1000),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hossam Hassan",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Flutter Developer",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            localization.language,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: provider.isDark()? Colors.white : Colors.black
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomDropdown<String>(
            items: _language,
            initialItem: provider.currentLanguage == "en" ? "English" : "عربي",
            onChanged: (value) {
              provider.changeLanguage(value! == "English" ? "en" : "ar");
            },
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: AppColors.primaryColor),
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 30,
                color: AppColors.primaryColor,
              ),
              closedFillColor: Colors.transparent,
              headerStyle: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              listItemStyle: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              expandedFillColor: provider.isDark()? AppColors.darkBackGroundColor : Colors.white,
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            localization.theme_mode,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
                color: provider.isDark()? Colors.white : Colors.black
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomDropdown<String>(
            items: _themes,
            initialItem: provider.isDark() ? "Dark" : "Light",
            onChanged: (value) {
              provider.changeThemeMode(
                value! == "Light" ? ThemeMode.light : ThemeMode.dark,
              );
            },
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: AppColors.primaryColor),
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 30,
                color: AppColors.primaryColor,
              ),
              closedFillColor: Colors.transparent,
              headerStyle: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              listItemStyle: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              expandedFillColor: provider.isDark()? AppColors.darkBackGroundColor : Colors.white,
            ),
          ),
        ),

        Spacer(),

        GestureDetector(
          onTap: () async {
            // Navigator.of(context).pushNamed(PageRoutesName.login);

            //await FirebaseAuth.instance.signOut();
            // provider.changeThemeMode(ThemeMode.light);
            // provider.changeLanguage("en");
            Navigator.pushNamedAndRemoveUntil(
              context,
              PageRoutesName.login,
                  (route) => false,
            );

          },
          child: Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.all(8.0),
            margin:  const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,color: AppColors.lightBackgroundColor,size: 25,),
                    Text(
                      "Logout",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: AppColors.lightBackgroundColor,
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ),

        SizedBox(height:  40)
      ],
    );
  }
}
