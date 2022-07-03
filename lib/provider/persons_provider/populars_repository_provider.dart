
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/local/interfaces/i_popular_repository.dart';
import 'package:my_poupular_actors/models/core/popular_person.dart';
import '../../data/local/repositories/posts_repository.dart';



final popularsRepositoryProvider = ChangeNotifierProvider(
      (ref) => PopularRepositoryProvider(ref.read(popularRepository)),
);

class PopularRepositoryProvider extends ChangeNotifier {
  final IPopularRepository _popularRepository;

  PopularRepositoryProvider(this._popularRepository);

  List<PopularPerson> _popularPerson = [];

  List<PopularPerson> get populars => _popularPerson;

  void updatePosts(List<PopularPerson> populars) {
    _popularPerson = [];
    _popularPerson = populars;
  }

  Future<void> getPopulars() async {
    log("tryGetPopulars");
    final repositoryPopulars = await _popularRepository.getPopular();
    log("getPopulars ${repositoryPopulars.length}");
    if (repositoryPopulars != '') {
      _popularPerson = repositoryPopulars;
    }
  }

  Future setPopular(PopularPerson populars) async {
    if (_popularPerson.isEmpty) {
      _popularPerson = [];
      _popularPerson.add(populars);

    }
    else {
      _popularPerson.add(populars);

    }
    notifyListeners();
    await _popularRepository.setPopular(_popularPerson);
  }
}
