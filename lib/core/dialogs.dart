import 'package:flutter/material.dart';
import 'package:personal_notes/widgets/confirmation_dialog.dart';
import 'package:personal_notes/widgets/dialog_card.dart';
import 'package:personal_notes/widgets/new_tag_dialog.dart';

Future<String?> ShowNewTagDialog({required BuildContext context, String? tag}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => DialogCard(child: NewTagGialog(tag: tag)),
  );
}

Future<bool?> ShowConfirmationDialog({required BuildContext context}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => DialogCard(child: ConfirmationDialog()),
  );
}
