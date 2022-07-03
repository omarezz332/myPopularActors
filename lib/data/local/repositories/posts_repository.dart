import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_poupular_actors/models/core/popular_person.dart';
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
      final hasKey = await _secureStorage.containsKey(key: kPopular);
      if (hasKey) {
        final String? _posts = await _secureStorage.read(key: kPopular);
        log("hasPosts: $_posts");
        final List<dynamic> extractedData = json.decode(_posts!);
      //  debugPrint("hasPosts: $extractedData");
        extractedData.forEach((element) {
          popularPerson.add(PopularPerson.fromJson(element));
        });
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
    String result = json.encode(popularPerson);
    log('result: $result');
    await _secureStorage.write(key: kPopular, value: result);
  }

}

