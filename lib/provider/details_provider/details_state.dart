
import 'package:my_poupular_actors/models/core/popular_person.dart';

import '../../models/core/personDetails.dart';

abstract class DetailsState {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsGot extends DetailsState {
  const DetailsGot();


}

