import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_app/utils/utils_theme.dart';
import 'package:mascotas_app/widgets/unit/unit_label_input.dart';

class PostLostPet extends StatefulWidget {
  const PostLostPet({Key? key}) : super(key: key);

  @override
  State<PostLostPet> createState() => _PostLostPetState();
}

class _PostLostPetState extends State<PostLostPet> {
  // TextEditingController controllerNamePet = TextEditingController();
  TextEditingController controllerDescriptionPet = TextEditingController();
  TextEditingController controllerDirectionLost = TextEditingController();
  TextEditingController controllerNameOwner = TextEditingController();
  TextEditingController controllerNumberOwner = TextEditingController();

  bool cat = false;
  bool dog = false;
  bool other = false;

  bool macho = false;
  bool hembra = false;

  String estadoMascota = "";
  String fechaEstado = "--/--/----";
  String horaEstado = "00:00";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text(
              "INFORMACION DE LA MASCOTA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                      'Que fecha ${estadoMascota == "PERDIDO" ? "se perdio" : estadoMascota == "ENCONTRADO" ? "fue encontrado" : "nacio"}',
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    Text("$fechaEstado  -  $horaEstado",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        )),
                  ],
                )),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Column(
                      children: [
                        const Text(
                          "Suba una foto de la mascota",
                          style: styleTextSubIndice,
                        ),
                        Image.asset(
                          "assets/images/upload.png",
                          width: 150,
                          height: 150,
                        )
                        // imageUrl == null
                        //     ? Image.asset(
                        //         "assets/images/upload.png",
                        //         width: 150,
                        //         height: 150,
                        //       )
                        //     : ClipRRect(
                        //         borderRadius: BorderRadius.circular(20),
                        //         child: FadeInImage(
                        //           placeholder:
                        //               AssetImage("assets/images/upload.png"),
                        //           image: NetworkImage(imageUrl),
                        //           fit: BoxFit.cover,
                        //           width: 200,
                        //           height: 200,
                        //         ),
                        //       ),
                      ],
                    )),
                Column(
                  children: [
                    const Text(
                      "Sexo",
                      style: styleTextSubIndice,
                    ),
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
                            Text("MACHO")
                          ],
                        )),
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
            UnitLabelInput(
              title: 'Nombre de la mascota',
              control: controllerNameOwner,
            )
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  ///

  bool? isLoading;
  File? imageFile;
  String? imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      imageFile = File(image.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        // uploadFile();
      }
    }
    // imageFile = File(pickedFile.path);
  }

  // Future uploadFile() async {
  //   Fluttertoast.showToast(
  //       msg: 'Porfavor espere mientras cargan los datos de la imagen',
  //       backgroundColor: Colors.green);

  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
  //   StorageUploadTask uploadTask = reference.putFile(imageFile);
  //   StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  //   await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
  //     imageUrl = downloadUrl;
  //     setState(() {
  //       isLoading = false;
  //       // onSendMessage(imageUrl, 1);
  //     });
  //   }, onError: (err) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: 'This file is not an image');
  //   });
  // }

  // //////////////////////////////////////////
  // CameraPosition positionMap = new CameraPosition(
  //     target: LatLng(-16.482557865279468, -68.1214064732194), zoom: 16);

  // Completer<GoogleMapController> _controller = Completer();
  // Future<void> _moveTo(CameraPosition position) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(position));
  // }
}
