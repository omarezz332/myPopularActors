import 'dart:io';

import '../../../models/core/personDetails.dart';
import '../../../models/core/popularImages.dart';
import '../../../models/core/popular_person.dart';


abstract class IPopularApi {
  Future<PopularPerson> getPopulars();
  Future<PersonDetails> getPopularsDetails(int personId);
  Future<PopularImage> getPopularsImage(int personId);

}
