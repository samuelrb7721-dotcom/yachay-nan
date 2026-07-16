import 'package:flutter/material.dart';
import 'package:yachay_nan/core/theme/app_colors.dart';

enum PeruRegion {
  coast,
  highlands,
  jungle,
}

class RegionOverviewScreen extends StatelessWidget {
  const RegionOverviewScreen({
    required this.region,
    super.key,
  });

  final PeruRegion region;

  @override
  Widget build(BuildContext context) {
    final _RegionData data = _dataForRegion(region);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: _buildHeader(context, data),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                    child: _buildHeroCard(data),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 14),
                    child: Text(
                      '¿Qué quieres descubrir?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final _RegionTopic topic = data.topics[index];

                        return _TopicCard(
                          topic: topic,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${topic.title} de ${data.title} estará disponible próximamente.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      },
                      childCount: data.topics.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.92,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    _RegionData data,
  ) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 3),
              Text(
                'Explora esta región del Perú',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(_RegionData data) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            data.color.withValues(alpha: 0.22),
            AppColors.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: data.color.withValues(alpha: 0.35),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 22,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            bottom: -18,
            child: Icon(
              data.icon,
              size: 170,
              color: data.color.withValues(alpha: 0.14),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Icon(
                  data.icon,
                  color: data.color,
                  size: 41,
                ),
              ),
              const Spacer(),
              Text(
                data.title.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                data.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static _RegionData _dataForRegion(PeruRegion region) {
    switch (region) {
      case PeruRegion.coast:
        return const _RegionData(
          title: 'Costa',
          description:
              'Descubre su historia, gastronomía, culturas y biodiversidad.',
          icon: Icons.waves_rounded,
          color: Color(0xFF3A9FC4),
          topics: [
            _RegionTopic(
              title: 'Historia',
              subtitle: 'Culturas de la costa',
              icon: Icons.history_edu_rounded,
            ),
            _RegionTopic(
              title: 'Gastronomía',
              subtitle: 'Sabores del litoral',
              icon: Icons.restaurant_rounded,
            ),
            _RegionTopic(
              title: 'Fauna',
              subtitle: 'Vida marina',
              icon: Icons.pets_rounded,
            ),
            _RegionTopic(
              title: 'Tradiciones',
              subtitle: 'Fiestas y costumbres',
              icon: Icons.celebration_rounded,
            ),
          ],
        );

      case PeruRegion.highlands:
        return const _RegionData(
          title: 'Sierra',
          description:
              'Explora los Andes, sus pueblos, tradiciones y legado histórico.',
          icon: Icons.landscape_rounded,
          color: Color(0xFFD99852),
          topics: [
            _RegionTopic(
              title: 'Historia',
              subtitle: 'El legado andino',
              icon: Icons.account_balance_rounded,
            ),
            _RegionTopic(
              title: 'Gastronomía',
              subtitle: 'Sabores de los Andes',
              icon: Icons.restaurant_menu_rounded,
            ),
            _RegionTopic(
              title: 'Festividades',
              subtitle: 'Danzas y celebraciones',
              icon: Icons.celebration_rounded,
            ),
            _RegionTopic(
              title: 'Paisajes',
              subtitle: 'Montañas y lagunas',
              icon: Icons.terrain_rounded,
            ),
          ],
        );

      case PeruRegion.jungle:
        return const _RegionData(
          title: 'Selva',
          description:
              'Conoce la Amazonía peruana, su naturaleza y riqueza cultural.',
          icon: Icons.forest_rounded,
          color: Color(0xFF4BAE6F),
          topics: [
            _RegionTopic(
              title: 'Flora',
              subtitle: 'Plantas amazónicas',
              icon: Icons.eco_rounded,
            ),
            _RegionTopic(
              title: 'Fauna',
              subtitle: 'Animales de la selva',
              icon: Icons.pets_rounded,
            ),
            _RegionTopic(
              title: 'Gastronomía',
              subtitle: 'Sabores amazónicos',
              icon: Icons.restaurant_rounded,
            ),
            _RegionTopic(
              title: 'Comunidades',
              subtitle: 'Cultura y tradiciones',
              icon: Icons.groups_rounded,
            ),
          ],
        );
    }
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    required this.onTap,
  });

  final _RegionTopic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowSoft,
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                topic.icon,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const Spacer(),
            Text(
              topic.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              topic.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _RegionData {
  const _RegionData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.topics,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<_RegionTopic> topics;
}

class _RegionTopic {
  const _RegionTopic({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}