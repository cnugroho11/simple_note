import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget(
      {Key? key,
      this.isImportant = false,
      this.number = 0,
      this.title = '',
      this.description = '',
      required this.onChangedImportant,
      required this.onChangedNumber,
      required this.onChangedDescription,
      required this.onChangedTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Switch(
                  value: isImportant ?? false,
                  onChanged: onChangedImportant,
                ),
                Expanded(
                  child: Slider(
                    value: (number ?? 0).toDouble(),
                    max: 5,
                    min: 0,
                    divisions: 5,
                    onChanged: (number) => onChangedNumber(number.toInt()),
                  ),
                )
              ],
            ),
            buildTitle(),
            SizedBox(height: 8,),
            Container(
              child: buildDescription(),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() {
    return TextFormField(
      initialValue: description,
      maxLines: 9999,
      style: TextStyle(color: Colors.white60, fontSize: 18),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something...',
        hintStyle: TextStyle(color: Colors.white60),
      ),
      validator: (title) => title != null && title.isEmpty
          ? 'The description cannot be empty'
          : null,
      onChanged: onChangedDescription,
    );
  }
}
