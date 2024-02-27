import 'package:flutter/material.dart';
//import 'package:ordrestyring_montage/src/utils/app_theme.dart';

class CaseCommentDialog extends StatelessWidget {
  const CaseCommentDialog(this.comments, {super.key});

  final String? comments;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[800],
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.comment, size: 20, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Vedrørende: 50220', // caseItem.caseNumber
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Text('$comments',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255))),
            ),
          ],
        ),
      ),
    );
  }
}
