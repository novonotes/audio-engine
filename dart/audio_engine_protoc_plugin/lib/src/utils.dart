String snakeCaseToPascalCase(String input) {
  List<String> words = input.split('_');
  for (int i = 0; i < words.length; i++) {
    words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
  }
  return words.join('');
}

String pascalCaseToSnakeCase(String input) {
  String result = '';
  for (int i = 0; i < input.length; i++) {
    if (i > 0 && input[i].toUpperCase() == input[i]) {
      result += '_';
    }
    result += input[i].toUpperCase();
  }
  return result;
}

String lowercaseFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // 空文字列の場合、変換は行わずにそのまま返す
  }
  return input[0].toLowerCase() + input.substring(1);
}
