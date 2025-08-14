import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/new_note_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/services/notification_service,dart';
import 'package:personal_notes/widgets/note_back_botton.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:personal_notes/widgets/note_matedate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class NewOrEidtNote extends StatefulWidget {
  const NewOrEidtNote({required this.isNewnNote, super.key});

  final bool isNewnNote;

  @override
  State<NewOrEidtNote> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewOrEidtNote> {
  late final NewNoteController newNoteController;
  late final FocusNode focusNode;
  late final TextEditingController titelController;
  late final TextEditingController ContentController;

  //picker fro time reminder

  DateTime? _reminderAt; //


  //notificatio
  final NotificationService _notificationService = NotificationService();

  String _formatReminder(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(dt.year, dt.month, dt.day);

    String dayLabel;
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (dateOnly == today) {
      dayLabel = 'Today';
    } else if (dateOnly == today.add(const Duration(days: 1))) {
      dayLabel = 'Tomorrow';
    } else {
      dayLabel = days[dt.weekday - 1];
    }

    final yyyy = dt.year.toString();
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');

    return '$dayLabel • $yyyy/$mm/$dd  $hh:$min';
  }

  // ========= (3) فتح BottomSheet لعجلة التاريخ =========
  void _openReminderPicker() {
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: false,
      builder: (ctx) {
        DateTime tempSelected =
            _reminderAt ?? DateTime.now().add(const Duration(minutes: 5));

        return SizedBox(
          height: 330,
          child: Column(
            children: [
              // شريط علوي (عنوان + Clear + Done)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (_reminderAt != null)
                      TextButton(
                        onPressed: () {
                         // 1. Get the note from the controller.
      final noteToClear = newNoteController.note;

      // 2. Safety Check: Only proceed if the note actually exists.
      if (noteToClear != null) {
        // 3. Use the creation date to find and cancel the scheduled notification.
        _notificationService.cancelNotification(noteToClear.dateCreated);
      }

      // 4. Update the UI state to remove the reminder text.
      setState(() {
        _reminderAt = null;
      });

      // 5. Update the data model in the controller.
      newNoteController.reminderAt = null;

      // 6. (Optional but good UX) Show a confirmation message.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reminder cleared.')),
        );
      }

      // 7. Close the bottom sheet.
      Navigator.pop(ctx);
                        },
                        child: const Text('Clear'),
                      ),
                    const SizedBox(width: 6),
                    FilledButton(
                      
                      // onPressed: () {
                      //   // لا نعتمد الماضي
                      //   final now = DateTime.now();
                      //   if (tempSelected.isBefore(now)) {
                      //     tempSelected = now.add(const Duration(minutes: 1));
                      //   }

                      //   // --- CORRECTED LOGIC ---
                      //   // 1. Update the UI state variable
                      //   setState(() {
                      //     _reminderAt = tempSelected;
                      //   });

                      //   // 2. Update the data model in the controller
                      //   newNoteController.reminderAt =
                      //       tempSelected.microsecondsSinceEpoch;

                      //   Navigator.pop(ctx);
                      // },
                      // Inside the "Done" FilledButton's onPressed callback:
// Inside your "Done" button's onPressed in _openReminderPicker

onPressed: () {
  // ... (your existing logic to set _reminderAt and newNoteController.reminderAt) ...

  // --- SCHEDULE THE NOTIFICATION ---
  final noteToSchedule = newNoteController.note;

  // We need to handle the case where the note is brand new and has not been saved yet.
  if (noteToSchedule == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please save the note once before setting a reminder.')),
      );
      Navigator.pop(context);
      return;
  }

  // Use the creation timestamp as the unique ID
  final int notificationId = noteToSchedule.dateCreated;

  _notificationService.scheduleNotification(
    id: notificationId, // Use the creation date as the integer ID
    title: newNoteController.title?.isNotEmpty == true ? newNoteController.title! : 'Note Reminder',
    body: newNoteController.content?.isNotEmpty == true ? newNoteController.content! : 'You have a reminder.',
    scheduledTime: tempSelected,
    payload: notificationId.toString(), // Use the string version for the payload
  );
  
  if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reminder set for ${_formatReminder(tempSelected)}')),
      );
  }
  // --- END SCHEDULING ---

  Navigator.pop(context);
},
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),

              // العجلة
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: tempSelected,
                  minimumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    tempSelected = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    newNoteController = context.read<NewNoteController>();
    focusNode = FocusNode();
    titelController = TextEditingController(text: newNoteController.title);
    ContentController = TextEditingController(text: newNoteController.content);
    super.initState();
    // quillController = QuillController.basic();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewnNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });

    //time
    // _reminderAt = newNoteController.note?.reminderAt as DateTime?;
    final reminderTimestamp = newNoteController.note?.reminderAt;
    if (reminderTimestamp != null && reminderTimestamp is int) {
      // 3. Convert the integer timestamp back to a DateTime object
      _reminderAt = DateTime.fromMicrosecondsSinceEpoch(reminderTimestamp);
    } else {
      // If there's no reminder, ensure _reminderAt is null
      _reminderAt = null;
    }
  }

  @override
  void dispose() {
    // quillController.dispose();
    titelController.dispose();
    ContentController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return; //do nothing in this case
        if (!newNoteController.CanSaveNote) {
          Navigator.pop(context);
          return; //this whene check ✔️  and there is nothig written ..> to not show dialog
        }
        final bool? shouldSave = await ShowConfirmationDialog(context: context);

        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewnNote ? 'New Note' : 'edit note'),
          leading: NoteBackButton(),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconBottonOutline(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
                OnPressed: () {
                  newNoteController.readOnly = !readOnly;

                  if (newNoteController.readOnly) {
                    FocusScope.of(context).unfocus();
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
              ),
            ),

            Selector<NewNoteController, bool>(
              selector: (_, NewNoteController) => newNoteController.CanSaveNote,
              builder: (_, CanSaveNote, _) => NoteIconBottonOutline(
                OnPressed: CanSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
                icon: FontAwesomeIcons.check,
              ),
            ),
            IconButton(icon: Icon(Icons.alarm), onPressed: _openReminderPicker),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  controller: titelController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Title here',
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                  ),
                  canRequestFocus: !readOnly,
                  onChanged: (newvalue) {
                    newNoteController.title = newvalue;
                  },
                ),
              ),
              NoteMatedate(note: newNoteController.note),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (_, readOnly, __) => Column(
                    children: [
                      TextField(
                        controller: ContentController,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Type here..',
                          hintStyle: TextStyle(color: gray300),
                          border: InputBorder.none,
                        ),
                        readOnly: readOnly,
                        focusNode: focusNode,

                        //   child: QuillEditor(
                        //     controller: quillController,
                        //     scrollController: ScrollController(),

                        //     focusNode: focusNode,
                        //   ),
                        onChanged: (newValue) {
                          newNoteController.content = newValue;
                        },
                      ),
                      // QuillToolbar(controller: quillController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
