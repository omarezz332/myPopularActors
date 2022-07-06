
import 'dart:math';

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
  int _page = 1;

  void morePages() async{
    if (_page <= 500) {
     _page= (_popularPerson.last.page!)+1;

    }
  }
  int get page {
for (var element in _popularPerson) {
  _page=max(_page, element.page??1);
}
return _page;
  }

  List<PopularPerson> get populars => _popularPerson;

  void updatePosts(List<PopularPerson> populars) {
    _popularPerson = [];
    _popularPerson = populars;
  }

  Future<void> getPopulars() async {
    final repositoryPopulars = await _popularRepository.getPopular();
    _popularPerson = repositoryPopulars;
  }

  Future setPopular(PopularPerson populars) async {
    if (_popularPerson.isEmpty) {
      _popularPerson.add(populars);
    } else {
      if(_popularPerson.where((element) => element.page== populars.page).isEmpty){
        _popularPerson.add(populars);
      }

    }
    //save to local storage
    await _popularRepository.setPopular(_popularPerson);
  }
}
