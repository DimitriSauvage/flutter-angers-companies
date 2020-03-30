import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_world/models/company.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';

class MapTab extends StatefulWidget {
  MapTab({@required this.companies});

  List<Company> companies;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  //Map controller
  MapController _mapController;
  //Map with state controller
  StatefulMapController _statefulMapController;
  //Map changes subscription
  StreamSubscription<StatefulMapControllerStateChange> _subscription;

  ///Initialize the state
  @override
  void initState() {
    this._mapController = MapController();
    this._statefulMapController =
        StatefulMapController(mapController: this._mapController);

    // wait for the controller to be ready before using its
    this._statefulMapController.onReady.then((_) {
      this._subscription = this
          ._statefulMapController
          .changeFeed
          .listen((change) => setState(() {}));
    });

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called

    super.initState();
  }

  ///Called when instance is removed
  @override
  void dispose() {
    this._subscription.cancel();
    super.dispose();
  }

  ///Get the markers to display
  List<Marker> _getMakersFromCompanies() {
    List<Marker> markers = List<Marker>();
    if (this.widget.companies != null) {
      this.widget.companies.forEach((company) {
        if (company?.address?.coordinate != null) {
          Marker marker = Marker(
            width: 70,
            height: 70,
            point: company.address.coordinate,
            builder: (ctx) => new Container(
              child: FlutterLogo(),
            ),
          );
          markers.add(marker);
        }
      });
    }
    return markers;
  }

  ///Zoom in the map
  void _zoomIn() {
    this._statefulMapController.zoomIn();
  }

  ///Unzoom in the map
  void _zoomOut() {
    this._statefulMapController.zoomOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: this._mapController,
            options:
                MapOptions(zoom: 12.0, center: LatLng(47.4739884, -0.5515588)),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  keepBuffer: 0),
              MarkerLayerOptions(markers: this._getMakersFromCompanies())
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                      color: Colors.white,
                      child: Icon(Icons.add),
                      onPressed: this._zoomIn),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: FlatButton(
                        color: Colors.white,
                        child: Icon(Icons.remove),
                        onPressed: this._zoomOut))
              ],
            ),
          )
        ],
      )),
    );
  }
}
