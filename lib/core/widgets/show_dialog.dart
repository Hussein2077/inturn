import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';

showCV(BuildContext context, ProfileDataModel profileDataModel) {
  return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: AppSize.defaultSize! * 1.5,
          ),
          child: Dialog(
            alignment: Alignment.topRight,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
            ),
            child: Container(
              // height: AppSize.screenHeight! * .9,
              // width: AppSize.screenWidth! * .95,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppSize.defaultSize!),
              ),
              child: CVPage(
                profileDataModel: profileDataModel,
              ),
            ),
          ),
        );
      });
}

class CVPage extends StatelessWidget {
  const CVPage({super.key, required this.profileDataModel});

  final ProfileDataModel profileDataModel;

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(
        PdfBitmap(await _readImageData(AssetPath.bgCv)),
        Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    page.graphics.drawImage(PdfBitmap(await _readImageData(AssetPath.logoPNG)),
        const Rect.fromLTWH(0, 0, 120, 40));
    page.graphics.drawString(
        '${profileDataModel.firstName} ${profileDataModel.lastName}',
        PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(0, 100, 400, 50));
    page.graphics.drawString(profileDataModel.description??'',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.gray, bounds: const Rect.fromLTWH(0, 150, 400, 300));
    page.graphics.drawImage(
        PdfBitmap(await _readImageData(AssetPath.cvContacts)),
        const Rect.fromLTWH(0, 280, 30, 110));
    page.graphics.drawString(
        profileDataModel.user?.phoneNumber??"+201125391736", PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 290, 400, 300));
    page.graphics.drawString(
        profileDataModel.user?.email??"", PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 320, 400, 300));
    page.graphics.drawString((profileDataModel.country?.countryNameEn??""),
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 350, 400, 300));
    page.graphics.drawString(
        'Education', PdfStandardFont(PdfFontFamily.helvetica, 25),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 420, 400, 50));
    page.graphics.drawString(profileDataModel.university?.universityName??"",
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 450, 400, 50));
    page.graphics.drawString(
        profileDataModel.faculty?.name??"", PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.gray, bounds: const Rect.fromLTWH(0, 480, 400, 50));
    // Create a PDF ordered list.
    final PdfOrderedList orderedList = PdfOrderedList(
      items: PdfListItemCollection(
        <String>['Skills'],
      ),
      textIndent: 20,
      indent: 20,
      font: PdfStandardFont(PdfFontFamily.helvetica, 25),
      marker: PdfOrderedMarker(
        style: PdfNumberStyle.none,
      ),
      markerHierarchy: false,
      format: PdfStringFormat(lineSpacing: 10),
    );
    orderedList.brush = PdfBrushes.black;
// Create a un ordered list and add it as a sublist.
    orderedList.items[0].subList = PdfUnorderedList(
        marker: PdfUnorderedMarker(
            font: PdfStandardFont(PdfFontFamily.helvetica, 15),
            style: PdfUnorderedMarkerStyle.disk),
        items: PdfListItemCollection(profileDataModel.user?.userSkills?.map((e) => e.skill?.skillNameEn??"").toList()),
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        textIndent: 10,
        format: PdfStringFormat(
            lineSpacing: 10, lineAlignment: PdfVerticalAlignment.top),
        indent: 20);
// Draw the list to the PDF page.
    orderedList.draw(
        page: page,
        format: PdfLayoutFormat(
          breakType: PdfLayoutBreakType.fitColumnsToPage,
        ),
        bounds: Rect.fromLTWH(
            -35, 530, page.getClientSize().width, page.getClientSize().height));

    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, '${profileDataModel.firstName} ${profileDataModel.lastName}.pdf');
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load(name);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: AppSize.screenHeight! * .7,
            width: AppSize.screenWidth! * .95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.defaultSize! * 2),
              ),
              image: const DecorationImage(
                image: AssetImage(AssetPath.bgCv),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSize.defaultSize!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(AssetPath.logo),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primaryColor,
                            size: AppSize.defaultSize! * 3.5,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: AppSize.defaultSize! * 2,
                  ),
                  CustomText(
                    text:
                        '${profileDataModel.firstName!} ${profileDataModel.lastName!}',
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: profileDataModel.description ?? "",

                    // lineHeight: AppSize.defaultSize! * .1,
                    maxLines: 20,
                    fontSize: AppSize.defaultSize! * 1.2,
                    color: AppColors.greyColor,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Container(
                        height: AppSize.defaultSize! * 11.8,
                        width: AppSize.defaultSize! * 3.2,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(
                            AppSize.defaultSize! * 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: AppColors.black,
                              size: AppSize.defaultSize! * 2,
                            ),
                            Icon(
                              Icons.mail_outline,
                              color: AppColors.black,
                              size: AppSize.defaultSize! * 2,
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.black,
                              size: AppSize.defaultSize! * 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: AppSize.defaultSize!,
                      ),
                      SizedBox(
                        height: AppSize.defaultSize! * 11.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //todo add phone number
                            CustomText(
                              text: profileDataModel.user?.phoneNumber ?? "+201125391736",
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.4,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                            //todo add email
                            CustomText(
                              text:  profileDataModel.user?.email ?? "",
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.4,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                            //todo add location
                            SizedBox(
                              width: AppSize.screenWidth! * .6,
                              child: CustomText(
                                text:
                                profileDataModel.city?.cityNameEn ?? "",
                                color: AppColors.primaryColor,
                                textAlign: TextAlign.start,
                                fontSize: AppSize.defaultSize! * 1.4,
                                fontWeight: FontWeight.w700,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: StringManager.education.tr(),
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:  profileDataModel.university?.universityName ?? "",
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:  profileDataModel.faculty?.name ?? "",
                    maxLines: 2,
                    fontSize: AppSize.defaultSize! * 1.2,
                    color: AppColors.greyColor,
                    textAlign: TextAlign.start,
                  ),
                  CustomText(
                    text: StringManager.skills.tr(),
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(

                    child: ListView.builder(
                        itemCount:  profileDataModel.user?.userSkills?.length,
                        itemBuilder: (context, index) {
                      return Padding(
                        padding:   EdgeInsets.all(AppSize.defaultSize! * .5),
                        child: CustomText(
                          text: profileDataModel.user?.userSkills![index].skill?.skillNameEn ?? "",
                          maxLines: 2,
                          fontSize: AppSize.defaultSize! * 1.2,
                          color: AppColors.greyColor,
                          textAlign: TextAlign.start,
                        ),
                      );
                    }),
                  ),

                ],
              ),
            )),
        SizedBox(
          height: AppSize.defaultSize! * 2,
        ),
        MainButton(
          text: StringManager.downloadAsPDF.tr(),
          onTap: _createPDF,
        ),
      ],
    );
  }
}
