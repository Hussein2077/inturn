import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/matrial_widget.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_bloc.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_event.dart';
import 'package:inturn/features/home/presentation/controller/apply_bloc/get_jobs_state.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_bloc.dart';
import 'package:inturn/features/home/presentation/controller/get_my_applications/get_my_applications_event.dart';
import 'package:inturn/features/home/presentation/widgets/company_cart.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/features/home/presentation/widgets/suggested_view.dart';
import 'package:inturn/main.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.matchedVacancyWrapper});

  final MatchedVacancyWrapper matchedVacancyWrapper;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    // BlocProvider.of<VacancyBloc>(context)
    //     .add(GetVacancyDetailsEvent(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.jobsDetails.tr()),
      body: BlocListener<ApplyBloc, ApplyState>(
        listener: (context, state) {
          if (state is ApplyLoadingState) {
            EasyLoading.show();
          }
          if (state is ApplySuccessMessageState) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(state.successMessage);
            BlocProvider.of<GetMyApplicationsBloc>(context)
                .add(GetMyApplicationsEvent(MyApp.userId));
          }
          if (state is ApplyErrorMessageState) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.errorMessage);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobCart(
                skillRequired: skillRequired(
                  segments: (widget.matchedVacancyWrapper.matchedVacancy
                              .vacancySkills ??
                          [])
                      .map((e) => e.skill)
                      .toList(),
                ),
                vacancyModel: widget.matchedVacancyWrapper,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              MaterialWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: StringManager.responsibilities.tr(),
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 1.5,
                    ),
                    HtmlWidget(

                      '''${ widget.matchedVacancyWrapper.matchedVacancy
                          .responsibilities}
  ''',

                      renderMode: RenderMode.column,
                      textStyle: TextStyle(fontSize: AppSize.defaultSize! * 1.2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // CustomText(
                    //   text: widget.matchedVacancyWrapper.matchedVacancy
                    //           .responsibilities ??
                    //       "",
                    //   lineHeight: AppSize.defaultSize! * .2,
                    //   maxLines: 100,
                    //   fontSize: AppSize.defaultSize! * 1.2,
                    //   color: AppColors.primaryColor,
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              MaterialWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      text: StringManager.jobRequirements.tr(),
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 1.5,
                    ),
                    HtmlWidget(

                      '''${ widget.matchedVacancyWrapper.matchedVacancy
                          .requirements}
  ''',

                      renderMode: RenderMode.column,
                      textStyle: TextStyle(fontSize: AppSize.defaultSize! * 1.2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // CustomText(
                    //   text: widget.matchedVacancyWrapper.matchedVacancy
                    //           .requirements ??
                    //       "",
                    //   lineHeight: AppSize.defaultSize! * .2,
                    //   maxLines: 100,
                    //   fontSize: AppSize.defaultSize! * 1.2,
                    //   color: AppColors.primaryColor,
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Center(
                  child: MainButton(
                      text: StringManager.applyNow.tr(),
                      onTap: () {
                        BlocProvider.of<ApplyBloc>(context).add(ApplyEvent(
                          userID: MyApp.userId,
                          vacancyID: widget
                              .matchedVacancyWrapper.matchedVacancy.vacancyId!,
                        ));
                      })),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CompanyCart(
                width: AppSize.screenWidth,
                description: true,
                data: widget.matchedVacancyWrapper.matchedVacancy.company,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomText(
                text: StringManager.anotherSuggestedJobs.tr(),
                fontWeight: FontWeight.w700,
                fontSize: 1.6 * AppSize.defaultSize!,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              SuggestedView(
                companyId:
                    widget.matchedVacancyWrapper.matchedVacancy.companyId ?? 1,
                vacancyId:
                    widget.matchedVacancyWrapper.matchedVacancy.vacancyId!
              ),
              SizedBox(
                height: AppSize.defaultSize!,
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget skillRequired({
    required List<String?> segments,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: StringManager.skillsRequired.tr(),
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          spacing: AppSize.defaultSize! * .5,
          children: List.generate(
            segments.length,
            (index) => Container(
              margin: EdgeInsets.all(AppSize.defaultSize! * 0.5),
              height: AppSize.defaultSize! * 4.5,
              // width: widget.width??AppSize.defaultSize! * 16,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSize.defaultSize! * .8),
                child: CustomText(
                  text: segments[index] ?? "",
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
