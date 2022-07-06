import 'dart:io';

import '../../../models/core/personDetails.dart';
import '../../../models/core/popularImages.dart';
import '../../../models/core/popular_person.dart';

// an interface for the local storage
abstract class IPopularApi {
  Future<PopularPerson> getPopulars(int page);
  Future<PersonDetails> getPopularsDetails(int personId);
  Future<PopularImage> getPopularsImage(int personId);

}
