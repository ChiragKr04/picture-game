import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:picture_game/models/firebase_model.dart';
import 'package:picture_game/models/picture_model.dart';

abstract class FirebaseService {
  Future<bool> addWordData({required Map<String, dynamic> data});
  Future<List<FirebaseModel>> fetchWordsData();
}

class FlirebaseServiceImpl extends FirebaseService {
  final _wordDbRef = FirebaseFirestore.instance.collection('word-db');
  @override
  Future<bool> addWordData({required Map<String, dynamic> data}) async {
    return await _wordDbRef.add(data).then(
      (value) {
        log("data added ${value.toString()}");
        return true;
      },
    ).catchError(
      (error) {
        log("error adding data ${error.toString()}");
        return false;
      },
    );
  }

  @override
  Future<List<FirebaseModel>> fetchWordsData() async {
    List<FirebaseModel> fetchedData = [];
    await _wordDbRef.get().then((value) {
      for (var doc in value.docs) {
        fetchedData.add(
          FirebaseModel(
            word: doc["word"].toString(),
            results: List<Result>.from(
              doc["results"].map(
                (x) => Result.fromJson(x),
              ),
            ),
          ),
        );
      }
      return value;
    });
    return fetchedData;
  }
}
