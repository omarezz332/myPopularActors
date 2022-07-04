import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/remote/interfaces/i_populars_api.dart';
import 'package:my_poupular_actors/models/core/popularImages.dart';
import '../../data/remote/apis/person_api.dart';
import '../../models/core/personDetails.dart';
import '../../models/core/popular_person.dart';
import 'details_state.dart';


final detailsNotifierProvider =
    StateNotifierProvider<DetailsNotifier, DetailsState>(
  (ref) => DetailsNotifier(
    ref.read(popularApiProvider),
  ),
);

class DetailsNotifier extends StateNotifier<DetailsState> {
  final IPopularApi _api;

  DetailsNotifier(
    this._api,
  ) : super(const DetailsInitial());



  Future<PersonDetails?> getPopularsDetails(int personId) async {
    state=   const DetailsLoading();
    PersonDetails personDetails= await _api.getPopularsDetails(personId);
 print('popularPerson: ${personDetails.name}');
    state = const DetailsGot();
    return personDetails;

  }
  Future<PopularImage?> getPopularsImage(int personId) async {
    state=  const DetailsLoading();
    PopularImage popularImage= await _api.getPopularsImage(personId);
    print('popularPerson: ${popularImage.profiles?.length}');
    state = const DetailsGot();
    return popularImage;

  }
}
