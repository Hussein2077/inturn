import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/home/presentation/componants/blog_details/merchants_stores.dart';

class BlogComplete extends StatefulWidget {
  const BlogComplete({super.key});

  @override
  State<BlogComplete> createState() => _BlogCompleteState();
}

class _BlogCompleteState extends State<BlogComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size(AppSize.screenWidth!, AppSize.defaultSize! * 3),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
                CustomText(
                  text: StringManager.theMost.tr(),
                  fontSize: AppSize.defaultSize! * 1.8,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:   EdgeInsets.all(AppSize.defaultSize!*2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AssetPath.logo,
                  fit: BoxFit.fill,
                  width: AppSize.screenWidth! * .85,
                  height: AppSize.defaultSize! * 15.2,
                ),
              ),
              SizedBox(height: AppSize.defaultSize!,),
              CustomText(
                text: '''in a handsome Edwardian house in south London, the bold kitchen's interior is literally made from kitchen rubbish. No slabs of pristine Carrera marble or granite in Mountain View. Instead, the work tops and cupboard doors had former lives as microwave meal trays, bottle tops and plastic chopping boards. It's the epitome of "waste-not-want-not" design, with recycled plastics given a new – more noble – role, and adding style. Mat Barnes of architecture and design studio CAN, and owner of Mountain View, was drawn to the graphic quality of recycling company Smile Plastics' bold panels made from kitchen packaging waste. "They're like exaggerated surreal marble," he tells BBC Culture. But his choice wasn't purely driven by environmental concerns. "We chose them for their aesthetic, we weren't compromising our look by going for something sustainable." Similarly, rather than adorning the living room with brand new decorative mouldings – in reference to the house's original period details – Barnes scoured a local plaster maker for seconds. These delightfully imperfect fragments were stuck to the walls like sculptures, and painted a rich blue in keeping with the rest of the monochrome room. Like many designers and architects these days, Barnes was keen that as few building materials as possible ended up as waste from the transformation of this house into a pop-culture-inspired family home. So the offcuts from the kitchen cabinets were used externally on the first floor's concrete lintels; and when part of an internal brick wall was removed to create a cascading wall effect between the kitchen and living area, those same bricks were relocated to the back of the garden and laid out as a patio. The recycling and repurposing of materials is increasing in popularity. With recycling, materials are turned into something else for their second life, which generally takes some effort and energy. With repurposing, items are simply used again, though often for new purposes. In both cases, designers have more and more products and techniques to choose from.
            ''',

                maxLines: 500,
                textAlign: TextAlign.start,
                fontSize: AppSize.defaultSize!*1.6,
              ),
              CustomText(
                text: StringManager.anotherRecommendedArticles.tr(),
                fontSize: AppSize.defaultSize! * 1.8,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: AppSize.defaultSize!*1.6,),
              SizedBox(

                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,i){
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.blogComplete);
                    },
                    child: MerchantsStores(
                      blog: true,
                      merchants: Merchants(
                          text: 'BURGER KING INDONESIA',
                          description:
                          'Burger King Corporation is an American multinational chain of hamburger fast food restaurants.',
                          image: AssetPath.slogan),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
