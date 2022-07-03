import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/helpers/extensions.dart';
import '../../helpers/extensions.dart';
import '../../models/core/popular_person.dart';
import '../../provider/persons_provider/popular_notifier.dart';
import '../../provider/persons_provider/popular_state.dart';
import '../../provider/persons_provider/populars_repository_provider.dart';
import '../../router/custom_router.gr.dart';
import '../widgets/custom_loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  var state ;
   List<PopularPerson> popularPersons=[] ;

  bool once=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
if(once){
   ref.read(popularNotifierProvider.notifier).init();

  state=ref.read(popularNotifierProvider.notifier).state;
 // popularPersons=ref.read(popularNotifierProvider.notifier).popularPerson;
  once=false;
}  super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    popularPersons= ref.watch(popularsRepositoryProvider.notifier).populars;
    var loading = ref.watch(popularNotifierProvider) is PopularLoading ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: loading ? const Center(child: CustomLoadingWidget())
          : buildNowPlayingWidget(popularPersons ),

    );
  }
  Widget buildNowPlayingWidget(List<PopularPerson> data) {
    List<Results> popular= [];
    log("${data.length}");
    data.forEach((element) {
      element.results?.forEach((element) {
        popular.add(element);
      });
    });

    if (popular.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Movies"),
          ],
        ),
      );
    } else {
      return _popularList(popular);
    }
  }
 Widget _popularList( List<Results>? popular){
    return Stack(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: popular?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                AutoRouter.of(context).push(
                    DetailsRoute(
                      popularPerson:  popular![index],
                    )
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 220.0.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/original/" +
                              "${popular?[index].profilePath}",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  // FavouriteInList(
                  //   movie: movies[index],
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.theme.primaryColor.withOpacity(0.8),
                          context.theme.primaryColor.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [
                          0.0,
                          0.9,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0.h,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popular?[index].name ?? "",
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            popular?[index].knownForDepartment ?? "",
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0.h,
                    left: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.star_rate,
                              color: context.theme.colorScheme.secondary
                          ),
                          Text(
                            "${popular?[index].popularity ?? 0}",
                            style: const TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        ElevatedButton.icon(onPressed:(){


        }, icon: , label: ),
      ],
    );
 }
}
