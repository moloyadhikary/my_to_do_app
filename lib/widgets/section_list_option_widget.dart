import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_to_do_app/core/models/proejct_section/section_datum.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';
import 'package:my_to_do_app/widgets/horizontal_line_widget.dart';

class SectionListOptionWidget extends StatelessWidget {
  const SectionListOptionWidget({
    super.key,
    required this.sections,
    required this.onSelect,
  });

  final List<SectionDatum> sections;
  final void Function(SectionDatum selectedSection) onSelect;

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;

    return Container(
      width: pageWidth,
      height: pageHeight * 0.9,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        //color: extensionColor.groundPrimary,
        color: extensionColor.groundPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          HorizontalLineWidget(
            height: 4,
            width: 60,
            color: extensionColor.lowEmphasize,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: pageHeight * 0.9 - 34,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Select Section',
                            textAlign: TextAlign.left,
                            style: FontStyles.txtOutfitMedium.copyWith(
                              fontSize: 24,
                              color: extensionColor.highEmphasize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Select the section under which this task will be created',
                            textAlign: TextAlign.left,
                            style: FontStyles.txtLatoRegular.copyWith(
                              color: extensionColor.midEmphasize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: pageHeight * 0.9 - 128,
                    child: ListView.builder(
                      itemCount: sections.length,
                      itemBuilder: (BuildContext context, int index) {
                        final thisSection = sections[index];
                        return InkWell(
                          onTap: () {
                            onSelect(thisSection);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  top: 16,
                                  right: 8,
                                  bottom: 16,
                                ),
                                child: Row(
                                  children: [
                                    const FaIcon(FontAwesomeIcons.circleDot),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                thisSection.name ?? '',
                                                style: FontStyles
                                                    .txtLatoSemiBold
                                                    .copyWith(
                                                  color: extensionColor
                                                      .highEmphasize,
                                                ),
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const FaIcon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              HorizontalLineWidget(
                                height: 1,
                                width: double.maxFinite,
                                color: extensionColor.g3Border,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
