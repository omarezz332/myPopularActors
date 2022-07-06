import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/remote/interfaces/i_populars_api.dart';
import 'package:my_poupular_actors/provider/persons_provider/populars_repository_provider.dart';
import '../../data/remote/apis/person_api.dart';
import '../../helpers/checkInternet.dart';
import '../../models/core/popular_person.dart';
import 'popular_state.dart';

final popularNotifierProvider =
    StateNotifierProvider<PopularNotifier, PopularState>(
  (ref) => PopularNotifier(
    ref.read(popularApiProvider),
    ref.read(popularsRepositoryProvider),
  ),
);

class PopularNotifier extends StateNotifier<PopularState> {
  final IPopularApi _api;
  final PopularRepositoryProvider _popularProvider;

  PopularNotifier(
    this._api,
    this._popularProvider,
  ) : super(const PopularInitial());

  Future<void> init() async {
    state = const PopularLoading();
    //check connection and if there no internet we will get our data from local storage
    if (await CheckInternet.checkInternetConnection()) {
      //load data from remote
      PopularPerson popularPerson =
          await _api.getPopulars(await _popularProvider.page);
      await _popularProvider.setPopular(popularPerson);
    } else {
      //get data from locale.
      await _popularProvider.getPopulars();
    }
    state = const PopularGot();
  }

  Future<void> getMorePopulars() async {
    //get more populars from remote
    state = const PopularLoading();
    _popularProvider.morePages();
    PopularPerson popularPerson = await _api.getPopulars( _popularProvider.page);
    await _popularProvider.setPopular(popularPerson);
    state = const PopularGot();
  }
}
