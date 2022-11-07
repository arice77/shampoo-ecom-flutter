import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return firebaseFirestore.collection('products').snapshots();
  }

  Future setFav(String documentPath, bool fav) async {
    await firebaseFirestore.doc('products/$documentPath').update({'Fav': fav});
  }

  Future placeOrder(String prodName, String cartNo, String price,
      BuildContext context) async {
    await firebaseFirestore
        .collection('users/${firebaseAuth.currentUser!.uid}/order')
        .add({'Product': prodName, 'Quantity': cartNo, 'price': price});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Item add')));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrder() {
    return firebaseFirestore
        .collection('users/${firebaseAuth.currentUser!.uid}/order')
        .snapshots();
  }
}
