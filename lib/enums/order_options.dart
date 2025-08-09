
enum OrederOptions {
  dateModified,
  dateCreated;


// create the String name belowe:  to apper not like dateModified but to Modified Date
  String get name {
    return switch (this) {
      OrederOptions.dateModified => 'Modified Date',
      OrederOptions.dateCreated => 'Created Date',
    };
  }
}