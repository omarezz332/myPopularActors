import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/helpers/extensions.dart';
import '../../helpers/extensions.dart';
import '../../models/core/personDetails.dart';
import '../../models/core/popular_person.dart';
import '../../provider/details_provider/details_notifier.dart';
import '../../provider/details_provider/details_state.dart';
import '../../provider/persons_provider/popular_notifier.dart';
import '../../provider/persons_provider/popular_state.dart';
import '../widgets/custom_loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final Results popularPerson;

  DetailsScreen({Key? key, required this.popularPerson}) : super(key: key);

  @override
  ConsumerState<DetailsScreen> createState() => _DetailseState();
}

class _DetailseState extends ConsumerState<DetailsScreen> {
  var state;

  var personDetails;

  bool once = true;

  @override
  void didChangeDependencies() {
    if (once) {
      ref
          .watch(detailsNotifierProvider.notifier)
          .getPopularsDetails(widget.popularPerson.id!)
          .then((value) => personDetails = value );
    //  state = ref.read(popularNotifierProvider.notifier).state;
      // popularPersons=ref.read(popularNotifierProvider.notifier).popularPerson;
      once = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var loading = ref.watch(detailsNotifierProvider) is DetailsLoading;

    return Scaffold(
      body: loading
          ? const Center(child: CustomLoadingWidget())
          : _buildDetailsWidget(personDetails, widget.popularPerson),
    );
  }

  _buildDetailsWidget(PersonDetails personDetails, Results popularPerson) {
    return Stack(
      children: [
        // Custom scrollview provides us a custom control over scroll view
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sliverappbar is used to make a portion of screen scrollable and shrink when scrolled and get back the shape when rset.
            SliverAppBar(
              expandedHeight: 300.h,
              backgroundColor: context.theme.primaryColor,
              pinned: true,
              snap: false,
              floating: true,
              primary: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://dynaimage.cdn.cnn.com/cnn/q_auto,w_412,c_fill,g_auto,h_412,ar_1:1/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F200617105143-emma-watson-little-women-120719.jpg"),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Colors.black,
                          Colors.black.withOpacity(0.3)
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Emma Watson",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "240K Followers",
                                style: TextStyle(
                                  color: Colors.grey[300]?.withOpacity(0.7),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // This will be having the list of all the items which won't be shrinked or expanded on scrolling
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Emma Charlotte Duerre Watson was born in Paris, France, to English parents, Jacqueline Luesby and Chris Watson, both lawyers. She moved to Oxfordshire when she was five, where she attended the Dragon School.",
                      style: TextStyle(height: 1.4, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Born",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "April, 15th 1990, Paris, France",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Nationality",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "British",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Videos",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Emma Charlotte Duerre Watson was born in Paris, France, to English parents, Jacqueline Luesby and Chris Watson, both lawyers. She moved to Oxfordshire when she was five, where she attended the Dragon School.",
                      style: TextStyle(height: 1.4, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Born",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "April, 15th 1990, Paris, France",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Nationality",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "British",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Videos",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Emma Charlotte Duerre Watson was born in Paris, France, to English parents, Jacqueline Luesby and Chris Watson, both lawyers. She moved to Oxfordshire when she was five, where she attended the Dragon School.",
                      style: TextStyle(height: 1.4, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Born",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "April, 15th 1990, Paris, France",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Nationality",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "British",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Videos",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ]))
          ],
        ),
      ],
    );
  }
//  Widget buildNowPlayingWidget(PopularPerson? data) {
//    List<Results>? popular = data?.results;
//
//    if (popular?.length == 0) {
//      return Container(
//        width: MediaQuery.of(context).size.width,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Text("No Movies"),
//          ],
//        ),
//      );
//    } else {
//      return _popularList(popular);
//    }
//  }
// Widget _popularList( List<Results>? popular){
//    return ListView.builder(
//      scrollDirection: Axis.vertical,
//      itemCount: popular?.length,
//      itemBuilder: (context, index) {
//        return InkWell(
//          onTap: () {
//            // Navigator.push(
//            //     context,
//            //     MaterialPageRoute(
//            //       builder: (context) => DetailsMovieScreen(popular[index]),
//            //     ));
//          },
//          child: Stack(
//            children: [
//              Container(
//                height: 220.0.h,
//                width: MediaQuery.of(context).size.width,
//                decoration: BoxDecoration(
//                  shape: BoxShape.rectangle,
//                  image: DecorationImage(
//                    image: NetworkImage(
//                      "https://image.tmdb.org/t/p/original/" +
//                          "${popular?[index].profilePath}",
//                    ),
//                    fit: BoxFit.fitWidth,
//                  ),
//                ),
//              ),
//              // FavouriteInList(
//              //   movie: movies[index],
//              // ),
//              Container(
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    colors: [
//                      context.theme.primaryColor.withOpacity(0.8),
//                      context.theme.primaryColor.withOpacity(0.0),
//                    ],
//                    begin: Alignment.bottomCenter,
//                    end: Alignment.topCenter,
//                    stops: const [
//                      0.0,
//                      0.9,
//                    ],
//                  ),
//                ),
//              ),
//              Positioned(
//                bottom: 0.0.h,
//                child: Container(
//                  width: MediaQuery.of(context).size.width,
//                  color: Colors.black.withOpacity(0.6),
//                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Text(
//                        popular?[index].name ?? "",
//                        style: TextStyle(
//                          height: 1.5,
//                          color: Colors.white,
//                          fontWeight: FontWeight.w900,
//                          fontSize: 16.0,
//                        ),
//                      ),
//                      Text(
//                        popular?[index].knownForDepartment ?? "",
//                        style: TextStyle(
//                          height: 1.5,
//                          color: Colors.white,
//                          fontWeight: FontWeight.w900,
//                          fontSize: 12.0,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Positioned(
//                bottom: 0.0.h,
//                left: MediaQuery.of(context).size.width * 0.6,
//                child: Container(
//                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                      Icon(
//                          Icons.star_rate,
//                          color: context.theme.colorScheme.secondary
//                      ),
//                      Text(
//                        "${popular?[index].popularity ?? 0}",
//                        style: const TextStyle(
//                          height: 1.5,
//                          color: Colors.white,
//                          fontWeight: FontWeight.w600,
//                          fontSize: 18.0,
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),
//        );
//      },
//    );
// }
}
