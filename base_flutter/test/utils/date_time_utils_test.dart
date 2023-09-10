import 'package:base_flutter/shared/utils/date_time_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test FormatedDateTime', () {
    const expected = '25/07/2023';

    const dateString = '25/07/2023 1:32:56';
    final date = DateTimeUtils.toDate(dateString);

    expect(DateTimeUtils.formatDate(date!, type: AppDateFormat.ddMMyyyy),
        expected);
  });
}
