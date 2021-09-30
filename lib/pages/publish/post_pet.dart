import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mascotas_app/business/geolocator.dart';
import 'package:mascotas_app/pages/publish/firebase_api.dart';
import 'package:mascotas_app/utils/utils_theme.dart';
import 'package:mascotas_app/widgets/group/change_map_location.dart';
import 'package:mascotas_app/widgets/unit/button_widget.dart';
import 'package:mascotas_app/widgets/unit/unit_label_input.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

enum typePost { lost, found, adoption }

class PostPet extends StatefulWidget {
  final String textFecha;
  final String textDireccion;
  final String textPersona;
  final String textPersonaNumber;
  final String textInformation;
  final typePost type;

  const PostPet.lost({
    Key? key,
    this.textInformation = 'INFORMACION DE LA MASCOTA PERDIDA',
    this.textFecha = 'Fecha cuando se perdio',
    this.textDireccion = 'Direccion donde se perdio',
    this.textPersona = 'Nombre del propietario',
    this.textPersonaNumber = 'Numero del propietario',
    this.type = typePost.lost,
  }) : super(key: key);
  const PostPet.found({
    Key? key,
    this.textInformation = 'INFORMACION DE LA MASCOTA ENCONTRADA',
    this.textFecha = 'Fecha cuando se encontro',
    this.textDireccion = 'Direccion donde se encontro',
    this.textPersona = 'Nombre del rescatador',
    this.textPersonaNumber = 'Numero del recatador',
    this.type = typePost.found,
  }) : super(key: key);
  const PostPet.adoption({
    Key? key,
    this.textInformation = 'INFORMACION DE LA MASCOTA EN ADOPCION',
    this.textFecha = 'Fecha de nacimiento',
    this.textDireccion = 'Direccion de contacto',
    this.textPersona = 'Nombre de contacto',
    this.textPersonaNumber = 'Numero de contacto',
    this.type = typePost.adoption,
  }) : super(key: key);

  @override
  State<PostPet> createState() => _PostPetState();
}

class _PostPetState extends State<PostPet> {
  // TextEditingController controllerNamePet = TextEditingController();
  TextEditingController controllerDescriptionPet = TextEditingController();
  TextEditingController controllerNameOwner = TextEditingController();
  TextEditingController controllerNamePet = TextEditingController();
  TextEditingController controllerNumberOwner = TextEditingController();

  bool cat = false;
  bool dog = false;
  bool other = false;

  bool macho = false;
  bool hembra = false;

  String fechaEstado = "--/--/----";
  String horaEstado = "00:00";

  String? imageUrl;

  double sizePet = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.textInformation,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          // getImage(ImageSource.gallery);
                          selectFile();
                        },
                        child: Column(
                          children: [
                            const Text(
                              "Suba una foto de la mascota",
                              style: styleTextSubIndice,
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(-3, 3),
                                        color: Colors.black26,
                                        blurRadius: 3)
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: imageUpload(),
                              ),
                            )
                          ],
                        )),
                    Column(
                      children: [
                        const Text(
                          "Sexo",
                          style: styleTextSubIndice,
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                            onPressed: () {
                              macho = true;
                              hembra = false;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  !macho
                                      ? "assets/images/machob.png"
                                      : "assets/images/machoc.png",
                                  width: macho ? 60 : 40,
                                  fit: BoxFit.cover,
                                ),
                                const Text("MACHO")
                              ],
                            )),
                        // ignore: deprecated_member_use
                        FlatButton(
                            onPressed: () {
                              macho = false;
                              hembra = true;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  !hembra
                                      ? "assets/images/hembrab.png"
                                      : "assets/images/hembrac.png",
                                  width: hembra ? 60 : 40,
                                  fit: BoxFit.cover,
                                ),
                                const Text("HEMBRA")
                              ],
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Que raza es la mascota?",
                  style: styleTextSubIndice,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Column(
                          children: [
                            Image.asset(
                              cat
                                  ? "assets/images/catc.png"
                                  : "assets/images/catb.png",
                              fit: BoxFit.contain,
                              width: 50,
                              height: 50,
                            ),
                            const Text("Gato")
                          ],
                        ),
                        onTap: () {
                          cat = true;
                          dog = false;
                          other = false;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: Column(
                          children: [
                            Image.asset(
                              dog
                                  ? "assets/images/dogc.png"
                                  : "assets/images/dogb.png",
                              fit: BoxFit.contain,
                              width: 50,
                              height: 50,
                            ),
                            const Text("Perro")
                          ],
                        ),
                        onTap: () {
                          cat = false;
                          dog = true;
                          other = false;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: Column(
                          children: [
                            Image.asset(
                              other
                                  ? "assets/images/otherc.png"
                                  : "assets/images/otherb.png",
                              fit: BoxFit.contain,
                              width: 50,
                              height: 50,
                            ),
                            const Text("Otro")
                          ],
                        ),
                        onTap: () {
                          cat = false;
                          dog = false;
                          other = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Tamaño de la mascota: ${slidePetShow()}",
                  style: styleTextSubIndice,
                ),
                SizedBox(
                  width: 300,
                  child: Slider(
                    divisions: 2,
                    min: 1,
                    max: 3,
                    activeColor: Colors.green,
                    label: slidePetShow(),
                    value: sizePet,
                    onChanged: (value) {
                      setState(() {
                        sizePet = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          // minTime: DateTime(2018, 3, 5),
                          // maxTime: DateTime(2019, 6, 7),
                          onChanged: (date) {}, onConfirm: (date) {
                        // print('confirm ${date.month.}');
                        setState(() {});
                        fechaEstado =
                            "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString()}";
                        horaEstado =
                            "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                    child: Column(
                      children: [
                        Text(
                          widget.textFecha,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        Text("$fechaEstado  -  $horaEstado",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                            )),
                      ],
                    )),
                const SizedBox(height: 10),
                Text(
                  widget.textDireccion,
                  style: styleTextSubIndice,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: _changeGoogleMap(),
                ),
                const Text(
                  'Direccion:',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(textControllerDireccion.text),
                const Text(
                  'Ciudad',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(textControllerCiudad.text),
                CupertinoButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeMapPosition(
                          // controller: _controller,
                          controllerTextLat: textControllerLat,
                          controllerTextLong: textControllerLong,
                          controllerTextDirection: textControllerDireccion,
                          controllerTextCiudad: textControllerCiudad,
                          positionMap: _initialPosition,
                          ontap: () async {
                            _initialPosition = CameraPosition(
                                target: LatLng(
                                    double.parse(textControllerLat.text),
                                    double.parse(textControllerLong.text)),
                                zoom: 16);
                            await _moveTo(_initialPosition);
                            await _obtenerDireccion(
                                double.parse(textControllerLat.text),
                                double.parse(textControllerLong.text));
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                  color: Colors.green,
                  child: const Text('Cambiar direccion'),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Nombre de la mascota",
                  style: styleTextSubIndice,
                ),
                UnitLabelInput(
                  title: 'Nombre de la mascota',
                  control: controllerNamePet,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Descripcion de la mascota",
                  style: styleTextSubIndice,
                ),
                UnitLabelInput(
                  title: 'Descripcion',
                  control: controllerDescriptionPet,
                  descrip: true,
                ),
                const SizedBox(height: 10),
                const Text(
                  "INFORMACION DE LA PERSONA",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Nombre del propietario",
                  style: styleTextSubIndice,
                ),
                UnitLabelInput(
                  title: widget.textPersona,
                  control: controllerNameOwner,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Numero del propietario",
                  style: styleTextSubIndice,
                ),
                UnitLabelInput(
                  title: widget.textPersonaNumber,
                  control: controllerNumberOwner,
                  isNumber: true,
                ),
                const SizedBox(height: 10),
                ButtonWidget(
                  icon: Icons.upload,
                  text: 'Enviar Datos',
                  onClicked: () {
                    String sizePetText = '';
                    String raza = '';
                    String sexo = '';
                    if (sizePet == 1) sizePetText = 'Pequeño';
                    if (sizePet == 2) sizePetText = 'Mediano';
                    if (sizePet == 3) sizePetText = 'Grande';

                    if (cat && !dog && !other) raza = 'Gato';
                    if (!cat && dog && !other) raza = 'Perro';
                    if (!cat && !dog && other) raza = 'Otro';

                    if (macho && !hembra) sexo = 'Macho';
                    if (!macho && hembra) sexo = 'Hembra';
                    // ignore: avoid_print
                    print('''
                    DescriptionPet => ${controllerDescriptionPet.text}
                    NameOwner => ${controllerNameOwner.text}
                    NamePet => ${controllerNamePet.text}
                    NumberOwner => ${controllerNumberOwner.text}
                    fechaEstado => $fechaEstado
                    horaEstado => $horaEstado
                    imageUrl => $imageUrl
                    sizePetText => $sizePetText
                    raza => $raza
                    sexo => $sexo
                    textControllerDireccion => ${textControllerDireccion.text}
                    textControllerCiudad => ${textControllerCiudad.text}
                    _initialPosition => ${_initialPosition.target}
                    type => ${widget.type}
                    ''');
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String slidePetShow() {
    if (sizePet == 1) {
      return 'Pequeño';
    }
    if (sizePet == 2) {
      return 'Mediano';
    }
    if (sizePet == 3) {
      return 'Grande';
    }
    return 'Otro';
  }

  //
  bool flagUpload = false;
  Widget imageUpload() {
    if (imageUrl == null && !flagUpload) {
      return Image.asset(
        "assets/images/upload.png",
        width: 125,
        height: 125,
      );
    } else if (imageUrl == null && flagUpload) {
      return const SizedBox(
        width: 200,
        height: 200,
        child: Image(
          image: AssetImage("assets/images/loading_pet.gif"),
          fit: BoxFit.cover,
        ),
      );
    } else {
      if (imageUrl != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/loading_pet.gif"),
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        );
      } else {
        return const Text('data no found');
      }
    }
  }

  @override
  void dispose() {
    flagUpload = false;
    imageUrl = null;
    super.dispose();
  }

  UploadTask? task;
  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    imageUrl = null;
    flagUpload = true;
    setState(() {});
    final path = result.files.single.path!;

    setState(() => file = File(path));
    await uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imageUrl = urlDownload;
    setState(() {});
  }

  /////////////////////
  /////////////////////
  late Position position;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getCoordinatesDevice();
      setState(() {});
    });
  }

  void getCoordinatesDevice() async {
    try {
      position = await determinePosition();
    } catch (e) {
      position = (await Geolocator.getLastKnownPosition())!;
    }
    initializePosition();
  }

  void initializePosition() async {
    CameraPosition _position = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 16);
    _initialPosition = _position;
    await _moveTo(_initialPosition);
    await _obtenerDireccion(
        _initialPosition.target.latitude, _initialPosition.target.longitude);
    setState(() {});
  }

  CameraPosition _initialPosition = const CameraPosition(
      target: LatLng(-16.49559644284926, -68.1333991911331), zoom: 16);

  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _moveTo(CameraPosition position) async {
    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<void> _obtenerDireccion(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    textControllerLat.text = '$lat';
    textControllerLong.text = '$long';

    textControllerCiudad.text = placemarks[0].locality!;
    textControllerDireccion.text = placemarks[0].street!;
    if (textControllerDireccion.text.contains('Unnamed')) {
      textControllerDireccion.text = '';
    }
  }

  TextEditingController textControllerLat = TextEditingController();
  TextEditingController textControllerLong = TextEditingController();
  TextEditingController textControllerDireccion = TextEditingController();
  TextEditingController textControllerCiudad = TextEditingController();

  Widget _changeGoogleMap() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black38, blurRadius: 5)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
              rotateGesturesEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              onMapCreated: _onMapCreated,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()))
                ..add(Factory<HorizontalDragGestureRecognizer>(
                    () => HorizontalDragGestureRecognizer()))
                ..add(
                  Factory<ScaleGestureRecognizer>(
                      () => ScaleGestureRecognizer()),
                ),
            ),
          ),
        ),
        Image.asset(
          'assets/images/marker.png',
          width: 40,
        ),
        Container(
          color: Colors.transparent,
        )
      ],
    );
  }
}
