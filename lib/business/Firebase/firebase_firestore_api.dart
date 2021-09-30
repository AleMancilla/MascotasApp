// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mascotas_app/business/objects/pet_publish.dart';

class FirebaseFirestoreApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference petCollection =
      FirebaseFirestore.instance.collection('Pets');

  Future<bool> addPetPublish(PetPublish pet) {
    print(' ====> entro a enviar datos');
    return petCollection
        .add({
          'descriptionPet': pet.descriptionPet,
          'nameOwner': pet.nameOwner,
          'namePet': pet.namePet,
          'numberOwner': pet.numberOwner,
          'dateState': pet.dateState,
          'hourState': pet.hourState,
          'imageUrl': pet.imageUrl,
          'sizePetText': pet.sizePetText,
          'raza': pet.raza,
          'sex': pet.sex,
          'position': pet.position,
          'type': pet.type.toString()
        })
        .then((value) => true)
        .catchError((error) {
          print('===========================================');
          print(error);
          return false;
        })
        .timeout(
          const Duration(seconds: 8),
          onTimeout: () => false,
        );
  }
}
