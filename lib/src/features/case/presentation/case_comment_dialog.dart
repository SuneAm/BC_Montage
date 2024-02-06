import 'package:flutter/material.dart';

class CaseCommentDialog extends StatelessWidget {
  const CaseCommentDialog(this.comments, {super.key});

  final String? comments;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                child: ColoredBox(
                  color: Color.fromARGB(255, 51, 152, 240),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Note',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
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
              child: Text('$comments'),
            ),
          ],
        ),
      ),
    );
  }
}
