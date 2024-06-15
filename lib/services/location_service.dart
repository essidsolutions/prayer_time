// services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../errors/location_errors.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationError('Location services are disabled.');
      }

      // Check for location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationError('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationError(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      throw LocationError('Failed to get current location: $e');
    }
  }

  Future<String> getAddressFromCoordinates(Position position) async {
    try {
      // Get placemarks from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isEmpty) {
        throw LocationError('No placemarks found');
      }

      // Construct address string
      Placemark place = placemarks[0];
      String locality = place.locality ?? 'Unknown locality';
      String country = place.country ?? 'Unknown country';
      return "$locality, $country";
    } catch (e) {
      print('Error fetching address: $e'); // Detailed error logging
      return 'Unknown location'; // Fallback message
    }
  }
}
