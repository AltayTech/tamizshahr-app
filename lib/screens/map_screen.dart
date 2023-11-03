import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:geolocator/geolocator.dart';

import '../models/region.dart';
import '../models/request/address.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../widgets/info_edit_item.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapScreen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  bool _isInit = true;
  var _isLoading;

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController myController;
  static const LatLng _center = const LatLng(38.074065, 46.312711);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  LatLng _selectedPostion = _center;

  List<Address> addressList = [];

  var regionValue;
  List<String> regionValueList = [];
  List<Region> regionList = [];
  late Region selectedRegion;

  late FocusNode nameNode;
  late FocusNode regionNode;
  late FocusNode addressNode;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await retrieveRegions();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _onAddMarkerButtonPressed(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: latLng,
          infoWindow: InfoWindow(
            title: 'مکان منتخب',
            snippet: '',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      _selectedPostion = latLng;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
    _controller.complete(controller);
  }

  late Geolocator _geolocator;
  late Position _position;

  void checkPermission() {
    Geolocator.checkPermission().then((status) {
      print('status: $status');
    });
    // _geolocator
    //     .checkGeolocationPermissionStatus(
    //         locationPermission: GeolocationPermission.locationAlways)
    //     .then((status) {
    //   print('always status: $status');
    // });
    // _geolocator.checkGeolocationPermissionStatus(
    //     locationPermission: GeolocationPermission.locationWhenInUse)
    //   ..then((status) {
    //     print('whenInUse status: $status');
    //   });
  }

  @override
  void initState() {
    super.initState();

    nameNode = FocusNode();
    regionNode = FocusNode();
    addressNode = FocusNode();
    _geolocator = Geolocator();
    LocationSettings locationSettings =
    LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 1);

    checkPermission();

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      _position = position;
    });




  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));

      setState(() {
        _lastMapPosition = LatLng(newPosition.latitude, newPosition.longitude);
        _position = newPosition;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> saveAddress() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).getAddresses();

    addressList = Provider.of<Auth>(context, listen: false).addressItems;

    addressList.add(Address(
      name: nameController.text,
      address: addressController.text,
      region: Region(term_id: selectedRegion.term_id),
      latitude: _selectedPostion.latitude.toString(),
      longitude: _selectedPostion.longitude.toString(),
    ));
    print('addressList    ${addressList.length}');

    await Provider.of<Auth>(context, listen: false).updateAddress(addressList);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> retrieveRegions() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).retrieveRegionList();

    regionList = Provider.of<Auth>(context, listen: false).regionItems;
    for (int i = 0; i < regionList.length; i++) {
      regionValueList.add(regionList[i].name);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();

    nameNode.dispose();
    regionNode.dispose();
    addressNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
//        bottom: PreferredSize(
//          child: Container(),
//          preferredSize: Size.fromHeight(15),
//        ),
        title: Text(
          'آدرس جدید',
          style: TextStyle(
            fontFamily: 'Iransans',
          ),
        ),
//        shape: RoundedRectangleBorder(
//          borderRadius: new BorderRadius.vertical(
//              bottom: new Radius.elliptical(
//                  MediaQuery.of(context).size.width * 9, 200.0)),
//        ),
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Container(
                  height: deviceHeight * 0.4,
                  child: Card(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _lastMapPosition,
                        zoom: 12.0,
                      ),
                      mapType: _currentMapType,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      mapToolbarEnabled: true,
                      myLocationButtonEnabled: true,
                      onTap: (location) {
                        _onAddMarkerButtonPressed(location);
                      },
                      zoomGesturesEnabled: true,
                      onLongPress: (location) =>
                          _onAddMarkerButtonPressed(location),
                    ),
                  ),
                ),
                InfoEditItem(
                  title: 'نام آدرس',
                  controller: nameController,
                  bgColor: AppTheme.bg,
                  iconColor: Color(0xffA67FEC),
                  keybordType: TextInputType.text,
                  fieldHeight: deviceHeight * 0.06,
                  thisFocusNode: nameNode,
                  newFocusNode: regionNode,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: deviceWidth * 0.78,
                    child: Text(
                      'منطقه : ',
                      style: TextStyle(
                        color: AppTheme.h1,
                        fontFamily: 'Iransans',
                        fontSize: textScaleFactor * 14.0,
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: deviceWidth * 0.78,
                      height: deviceHeight * 0.05,
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.white,
                          border: Border.all(color: AppTheme.h1, width: 0.6)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 8.0, left: 8, top: 6),
                        child: DropdownButton<String>(
                          hint: Text(
                            'منطقه مورد نظر را آنتخاب کنید.',
                            style: TextStyle(
                              color: AppTheme.grey,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 13.0,
                            ),
                          ),
                          value: regionValue,
                          focusNode: regionNode,
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: AppTheme.black,
                              size: 20,
                            ),
                          ),
                          underline: Container(
                            color: AppTheme.white,
                          ),
                          dropdownColor: AppTheme.white,
                          style: TextStyle(
                            color: AppTheme.black,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 13.0,
                          ),
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              regionValue = newValue;
                              selectedRegion = regionList[
                                  regionValueList.lastIndexOf(newValue!)];
                              FocusScope.of(context).requestFocus(addressNode);
                            });
                          },
                          items: regionValueList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: deviceWidth * 0.6,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 13.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                InfoEditItem(
                  title: 'آدرس',
                  controller: addressController,
                  bgColor: AppTheme.bg,
                  iconColor: Color(0xffA67FEC),
                  keybordType: TextInputType.text,
                  fieldHeight: deviceHeight * 0.2,
                  maxLine: 10,
                  thisFocusNode: addressNode,
                  newFocusNode: new FocusNode(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            SnackBar addToCartSnackBar = SnackBar(
              content: Text(
                'منطقه انتخاب نشده است!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Iransans',
                  fontSize: textScaleFactor * 14.0,
                ),
              ),
              action: SnackBarAction(
                label: 'متوجه شدم',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            if (selectedRegion == null) {
              ScaffoldMessenger.of(context).showSnackBar(addToCartSnackBar);
            } else {
              await saveAddress().then((value) {
                Navigator.of(context).pop();
              });
            }
          },
          backgroundColor: AppTheme.primary,
          child: Icon(
            Icons.check,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
