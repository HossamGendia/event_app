import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickEventMapScreen extends StatefulWidget {
  const PickEventMapScreen({super.key});

  @override
  State<PickEventMapScreen> createState() => _PickEventMapScreenState();
}

class _PickEventMapScreenState extends State<PickEventMapScreen> {
  late AppProvider appProvider;
  @override
  void initState() {
    // TODO: implement initState
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) => Scaffold(
        body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (location){
                    appProvider.setEventLocation(location);
                    Navigator.pop(context);
                  },
                  markers: provider.markers,
                  mapType: MapType.normal,
                  onMapCreated: (mapController) {
                    provider.mapController = mapController;
                  },
                  initialCameraPosition: provider.cameraPosition,
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Text('Tap on location to select', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),),
              ),
            ],
          ),
      ),
    );
  }
}
