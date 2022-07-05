import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down_big.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up_big.dart';
import 'package:flutter_animator/widgets/zooming_entrances/zoom_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_poupular_actors/helpers/extensions.dart';
import 'package:my_poupular_actors/router/custom_router.gr.dart';
import '../../helpers/extensions.dart';
import '../../helpers/sized_boxes.dart';
import '../../models/core/personDetails.dart';
import '../../models/core/popularImages.dart';
import '../../models/core/popular_person.dart';
import '../../provider/details_provider/details_notifier.dart';
import '../../provider/details_provider/details_state.dart';
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
      Future.delayed(const Duration(milliseconds: 1), ()async {
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: loading
            ? const Center(child: CustomLoadingWidget())
            : _buildDetailsWidget(),
      ),
    );
  }

  _buildDetailsWidget() {
    return  CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Sliverappbar is used to make a portion of screen scrollable and shrink when scrolled and get back the shape when rset.
       getPopularCover(),
        // This will be having the list of all the items which won't be shrinked or expanded on scrolling
       getPopularDescription() ,
        getPopularImages(),

      ],
    );
  }



 Widget getPopularDescription() {
    return SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.all(20),
            child: FadeInDownBig(
              preferences: AnimationPreferences(
                duration: Duration(milliseconds: 400),
              ),
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
            ),
          )
        ]));
 }
 Widget getPopularCover() {
 return  SliverAppBar(
     expandedHeight: 300.h,
     backgroundColor: context.theme.primaryColor,
     elevation: 5 ,
     //   title: Text(popularPerson.name?? ""),

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
       centerTitle: true,
       title: ZoomIn(
           child: Text(widget.popularPerson.name?? "",style: TextStyle(color: context.colorScheme.secondary,fontSize: 20,fontWeight: FontWeight.bold),)),
       collapseMode: CollapseMode.pin,
       background: FadeInUpBig(
         preferences: const AnimationPreferences(
           duration: Duration(milliseconds: 400),
         ),
         child: Container(
           decoration: BoxDecoration(
             shape: BoxShape.rectangle,
             border: Border.all(
               //color: context.colorScheme.secondary,
               width: 1,
             ),
             borderRadius: BorderRadius.circular(30),
             image: DecorationImage(
               fit: BoxFit.fill,
               filterQuality: FilterQuality.high,



               image: NetworkImage(
                   "https://image.tmdb.org/t/p/w500/${widget.popularPerson.profilePath}"),
             ),
           ),
           child: Container(
             decoration: BoxDecoration(
               borderRadius: const BorderRadius.only(
                 bottomLeft: Radius.circular(30),
                 bottomRight: Radius.circular(30),
               ),
               gradient: LinearGradient(
                 begin: Alignment.bottomCenter,
                 end: Alignment.topCenter,
                 colors: <Color>[
                   context.colorScheme.primary.withOpacity(0.5),
                   context.colorScheme.primary.withOpacity(0.2),
                 ],
               ),
             ),
             child: Padding(
               padding: EdgeInsets.all(20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   kVerticalSizedBoxMedium,
                   Row(
                     children: [
                       Text(
                         "${widget.popularPerson.knownForDepartment}",
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
   );
 }
 Widget getPopularImages() {
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
                  physics: const ScrollPhysics().applyTo(
                    const BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: popularImage.profiles?.length,
                  itemBuilder: (context, index) {
                    return Hero(
                      placeholderBuilder: (context, size, _) {
                        return Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.grey[800],
                        );
                      },
                      transitionOnUserGestures: true,
                     // key: Key("${popularImage.id}"),
                      tag: index,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            AutoRouter.of(context).push(ImageViewRoute(
                              imageUrl:  "https://image.tmdb.org/t/p/w500/${popularImage.profiles?[index].filePath}",
                              id: index ,
                            ));
                          },
                          child: ZoomIn(
                            preferences: const AnimationPreferences(
                              duration: Duration(milliseconds: 400),
                            ),
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

