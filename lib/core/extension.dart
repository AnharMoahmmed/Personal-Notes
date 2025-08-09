
//this extensoin to search insaid each tag rather than tags.Contains(term) used in note provider
extension ListDeepContains on List<String> {
  bool deepContains(String term) =>
      contains(term) || any((e) => e.contains(term));
}
