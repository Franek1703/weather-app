import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalControler extends GetxController{
  // create var

  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString _city = "".obs;
  final RxString _subplace = "".obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  RxString getCity() => _city;
  RxString getSubplace() => _subplace;


  @override
  void onInit() {
    if(_isLoading.isTrue){
      getLocation();
    }
    else {
      getIndex();
    }
    
    super.onInit();
  }
  
  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // If the location service is not enabled ask the user to enable it
    if (!isServiceEnabled) {
      return Future.error("Location services are disabled.");
    }


    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are denied.");
  }
  else if (locationPermission == LocationPermission.denied) {
    // If the user has denied the permission ask the user to grant it
    locationPermission = await Geolocator.requestPermission();

    if (locationPermission == LocationPermission.denied) {
      return Future.error("Location permissions are denied.");
    }
  }
  
  //get current location
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high).then((value) async {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      List<Placemark> placemark = await placemarkFromCoordinates(_lattitude.value, _longitude.value);
    Placemark place = placemark[0];
      _city.value = place.locality!;
      _subplace.value = place.subLocality!;
      _isLoading.value = false;

    });

    

    
  
  }
  RxInt getIndex() {
    return _currentIndex;
  }
}
