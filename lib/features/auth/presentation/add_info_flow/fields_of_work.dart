import 'package:custom_accordion/custom_accordion.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/widgets/multi_segment.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_bloc.dart';
import 'package:inturn/features/home/presentation/controller/top_five_and_blogs/get_top_five_state.dart';

class FieldsInfo extends StatefulWidget {
  const FieldsInfo({super.key});

  @override
  State<FieldsInfo> createState() => _FieldsInfoState();
}

class _FieldsInfoState extends State<FieldsInfo> {

  List <int>  _currentSegment = [-1];

  void _onValueChanged( List <int> newValue) {
    setState(() {
      _currentSegment = newValue;
    });
  }

  Widget closeIcon = Transform.rotate(
    angle: 180 * 3.14 / 180,
    child: SvgPicture.asset(
      AssetPath.collapsed,
    ),
  );

  Widget openIcon = SvgPicture.asset(
    AssetPath.collapsed,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.fieldsOfWork.tr()),

      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetMajorBloc, GetTopFiveState >(
              builder: (context, state) {
                if (state is GetMajorLoadingState) {
                  return const Center(child: LoadingWidget());
                } 
           else     if (state is GetMajorSuccessMessageState) {
                  return ListView.builder(
                      itemCount: state.topFiveModel.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomAccordion(
                          title: state.topFiveModel[index].field  ,
                          showContent: true,
                          headerBackgroundColor: Colors.transparent,
                          titleStyle: TextStyle(
                            color: AppColors.thirdColor,
                            fontSize: AppSize.defaultSize! * 1.4,
                            fontWeight: FontWeight.w400,
                          ),
                          toggleIconOpen: openIcon,
                          toggleIconClose: closeIcon,
                          headerIconColor: AppColors.primaryColor,
                          accordionElevation: 0,
                          widgetItems: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MultiSegmentedButton(
                                segments:state.topFiveModel[index].positions.map((position) => position.majorNameEn).toList(),
                                onValueChanged: (index) => _onValueChanged( index),
                                width: AppSize.defaultSize! * 16,
                              ),
                            ],
                          ),
                        );
                      });
                }

                return const SizedBox();

              },
            ),


          ],
        ),
      ),


    );
  }

  fieldsRow({required String text}) {
    return Padding(
      padding: EdgeInsets.all(AppSize.defaultSize!),
      child: Row(children: [
        CustomText(text: text, color: AppColors.thirdColor),
        Spacer(),
        SvgPicture.asset(
          AssetPath.collapsed,
        )
      ]),
    );
  }
}
/*
   body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fieldsRow(text: 'Accounting/Finance Jobs'),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomSegmentedButton(
              segments: const [
                'Internal Audit',
                'Internal Audit',
                'Internal Audit'
              ],
              onValueChanged: (index) => _onValueChanged(index),
              width: AppSize.defaultSize! * 16,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 4,
            ),
            fieldsRow(text: 'Accounting/Finance Jobs'),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomSegmentedButton(
              segments: const [
                'Internal Audit',
                'Internal Audit',
                'Internal Audit'
              ],
              onValueChanged: (index) => _onValueChanged(index),
              width: AppSize.defaultSize! * 16,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 4,
            ),
            fieldsRow(text: 'Accounting/Finance Jobs'),
            SizedBox(
              height: AppSize.defaultSize! * 1.6,
            ),
            CustomSegmentedButton(
              segments: const [
                'Internal Audit',
                'Internal Audit',
                'Internal Audit'
              ],
              onValueChanged: (index) => _onValueChanged(index),
              width: AppSize.defaultSize! * 16,
            ),
            SizedBox(
              height: AppSize.defaultSize! * 4,
            ),
            MainButton(
              text: StringManager.next.tr(),
              onTap: () {
                if (true) {
                  Navigator.pushNamed(context, Routes.skillsInfo);
                } else {
                  errorSnackBar(
                      context, StringManager.pleaseCompleteYourData.tr());
                }
              },
            ),
          ],
        ),
      )
 */
/*
         icon:
            widget.showContent?(widget.toggleIconClose ?? Icon(Icons.arrow_drop_up,           color:
            widget.headerIconColor ?? Theme.of(context).iconTheme.color,)):
            (widget.toggleIconOpen ?? Icon(Icons.arrow_drop_down,           color:
            widget.headerIconColor ?? Theme.of(context).iconTheme.color,)),
 */