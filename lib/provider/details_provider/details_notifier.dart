import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/data/remote/interfaces/i_populars_api.dart';
import 'package:my_poupular_actors/models/core/popularImages.dart';
import '../../data/remote/apis/person_api.dart';
import '../../models/core/personDetails.dart';
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
    try{
      state=   const DetailsLoading();
      PersonDetails personDetails= await _api.getPopularsDetails(personId);
      state = const DetailsGot();
      return personDetails;
    }on SocketException{
      state =  const DetailsError( 'No internet connection');
    }catch(e){
      state =  const DetailsError( 'something went wrong');
    }


  }
  Future<PopularImage?> getPopularsImage(int personId) async {
    try{
      state=  const DetailsLoading();
      PopularImage popularImage= await _api.getPopularsImage(personId);
      state = const DetailsGot();
      return popularImage;

    }on SocketException{
      state =  const DetailsError( 'No internet connection');
    }catch(e){
      state =  const DetailsError( 'something went wrong');
    }

  }
}
