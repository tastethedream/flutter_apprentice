import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/grocery_item.dart';


class GroceryTile extends StatelessWidget {
  // 1
  final GroceryItem item;
  // 2
  final Function(bool?)? onComplete;
  // 3
  final TextDecoration textDecoration;

  // 4
  GroceryTile({
    Key? key,
    required this.item,
    this.onComplete,
  }) : textDecoration =
  item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO 21: Change this Widget
    return SizedBox(
      height: 100.0,
      // TODO 20: Replace this color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
      children: [
      // 2
      Container(width: 5.0, color: item.color),
      // 3
      const SizedBox(width: 16.0),
      // 4
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5
          Text(
            //'Test',
            item.name,
            style: GoogleFonts.openSans(
              decoration: textDecoration,
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          buildDate(),
          const SizedBox(height: 4.0),
          buildImportance(),

            ],

          ),

          // TODO 23: Add Row to group (quantity, checkbox)
        // 6
        //had to add sized box here not in original code to correct layout issue
        const SizedBox(width: 125.0),
        Row(
          children: [
            // 7
            Text(item.quantity.toString(),
              style:
              GoogleFonts.lato(
                  decoration: textDecoration,
                  fontSize: 21.0),
            ),
            // 8
            buildCheckbox(),
          ],
        ),

      ],
      ),
],
      ),
    );
  }


// TODO: Add BuildImportance()
  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
          'Low',
          style: GoogleFonts.lato(decoration: textDecoration));
    } else if (item.importance == Importance.medium) {
      return Text(
          'Medium',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w800,
              decoration: textDecoration));
    } else if (item.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(
          color: Colors.red,
          fontWeight: FontWeight.w900,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }
  // TODO: Add buildDate()
  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }




// TODO: Add buildCheckbox()
  Widget buildCheckbox() {
    return Checkbox(
      // 1
      value: item.isComplete,
      // 2
      onChanged: onComplete,
    );
  }


}
