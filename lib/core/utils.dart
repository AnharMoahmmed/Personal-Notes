 
import 'package:intl/intl.dart';

String toShortDate(int dataTime) =>    DateFormat('dd MMM , y').format(
                    DateTime.fromMicrosecondsSinceEpoch(dataTime),
                  );
String toLongDate(int dataTime) =>    DateFormat('dd MMMM  y, hh:mm a').format(
                    DateTime.fromMicrosecondsSinceEpoch(dataTime),
                  );
