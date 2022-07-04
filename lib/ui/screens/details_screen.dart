import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/helpers/extensions.dart';
import 'package:my_poupular_actors/router/custom_router.gr.dart';
import 'package:my_poupular_actors/theme/dimensions.dart';
import '../../helpers/extensions.dart';
import '../../helpers/sized_boxes.dart';
import '../../models/core/personDetails.dart';
import '../../models/core/popularImages.dart';
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

  late PersonDetails personDetails = PersonDetails();
  late PopularImage popularImage = PopularImage();
  bool once = true;

  @override
  void didChangeDependencies() {
    if (once) {
      Future.delayed(Duration(milliseconds: 1), ()async {
        personDetails= (await ref
            .watch(detailsNotifierProvider.notifier)
            .getPopularsDetails(widget.popularPerson.id!))!;
        popularImage= (await ref
            .watch(detailsNotifierProvider.notifier)
            .getPopularsImage(widget.popularPerson.id!))!;
      });

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
    return  CustomScrollView(
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
              //  bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500/${popularPerson.profilePath}"),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.1)
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${popularPerson.name}",
                        style:  TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "${popularPerson.knownForDepartment}",
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
                      "${personDetails.biography}",
                      style:context.theme.textTheme.button?.copyWith(
                        fontSize: 17.sp,
                        height: 1.5,
                      ),
                    ),
                    kVerticalSizedBoxMedium,
                    const Text(
                      "Born",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    kVerticalSizedBoxXSmall,
                    Text(
                        "${personDetails.birthday??"Not Available"}",
                        style: context.textTheme.button
                    ),
                    kVerticalSizedBoxMedium,
                    Text(
                      "Nationality",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    kVerticalSizedBoxXSmall,
                    Text(
                        "${personDetails.placeOfBirth??"USA"}",
                        style: context.textTheme.button
                    ),
                  ],
                ),
              )
            ])),
        getImages(),

      ],
    );
  }

 Widget getImages() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Images",
                style: context.theme.textTheme.button?.copyWith(
                  fontSize: 17.sp,
                  height: 1.5,
                ),
              ),
              kVerticalSizedBoxMedium,
              Container(
                height: 150.h,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularImage.profiles?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).push(ImageViewRoute(
                        imageUrl:  "https://image.tmdb.org/t/p/w500/${popularImage.profiles?[index].filePath}",
                          ));
                        },
                        child: Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500/${popularImage.profiles?[index].filePath}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
 }

