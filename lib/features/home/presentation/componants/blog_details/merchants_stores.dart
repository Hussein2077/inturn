import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';

class MerchantsStores extends StatelessWidget {
  const MerchantsStores(
      {super.key, required this.merchants, this.blog = false});

  final Merchants merchants;
  final bool blog;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.screenWidth! * .9,
      // height: AppSize.defaultSize! * 10.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.defaultSize!)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize!),
                child: Image.asset(
                  merchants.image,
                  height: AppSize.defaultSize! * 13,
                  width: AppSize.defaultSize! * 9.6,
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        text: merchants.text,
                        color: AppColors.black,
                        fontSize: AppSize.defaultSize! * 1.4,
                        fontWeight: FontWeight.w600),
                    CustomText(
                        text: merchants.description,
                        color: AppColors.black,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontSize: AppSize.defaultSize! * 1.4),
                    SizedBox(
                      height: AppSize.defaultSize! * 2,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: AppSize.defaultSize! * 3.5,
                          width: AppSize.screenWidth! * .55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(AppSize.defaultSize! * .5),
                              border: Border.all(color: AppColors.primaryColor)),
                          child: Center(
                            child: Text(
                             StringManager.viewMore.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Merchants {
  final String text;
  final String description;
  final String image;

  Merchants(
      {required this.text, required this.description, required this.image});
}
