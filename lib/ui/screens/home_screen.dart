import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in_down.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/helpers/extensions.dart';
import 'package:my_poupular_actors/helpers/sized_boxes.dart';
import '../../helpers/extensions.dart';
import '../../helpers/storage_keys.dart';
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
  List<PopularPerson> popularPersons = [];
  bool once = true;
  late int page ;

  @override
  void didChangeDependencies() {
    if (once) {
      Future.delayed(const Duration(milliseconds: 1), ()async {
        ref.read(popularNotifierProvider.notifier).init();

      });
//get page number
      once = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    popularPersons = ref.watch(popularsRepositoryProvider.notifier).populars;
    var loading = ref.watch(popularNotifierProvider) is PopularLoading;
    page=( ref.watch(popularsRepositoryProvider.notifier).page);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                    "${page * kPopularNumber } Persons")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                    "$page Pages Loaded")),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CustomLoadingWidget())
          : buildNowPlayingWidget(popularPersons),
    );
  }

  Widget buildNowPlayingWidget(List<PopularPerson> data) {
    List<Results> popular = [];
    for (var element in data) {
      element.results?.forEach((element) {
        popular.add(element);
      });
    }
    popular = getPopularsSorted(popular);

    if (popular.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("No Movies",),
          ],
        ),
      );
    } else {
      return _popularList(popular);
    }
  }

  Widget _popularList(List<Results>? popular) {
    return SafeArea(
      child: Stack(
        children: [
          BounceInDown(

            child: RefreshIndicator(

              onRefresh: _pullRefresh,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: popular?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(DetailsRoute(
                        popularPerson: popular![index],
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0,right: 5,left: 5),
                      child: Stack(
                        children: [
                          Container(
                            height: 270.0.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                  NetworkImage(
                                      "https://image.tmdb.org/t/p/w500/${popular?[index].profilePath}",
                                ),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0.h,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                            //  color: Colors.black.withOpacity(0.3),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),

                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    popular?[index].name ?? "",
                                    style: const TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    popular?[index].knownForDepartment ?? "",
                                    style: const TextStyle(
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
                                  Icon(Icons.star_rate,
                                      color: context.theme.colorScheme.secondary),
                                  kHorizontalSizedBoxXXSmall,
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
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          context.theme.colorScheme.secondary,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          context.theme.colorScheme.primary,
                        ),
                      ),
                      onPressed: () {
                        getMorePopulars();
                      },
                      icon: const Icon(Icons.assured_workload),
                      label: const Text(
                        "Load More..",
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  getMorePopulars() {
    ref.read(popularNotifierProvider.notifier).getMorePopulars();
  }

  List<Results> getPopularsSorted(List<Results> popular) {
    popular.sort((a, b) => b.id!.compareTo(a.id!));
    return popular;
  }

  Future<void> _pullRefresh() async {
    ref.read(popularNotifierProvider.notifier).init();
  }
}
