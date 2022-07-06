import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_poupular_actors/models/core/popular_person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/storage_keys.dart';
import '../interfaces/i_popular_repository.dart';


final popularRepository = Provider<IPopularRepository>((ref) =>
    PopularRepository());

class PopularRepository implements IPopularRepository {
  final FlutterSecureStorage _secureStorage;



  //* Constructor
  PopularRepository() : _secureStorage = const FlutterSecureStorage();

  @override
  Future<List<PopularPerson>> getPopular() async {
    List<PopularPerson> popularPerson = [];
    try {
      final pref = await SharedPreferences.getInstance();
      if (pref.containsKey(kPopular)) {
        final extractedData = json.decode(pref.getString(kPopular)!) as List<
            dynamic>;
        for (var element in extractedData) {
          popularPerson.add(PopularPerson.fromJson(element));
        }
        return popularPerson;
      }
      return [];
    } on PlatformException {
      //await _secureStorage.delete(key: kPopular);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      return popularPerson;
    }
  }

  @override
  Future<void> setPopular(List<PopularPerson> popularPerson) async {
    final pref = await SharedPreferences.getInstance();
    String result = json.encode(popularPerson);
    pref.setString(kPopular, result);
    //await _secureStorage.write(key: kPopular, value: result);
  }
  //
  // @override
  // Future<int> getPages()async {
  //   try{
  //     final pref = await SharedPreferences.getInstance();
  //     if (pref.containsKey(kPopular)) {
  //       final extractedData = json.decode(pref.getString(kPages)!) as int;
  //       return extractedData;
  //     }
  //     return 1;
  //
  //   }on PlatformException {
  //     await _secureStorage.delete(key: kPages);
  //     return 1;
  //   }catch(e){
  //     return 1;
  //
  //   }
  //
  // }
  //
  // @override
  // Future<void> setPages(int pages)async {
  //   final pref = await SharedPreferences.getInstance();
  //   String result = json.encode(pages);
  //   pref.setString(kPages, result);
  //
  // }

}

