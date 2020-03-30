import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_world/models/company.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';

const String BIKE_TILE =
    "https://dev.{s}.tile.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png";
const String NORMAL_TILE =
    "https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png";

enum TileMode { Bike, Normal }

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
  //Icon to display
  IconData _switchTileIcon = Icons.directions_bike;
  //Url to use for the tile
  String _customTile = NORMAL_TILE;
  TileMode _tileMode = TileMode.Normal;

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

  ///Change the tile
  void _switchTile() {
    this.setState(() {
      if (this._tileMode == TileMode.Normal) {
        //Switch to bike
        this.setState(() {
          this._tileMode = TileMode.Bike;
          this._customTile = BIKE_TILE;
          this._switchTileIcon = Icons.map;
        });
      } else {
        this.setState(() {
          this._tileMode = TileMode.Normal;
          this._customTile = NORMAL_TILE;
          this._switchTileIcon = Icons.directions_bike;
        });
      }
    });
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
                  urlTemplate: this._customTile,
                  subdomains: ['a', 'b', 'c'],
                  keepBuffer: 0),
              MarkerLayerOptions(markers: this._getMakersFromCompanies())
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: FlatButton(
                    color: Colors.white,
                    child: Icon(this._switchTileIcon),
                    onPressed: this._switchTile),
              ),
            ),
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
