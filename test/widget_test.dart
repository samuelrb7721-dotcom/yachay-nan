import 'package:flutter_test/flutter_test.dart';
import 'package:yachay_nan/app/app.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (tester) async {
    await tester.pumpWidget(const YachayNanApp());

    expect(find.text('Yachay Ñan'), findsOneWidget);
    expect(find.text('Aprende la historia del Perú jugando'), findsOneWidget);
  });
}
