import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mascotas_app/utils/styleMapa.dart';

// ignore: must_be_immutable
class ChangeMapPosition extends StatefulWidget {
  final TextEditingController controllerTextLat;
  final TextEditingController controllerTextLong;
  final TextEditingController controllerTextDirection;
  final TextEditingController controllerTextCiudad;
  CameraPosition positionMap;
  Function ontap;
  ChangeMapPosition(
      {Key? key,
      required this.controllerTextLat,
      required this.controllerTextLong,
      required this.controllerTextDirection,
      required this.controllerTextCiudad,
      required this.positionMap,
      required this.ontap})
      : super(key: key);

  @override
  _ChangeMapPositionState createState() => _ChangeMapPositionState();
}

class _ChangeMapPositionState extends State<ChangeMapPosition> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: widget.positionMap,
                      rotateGesturesEnabled: false,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        controller.setMapStyle(dataMapStyle);
                      },
                      onCameraIdle: () {
                        // ignore: avoid_print
                        print('hhhhhhhhh ${widget.positionMap.target}');
                        _obtenerDireccion(
                          widget.positionMap.target.latitude,
                          widget.positionMap.target.longitude,
                        );
                        setState(() {});
                      },
                      onCameraMove: (value) {
                        // print("###### $value");
                        widget.positionMap = value;
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>{}
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer()))
                            ..add(Factory<HorizontalDragGestureRecognizer>(
                                () => HorizontalDragGestureRecognizer()))
                            ..add(
                              Factory<ScaleGestureRecognizer>(
                                  () => ScaleGestureRecognizer()),
                            ),
                    ),
                    Image.asset(
                      'assets/images/marker.png',
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Direccion:',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  // UnitLabelInput(
                  //   title: 'Direccion',
                  //   control: widget.controllerTextDirection,
                  // ),
                  Text(widget.controllerTextDirection.text),
                  const Text(
                    'Ciudad',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(widget.controllerTextCiudad.text),
                  // UnitLabelInput(
                  //   title: 'Ciudad',
                  //   control: widget.controllerTextCiudad,
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    // widget.controllerTextLat.text = '';
                    // widget.controllerTextLong.text = '';
                    // widget.controllerTextDirection.text = '';
                    // widget.controllerTextCiudad.text = '';
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      widget.controllerTextLat.text =
                          widget.positionMap.target.latitude.toString();
                      widget.controllerTextLong.text =
                          widget.positionMap.target.longitude.toString();
                      widget.ontap();
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _obtenerDireccion(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    widget.controllerTextCiudad.text = placemarks[0].locality!;
    widget.controllerTextDirection.text = placemarks[0].street!;
    if (widget.controllerTextDirection.text.contains('Unnamed')) {
      widget.controllerTextDirection.text = '';
    }
  }
}
