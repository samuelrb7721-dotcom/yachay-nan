import 'package:yachay_nan/features/map/domain/models/department.dart';

const List<Department> peruDepartments = <Department>[
  Department(
    id: 'ica',
    name: 'Ica',
    region: 'Costa Central',
    progress: 0.40,
    isUnlocked: true,
  ),
  Department(
    id: 'lima',
    name: 'Lima',
    region: 'Costa Central',
    progress: 0.20,
    isUnlocked: true,
  ),
  Department(
    id: 'cusco',
    name: 'Cusco',
    region: 'Sierra Sur',
    progress: 0.10,
    isUnlocked: true,
  ),
];

Department departmentFromMapName(String mapName) {
  final String normalizedMapName = _normalizeName(mapName);

  for (final Department department in peruDepartments) {
    if (_normalizeName(department.name) == normalizedMapName) {
      return department;
    }
  }

  // Temporalmente permite seleccionar departamentos que todavía
  // no hemos agregado a nuestra base de contenido.
  return Department(
    id: _createId(mapName),
    name: mapName,
    region: 'Región por completar',
    progress: 0,
    isUnlocked: true,
  );
}

String _normalizeName(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ñ', 'n');
}

String _createId(String value) {
  return _normalizeName(
    value,
  ).replaceAll(RegExp(r'[^a-z0-9]+'), '_').replaceAll(RegExp(r'^_+|_+$'), '');
}
