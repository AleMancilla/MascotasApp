import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mascotas_app/pages/publish/firebase_api.dart';
import 'package:mascotas_app/utils/utils_theme.dart';
import 'package:mascotas_app/widgets/unit/unit_label_input.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

/// Enum representing the upload task types the example app supports.
enum UploadType {
  /// Uploads a randomly generated string (as a file) to Storage.
  string,

  /// Uploads a file from the device.
  file,

  /// Clears any tasks from the list.
  clear,
}

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

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
                          width: 150,
                          height: 150,
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
            ),
          ],
        ),
      ),
    );
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
        width: 150,
        height: 150,
        child: CircularProgressIndicator(),
      );
    } else {
      if (imageUrl != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/upload.png"),
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

////////
  ///
  ///
  ///
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

    print('Download-Link: $urlDownload');
  }

  // Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  //       stream: task.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final snap = snapshot.data!;
  //           final progress = snap.bytesTransferred / snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(2);

  //           return Text(
  //             '$percentage %',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           );
  //         } else {
  //           return Container();
  //         }
  //       },
  //     );
}

// class ButtonWidget extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Function onClicked;

//   const ButtonWidget({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.onClicked,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Color.fromRGBO(29, 194, 95, 1),
//           minimumSize: Size.fromHeight(50),
//         ),
//         child: buildContent(),
//         onPressed: () {
//           onClicked();
//         },
//       );

//   Widget buildContent() => Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 28),
//           SizedBox(width: 16),
//           Text(
//             text,
//             style: TextStyle(fontSize: 22, color: Colors.white),
//           ),
//         ],
//       );
// }
