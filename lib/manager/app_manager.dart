// import 'package:flutter/foundation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class AppProvider extends ChangeNotifier {
//   var location = Location();
//   String locationMessage = "";
//   Set<Marker> markers = {
//     Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(37.42796133580664, -122.085749655962),
//     ),
//   };
//   late GoogleMapController mapController;
//
//   CameraPosition cameraPosition = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   Future<void> getLocation() async {
//     notifyListeners();
//     bool locationPermissionGranted = await _getLocationPermission();
//     if (!locationPermissionGranted) {
//       locationMessage = "Location Permission Denied";
//       notifyListeners();
//       return;
//     }
//     bool locationServiceEnabled = await _locationServiceEnabled();
//     if (!locationServiceEnabled) {
//       locationMessage = "Location Service Disabled";
//       notifyListeners();
//       return;
//     }
//     notifyListeners();
//
//     LocationData locationData = await location.getLocation();
//     changeLocationOnMap(locationData);
//
//     notifyListeners();
//   }
//
//   Future<bool> _getLocationPermission() async {
//     var permissionStatus = await location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//     }
//     return permissionStatus == PermissionStatus.granted;
//   }
//
//   Future<bool> _locationServiceEnabled() async {
//     bool locationServiceEnabled = await location.serviceEnabled();
//
//     if (!locationServiceEnabled) {
//       locationServiceEnabled = await location.requestService();
//     }
//     return locationServiceEnabled;
//   }
//
//   void changeLocationOnMap(LocationData locationData) {
//     CameraPosition cameraPosition = CameraPosition(
//       target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
//       zoom: 25,
//     );
//     mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     markers.add(
//       Marker(
//         markerId: MarkerId(UniqueKey().toString()),
//         position: LatLng(
//           locationData.latitude ?? 0,
//           locationData.longitude ?? 0,
//         ),
//       ),
//     );
//
//     notifyListeners();
//   }
//
//   void setLocationListner() {
//     location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
//     location.onLocationChanged.listen((locationData) {
//       changeLocationOnMap(locationData);
//     });
//   }
// }

//****************************
//
// import 'package:flutter/foundation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class AppProvider extends ChangeNotifier {
//   var location = Location();
//   String locationMessage = "";
//   Set<Marker> markers = {
//     Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(37.42796133580664, -122.085749655962),
//     ),
//   };
//   late GoogleMapController mapController;
//   LatLng? eventLocation ;
//
//   CameraPosition cameraPosition = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//
//   Future<void> getLocation() async {
//     notifyListeners();
//     bool locationPermissionGranted = await _getLocationPermission();
//     if (!locationPermissionGranted) {
//       locationMessage = "Location Permission Denied";
//       notifyListeners();
//       return;
//     }
//     bool locationServiceEnabled = await _locationServiceEnabled();
//     if (!locationServiceEnabled) {
//       locationMessage = "Location Service Disabled";
//       notifyListeners();
//       return;
//     }
//     notifyListeners();
//
//     LocationData locationData = await location.getLocation();
//     changeLocationOnMap(locationData);
//
//     notifyListeners();
//   }
//
//   Future<bool> _getLocationPermission() async {
//     var permissionStatus = await location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//     }
//     return permissionStatus == PermissionStatus.granted;
//   }
//
//   Future<bool> _locationServiceEnabled() async {
//     bool locationServiceEnabled = await location.serviceEnabled();
//
//     if (!locationServiceEnabled) {
//       locationServiceEnabled = await location.requestService();
//     }
//     return locationServiceEnabled;
//   }
//
//   void changeLocationOnMap(LocationData locationData, {bool moveCamera = false}) {
//     if (moveCamera) {
//       mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
//             zoom: 14.4746,
//           ),
//         ),
//       );
//     }
//
//     markers.add(
//       Marker(
//         markerId: MarkerId(UniqueKey().toString()),
//         position: LatLng(
//           locationData.latitude ?? 0,
//           locationData.longitude ?? 0,
//         ),
//       ),
//     );
//
//     notifyListeners();
//   }
//
//
//   void setLocationListner() {
//     location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
//     location.onLocationChanged.listen((locationData) {
//       changeLocationOnMap(locationData, moveCamera: false);
//     });
//   }
//
//
//
//
//   void setEventLocation(LatLng newEventLocation) {
//     eventLocation = newEventLocation;
//     notifyListeners();
//   }
//
//   LatLng? getEventLocation() {
//     return eventLocation;
//   }
// }
//******************************************

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppProvider extends ChangeNotifier {
  var location = Location();
  String locationMessage = "";
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };
  late GoogleMapController mapController;
  LatLng? eventLocation;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> getLocation() async {
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) {
      locationMessage = "Location Permission Denied";
      notifyListeners();
      return;
    }

    bool locationServiceEnabled = await _locationServiceEnabled();
    if (!locationServiceEnabled) {
      locationMessage = "Location Service Disabled";
      notifyListeners();
      return;
    }

    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData, moveCamera: true);
  }

  Future<bool> _getLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }

  void changeLocationOnMap(LocationData locationData, {bool moveCamera = false}) {
    if (moveCamera) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
            zoom: 14.4746,
          ),
        ),
      );
    }

    markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
      ),
    );

    notifyListeners();
  }

  void setLocationListner() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    location.onLocationChanged.listen((locationData) {
      changeLocationOnMap(locationData, moveCamera: false);
    });
  }

  void setEventLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    notifyListeners();
  }

  LatLng? getEventLocation() {
    return eventLocation;
  }
}

