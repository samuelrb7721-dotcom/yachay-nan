import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';
import 'package:yachay_nan/features/map/data/peru_departments_data.dart';
import 'package:yachay_nan/features/map/domain/models/department.dart';
import 'package:yachay_nan/features/map/widgets/peru_interactive_map.dart';
import 'package:yachay_nan/features/department/presentation/screens/department_screen.dart';
import 'package:yachay_nan/core/services/progress_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Department selectedDepartment;
  int _icaProgressPercent = ProgressService.initialIcaProgress;

  @override
  void initState() {
    super.initState();

    selectedDepartment = peruDepartments.firstWhere(
      (Department department) => department.id == 'ica',
      orElse: () => peruDepartments.first,
    );
    _loadStoredProgress();
  }

  Future<void> _loadStoredProgress() async {
    final int storedProgress = await ProgressService.getIcaProgress();

    if (!mounted) {
      return;
    }

    setState(() {
      _icaProgressPercent = storedProgress;
    });
  }

  void _selectDepartment(String mapDepartmentName) {
    setState(() {
      selectedDepartment = departmentFromMapName(mapDepartmentName);
    });
  }

  void _openSelectedDepartment() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DepartmentScreen(department: selectedDepartment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MapHeader(selectedDepartment: selectedDepartment),
                  const SizedBox(height: 22),
                  _MapContainer(
                    selectedDepartment: selectedDepartment,
                    progressPercent: _icaProgressPercent,
                    onDepartmentSelected: _selectDepartment,
                    onExplore: _openSelectedDepartment,
                  ),
                  const SizedBox(height: 18),
                  const _MapInstructionsCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({required this.selectedDepartment});

  final Department selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.map_rounded,
            color: AppColors.primary,
            size: 30,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explora el Perú',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Selecciona un departamento y aprende jugando.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapContainer extends StatelessWidget {
  const _MapContainer({
    required this.selectedDepartment,
    required this.progressPercent,
    required this.onDepartmentSelected,
    required this.onExplore,
  });

  final Department selectedDepartment;
  final int progressPercent;
  final ValueChanged<String> onDepartmentSelected;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 650,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 24,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Color(0xFFF8FCFB))),

            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 150),
                child: PeruInteractiveMap(
                  selectedDepartmentName: selectedDepartment.name,
                  onDepartmentSelected: onDepartmentSelected,
                ),
              ),
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: _SelectedDepartmentCard(
                department: selectedDepartment,
                progressPercent: progressPercent,
                onPressed: onExplore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedDepartmentCard extends StatelessWidget {
  const _SelectedDepartmentCard({
    required this.department,
    required this.progressPercent,
    required this.onPressed,
  });

  final Department department;
  final int progressPercent;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 22,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.wb_sunny_outlined,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textSecondary,
                      size: 17,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        department.region,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Text(
                      'Progreso',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '$progressPercent%',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: department.isUnlocked ? onPressed : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.border,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              department.isUnlocked ? 'Explorar' : 'Bloqueado',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapInstructionsCard extends StatelessWidget {
  const _MapInstructionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.touch_app_rounded,
            color: AppColors.primary,
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Toca un departamento del mapa para seleccionarlo y consultar su progreso.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
