import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:flutter/material.dart';

class VerseOfDayCard extends StatelessWidget {
  final String reference;
  final String text;
  final VoidCallback onTap;

  const VerseOfDayCard({
    super.key,
    required this.reference,
    required this.text,
    required this.onTap,
  });

  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 3,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(
          FontProvider.instance.fontSize,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppStrings.verseOfDay,
                    style: TextStyle(
                      fontSize: AppFont.title,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: FontProvider.instance.fontSize,
            ),

            Text(
              reference,
              style: TextStyle(
                fontSize: AppFont.title,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: FontProvider.instance.fontSize - 4,
            ),

            Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppFont.body,
                height: 1.5,
              ),
            ),

            SizedBox(
              height: FontProvider.instance.fontSize,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.viewChapter,
                    style: TextStyle(
                      fontSize: AppFont.body,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppFont.caption,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
