import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/manager/app_manager.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late AppProvider appProvider;
  GoogleMapController? _mapController;
  bool _userMovedMap = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
    appProvider.setLocationListner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Theme(
        data: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.primaryColor,
            foregroundColor:Provider.of<SettingProvider>(context).isDark()? Colors.black : Colors.white,

          )
        ),
        child: FloatingActionButton(onPressed: (){
          appProvider.getLocation();
          _userMovedMap = false;
        },
        child: Icon(Icons.gps_fixed),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GoogleMap(
                markers: provider.markers,
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  _mapController = controller;
                  provider.mapController = controller;
                },
                initialCameraPosition: provider.cameraPosition,
                onCameraMoveStarted: () {
                  _userMovedMap = true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
