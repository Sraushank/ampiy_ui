String toPascalCase(String username) {
  List<String> words = username.split(RegExp(r'[_\s]+'));

  String pascalCase = '';
  for (String word in words) {
    pascalCase += word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  return pascalCase;
}
