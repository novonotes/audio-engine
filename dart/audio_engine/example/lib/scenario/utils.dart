import 'package:flutter_test/flutter_test.dart';

typedef ExpectFunc = void Function(dynamic, dynamic,
    {String? reason, dynamic skip});

abstract class Scenario {
  Future<void> run(ExpectFunc expect);
  Future<void> tearDown();
}

/// Matcher を使って条件を評価し、失敗した場合に例外をスローする関数。
/// flutter_test の expect と共通のインターフェースを実装。
void assertThat(
  dynamic actual,
  dynamic matcher, {
  String? reason,
  dynamic skip,
}) {
  if (skip == true) {
    return;
  }
  final Matcher m = matcher is Matcher ? matcher : equals(matcher);
  final result = m.matches(actual, {});
  if (!result) {
    final description = StringDescription();
    m.describe(description);
    throw AssertionError(reason ?? 'Expected: ${description.toString()}');
  }
}

// TODO: Scenario の extension にする。
Future<void> runFullScenario(
  Scenario scenario,
) async {
  try {
    await scenario.run(assertThat);
  } finally {
    await scenario.tearDown();
  }
  print("Scenario completed.");
}
