
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/local/interfaces/i_popular_repository.dart';
import 'package:my_poupular_actors/models/core/popular_person.dart';
import '../../data/local/repositories/posts_repository.dart';



final postsRepositoryProvider = ChangeNotifierProvider(
      (ref) => PostsRepositoryProvider(ref.read(postsRepository)),
);

class PostsRepositoryProvider extends ChangeNotifier {
  final IPopularRepository _popularRepository;

  PostsRepositoryProvider(this._popularRepository);

  List<PopularPerson> _popularPerson = [];

  List<PopularPerson> get populars => _popularPerson;

  void updatePosts(List<PopularPerson> populars) {
    _popularPerson = [];
    _popularPerson = populars;
  }

  Future<List<PopularPerson>> getPopulars() async {
    final repositoryPopulars = await _popularRepository.getPopular();
    if (repositoryPopulars != '') {
      _popularPerson = repositoryPopulars;
      return _popularPerson;
    }
    return [];
  }

  Future setPopular(PopularPerson populars) async {
    if (_popularPerson.isEmpty) {
      _popularPerson = [];
      _popularPerson.add(populars);
      notifyListeners();
    }
    else {
      _popularPerson.add(populars);
      notifyListeners();
    }
    await _popularRepository.setPopular(_popularPerson);
  }
}
