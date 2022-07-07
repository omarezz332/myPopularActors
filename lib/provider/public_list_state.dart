abstract class NormalListState{


  const NormalListState();
}

class NormalListInitialState extends NormalListState{

  const NormalListInitialState();
}
class NormalListLoadingState extends NormalListState{

  const NormalListLoadingState();
}
class NormalListErrorState extends NormalListState{
  final String message;

  const NormalListErrorState(this.message);

}
