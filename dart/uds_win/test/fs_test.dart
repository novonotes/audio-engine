import 'dart:io';
import 'package:test/test.dart';
import 'package:uds_win/fs.dart';

void main() {
  group('File Utilities', () {
    final testFilePath = 'test_file.tmp';

    setUp(() {
      // Create a temporary test file
      File(testFilePath).writeAsStringSync('Temporary test file.');
    });

    tearDown(() {
      // Delete the test file if it exists
      if (File(testFilePath).existsSync()) {
        File(testFilePath).deleteSync();
      }
    });

    test('existsSync returns true for existing files', () {
      expect(existsSync(testFilePath), isTrue);
    });

    test('existsSync returns false for non-existent files', () {
      expect(existsSync('non_existent_file.tmp'), isFalse);
    });

    test('deleteSync deletes the file successfully', () {
      expect(existsSync(testFilePath), isTrue);

      deleteSync(testFilePath);

      expect(existsSync(testFilePath), isFalse);
    });

    test('deleteSync throws no exception for non-existent files', () {
      // No exception should be thrown when trying to delete a non-existent file
      expect(() => deleteSync('non_existent_file.tmp'),
          throwsA(isA<PathNotFoundException>()));
    });

    test('deleteSync throws an exception if unable to delete (read-only file)',
        () {
      if (Platform.isWindows) {
        // Set the file to read-only on Windows
        File(testFilePath).setLastModifiedSync(DateTime.now());
        Process.runSync('attrib', ['+r', testFilePath]);

        expect(
          () => deleteSync(testFilePath),
          throwsA(predicate((e) =>
              e is Exception &&
              e.toString().contains('Failed to delete the file'))),
        );

        // Reset the file to writable
        Process.runSync('attrib', ['-r', testFilePath]);
      } else {
        print('This test is skipped for non-Windows platforms.');
      }
    });
  });
}
