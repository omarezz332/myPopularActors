
import '../../../models/core/popular_person.dart';

abstract class IPopularRepository {
  Future<List<PopularPerson>> getPopular();
  Future<void> setPopular(List<PopularPerson> popularPerson);
}
