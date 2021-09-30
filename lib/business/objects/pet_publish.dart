import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mascotas_app/pages/publish/post_pet.dart';

class PetPublish {
  String descriptionPet;
  String nameOwner;
  String namePet;
  String numberOwner;
  String dateState;
  String hourState;
  String imageUrl;
  String sizePetText;
  String raza;
  String sex;
  String direction;
  String city;
  GeoPoint position;
  typePost type;

  PetPublish({
    required this.descriptionPet,
    required this.nameOwner,
    required this.namePet,
    required this.numberOwner,
    required this.dateState,
    required this.hourState,
    required this.imageUrl,
    required this.sizePetText,
    required this.raza,
    required this.sex,
    this.direction = '',
    this.city = '',
    required this.position,
    required this.type,
  });
}
