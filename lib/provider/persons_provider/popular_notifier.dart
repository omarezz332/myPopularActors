import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/remote/interfaces/i_populars_api.dart';
import '../../data/remote/apis/person_api.dart';
import '../../models/core/popular_person.dart';
import 'popular_state.dart';


final popularNotifierProvider =
    StateNotifierProvider<PopularNotifier, PopularState>(
  (ref) => PopularNotifier(
    ref.read(popularApiProvider),
  ),
);

class PopularNotifier extends StateNotifier<PopularState> {
  final IPopularApi _api;

  PopularNotifier(
    this._api,
  ) : super(const PopularInitial());

  Future<void> init() async {
    state=  const PopularLoading();
    PopularPerson popularPerson= await _api.getPopulars();
 print('popularPerson: ${popularPerson.results?.length}');

    state = PopularGot();

  }

}
