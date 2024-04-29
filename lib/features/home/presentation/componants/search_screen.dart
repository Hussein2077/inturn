import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/home/presentation/componants/filters_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context, text: StringManager.searchResults.tr()),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 2),
        child: Column(
          children: [
            Center(
              child: CustomTextField(
                controller: searchController,
                hintText: StringManager.searchForJobs.tr(),
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.3,
                    color: AppColors.greyColor),
                suffixIcon: MainButton(
                    text: StringManager.search.tr(),
                    width: AppSize.defaultSize! * 10,
                    padding: AppSize.defaultSize! * .5,
                    onTap: () {

                    },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "47 ${StringManager.jobFound.tr()}",
                    style: TextStyle(
                      fontSize: AppSize.defaultSize! * 1.8,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const FiltersScreen(),
                        withNavBar: false,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCDEE3),
                        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2.5, vertical: AppSize.defaultSize! * 1),
                        child: Row(
                          children: [
                            const Icon(Icons.filter_list_outlined, color: AppColors.blackColor,),
                            SizedBox(width: AppSize.defaultSize! * 1,),
                            Text(
                              StringManager.filter.tr(),
                              style: TextStyle(
                                fontSize: AppSize.defaultSize! * 1.8,
                                color: AppColors.blackColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BlocBuilder<HomeBloc, HomeState >(
            //   builder: (context, state) {
            //     if(state is GetMatchedVacancyLoadingState){
            //       return const LoadingWidget() ;
            //     }
            //     else if(state is GetMatchedVacancySuccessMessageState){
            //       return ListView.builder(
            //           itemCount: 10,
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemBuilder: (item, index) {
            //             return Padding(
            //               padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
            //               child:   JobCart(vacancyModel: state.vacancyModel[index],).animate()
            //                   .fadeIn() // uses `Animate.defaultDuration`
            //                   .scale() // inherits duration from fadeIn
            //                   .move(delay: 300.ms, duration: 600.ms),
            //             );
            //           });
            //     }
            //     else if(state is GetMatchedVacancyErrorMessageState){
            //       return ErrorWidget(  state.errorMessage);
            //     }
            //     else {
            //       return const SizedBox();
            //     }
            //   },
            // ),
            SizedBox(
              height: AppSize.defaultSize!,
            ),
          ],
        ),
      ),
    );
  }
}
