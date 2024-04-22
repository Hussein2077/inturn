import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

showCV(BuildContext context) {
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
              child: const CVPage(),
            ),
          ),
        );
      });
}

class CVPage extends StatelessWidget {
  const CVPage({super.key});

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    // page.graphics.drawString('Hussein Yasser CV',
    //     PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(
        PdfBitmap(await _readImageData(AssetPath.bgCv)),
        Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    page.graphics.drawImage(PdfBitmap(await _readImageData(AssetPath.logoPNG)),
        Rect.fromLTWH(0, 0, 120, 40));
    page.graphics.drawString(
        'Hussein Yasser', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 100, 400, 50));
    page.graphics.drawString(
        'Highly skilled software developer with 8 years of experience in designing, developing, and implementing software solutions. Proficient in multiple programming languages and technologies.',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.gray,
        bounds: const Rect.fromLTWH(0, 150, 400, 300));
    page.graphics.drawString(
        '+20 1145 7898 20', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 290, 400, 300));
    page.graphics.drawString(
        'Mohamed@gmail.com', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 320, 400, 300));
    page.graphics.drawString('15 Abbas Al Akkad, Madinet nasr , Cairo, Egypt',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black,
        bounds: const Rect.fromLTWH(40, 350, 400, 300));
    page.graphics.drawString(
        'Education', PdfStandardFont(PdfFontFamily.helvetica, 25),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 420, 400, 50));
    page.graphics.drawString('American University in Cairo',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 450, 400, 50));
    page.graphics.drawString(
        'Computer Science', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.gray, bounds: const Rect.fromLTWH(0, 480, 400, 50));
    // page.graphics.drawString(
    //     'Skills', PdfStandardFont(PdfFontFamily.helvetica, 25),
    //     brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 520, 400, 50));
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
        items: PdfListItemCollection(<String>[
          'ASP .NET',
          'Object Oriented',
          'MVC',
          'SQL Server',
        ]),
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        textIndent: 10,
        indent: 20);
// Draw the list to the PDF page.
    orderedList.draw(
        page: page,
        bounds: Rect.fromLTWH(
            -35, 530, page.getClientSize().width, page.getClientSize().height));
    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'hussein_yasser.pdf');
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
                          onPressed: () {},
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
                    text: 'Hussein Yasser',
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text:
                        '''Highly skilled software developer with 8 years of experience in designing, developing, and implementing software solutions. Proficient in multiple programming languages and technologies.
                    ''',

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
                            CustomText(
                              text: '+20 1145 7898 20',
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.4,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              text: 'Mohamed@gmail.com',
                              color: AppColors.primaryColor,
                              fontSize: AppSize.defaultSize! * 1.4,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: AppSize.screenWidth! * .6,
                              child: CustomText(
                                text:
                                    '15 Abbas Al Akkad, Madinet nasr , Cairo, Egypt',
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
                    text: 'American University in Cairo ',
                    color: AppColors.primaryColor,
                    fontSize: AppSize.defaultSize! * 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: '''Computer Science''',
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
                  CustomText(
                    text:
                        '''- ASP.NET\n- Object Oriented\n- MVC\n- SQL Server''',
                    maxLines: 100,
                    fontSize: AppSize.defaultSize! * 1.2,
                    color: AppColors.greyColor,
                    textAlign: TextAlign.start,
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
