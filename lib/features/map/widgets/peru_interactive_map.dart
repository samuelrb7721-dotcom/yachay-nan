import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';

class PeruInteractiveMap extends StatefulWidget {
  const PeruInteractiveMap({
    required this.selectedDepartmentName,
    required this.onDepartmentSelected,
    super.key,
  });

  final String selectedDepartmentName;
  final ValueChanged<String> onDepartmentSelected;

  @override
  State<PeruInteractiveMap> createState() => _PeruInteractiveMapState();
}

class _PeruInteractiveMapState extends State<PeruInteractiveMap> {
  static const String _assetPath = 'assets/maps/peru_departments.geojson';

  MapShapeSource? _shapeSource;
  List<String> _departmentNames = const <String>[];
  int _selectedIndex = -1;
  Object? _loadingError;

  @override
  void initState() {
    super.initState();
    _loadMap();
  }

  @override
  void didUpdateWidget(covariant PeruInteractiveMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedDepartmentName != widget.selectedDepartmentName) {
      _synchronizeSelectedIndex();
    }
  }

  Future<void> _loadMap() async {
    try {
      final String rawGeoJson = await rootBundle.loadString(_assetPath);

      final Map<String, dynamic> decoded =
          jsonDecode(rawGeoJson) as Map<String, dynamic>;

      final List<dynamic> features =
          decoded['features'] as List<dynamic>? ?? <dynamic>[];

      final List<String> names = features
          .map<String>((dynamic feature) {
            final Map<String, dynamic> featureMap =
                feature as Map<String, dynamic>;

            final Map<String, dynamic> properties =
                featureMap['properties'] as Map<String, dynamic>? ??
                <String, dynamic>{};

            return properties['NOMBDEP']?.toString() ??
                'Departamento desconocido';
          })
          .toList(growable: false);

      final MapShapeSource source = MapShapeSource.asset(
        _assetPath,
        shapeDataField: 'NOMBDEP',
        dataCount: names.length,
        primaryValueMapper: (int index) => names[index],
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _departmentNames = names;
        _shapeSource = source;
        _selectedIndex = _findSelectedIndex(names);
        _loadingError = null;
      });
    } on Object catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loadingError = error;
      });
    }
  }

  void _synchronizeSelectedIndex() {
    if (_departmentNames.isEmpty) {
      return;
    }

    final int newIndex = _findSelectedIndex(_departmentNames);

    if (newIndex == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = newIndex;
    });
  }

  int _findSelectedIndex(List<String> names) {
    final String selectedName = _normalizeName(widget.selectedDepartmentName);

    return names.indexWhere(
      (String name) => _normalizeName(name) == selectedName,
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

  void _handleSelection(int index) {
    if (index < 0 || index >= _departmentNames.length) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    widget.onDepartmentSelected(_departmentNames[index]);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingError != null) {
      return _MapStatus(
        icon: Icons.error_outline_rounded,
        title: 'No se pudo cargar el mapa',
        message:
            'Revisa que peru_departments.geojson exista dentro de assets/maps.',
        iconColor: AppColors.error,
      );
    }

    final MapShapeSource? source = _shapeSource;

    if (source == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return SfMaps(
      layers: <MapShapeLayer>[
        MapShapeLayer(
          source: source,
          selectedIndex: _selectedIndex,
          onSelectionChanged: _handleSelection,
          color: const Color(0xFFFFFBF2),
          strokeColor: const Color(0xFFB7A98A),
          strokeWidth: 0.9,
          selectionSettings: const MapSelectionSettings(
            color: Color(0xFFD7F4F1),
            strokeColor: AppColors.primary,
            strokeWidth: 2.8,
          ),
          shapeTooltipBuilder: (BuildContext context, int index) {
            if (index < 0 || index >= _departmentNames.length) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _departmentNames[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
          tooltipSettings: const MapTooltipSettings(color: Colors.transparent),
        ),
      ],
    );
  }
}

class _MapStatus extends StatelessWidget {
  const _MapStatus({
    required this.icon,
    required this.title,
    required this.message,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 54),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
