import 'package:geojson/geojson.dart';
import 'package:hello_world/models/address.dart';
import 'package:latlong/latlong.dart';

class GeoJsonHelper {
  static featureToAddress(GeoJsonFeature<GeoJsonPoint> feature) {
    Map<String, dynamic> props = feature.properties;
    return Address(
        city: props["city"],
        number: props["housenumber"],
        street: props["street"],
        zipCode: props["postcode"],
        coordinate: LatLng(feature.geometry.geoPoint.latitude,
            feature.geometry.geoPoint.longitude));
  }
}
