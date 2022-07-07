import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/models/core/personDetails.dart';
import 'package:my_poupular_actors/models/core/popularImages.dart';
import 'package:my_poupular_actors/models/core/popular_person.dart';

import 'package:http/http.dart' as http;

import '../endpoints.dart';
import '../interfaces/i_populars_api.dart';
//get populars from remote
final popularApiProvider = Provider<IPopularApi>(
      (ref) => PopularApi(),
);

class PopularApi implements IPopularApi {

  PopularApi();
  @override
  Future<PopularPerson> getPopulars(int page)async {
    final url = Uri.parse(kAllPopular(page));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    final popularPerson = PopularPerson.fromJson(json.decode(response.body) as Map<String, dynamic>);
  return popularPerson;
  }

  @override
  Future<PersonDetails> getPopularsDetails(int personId) async{
    final url = Uri.parse(kPopularDetails(personId));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    final personDetails = PersonDetails.fromJson(json.decode(response.body) as Map<String, dynamic>);
    return personDetails;

  }

  @override
  Future<PopularImage> getPopularsImage(int personId) async{
    final url = Uri.parse(kPopularImage(personId));
    final response =await http.get(url).timeout(const Duration(seconds: 10));
    final popularImage = PopularImage.fromJson(json.decode(response.body) as Map<String, dynamic>);
    return popularImage;
  }

}
