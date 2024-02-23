class Utility {
  static String filterDescription(String description) {
    final pattern = RegExp(r'\{[^{}]*\}|\[[^\[\]]*\]|\([^()]*\)');
    String filteredDescription = description;
    while (pattern.hasMatch(filteredDescription)) {
      filteredDescription = filteredDescription.replaceAll(pattern, '');
    }

    return filteredDescription;
  }
}
