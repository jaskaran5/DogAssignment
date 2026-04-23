import 'package:assignment_dog/data/models/dog_breed_model.dart';
import 'package:flutter/material.dart';

class DogBreedCard extends StatelessWidget {
  final DogBreedModel breed;

  const DogBreedCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showBreedDetails(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text('🐕', style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          breed.name ?? '',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 13,
                              color: Color(0xFF9E9E9E),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Life span: ${breed.lifeSpan}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9E9E9E),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (breed.hypoallergenic != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F5FE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '✓ Hypo',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0277BD),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              if (breed.description?.isNotEmpty == true) ...[
                Text(
                  breed.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
              const Divider(height: 1),
              const SizedBox(height: 12),
              // Weight row
              Row(
                children: [
                  Expanded(
                    child: _WeightChip(
                      label: '♂ Male',
                      min: breed.maleWeightMin ?? 0,
                      max: breed.maleWeightMax ?? 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _WeightChip(
                      label: '♀ Female',
                      min: breed.femaleWeightMin ?? 0,
                      max: breed.femaleWeightMax ?? 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Tap to view more
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Tap to view more',
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFF2E7D32).withValues(alpha: .7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: Color(0xFF2E7D32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBreedDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DragHandle(breed: breed),
    );
  }
}

class _WeightChip extends StatelessWidget {
  final String label;
  final double min;
  final double max;

  const _WeightChip({
    required this.label,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final weightText = (min == 0 && max == 0)
        ? 'N/A'
        : '${min.toStringAsFixed(1)} – ${max.toStringAsFixed(1)} kg';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF616161),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            weightText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  final DogBreedModel breed;

  const DragHandle({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      builder: (_, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text('🐕', style: TextStyle(fontSize: 34)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          breed.name ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                        ),
                        if (breed.hypoallergenic != null)
                          const Chip(
                            label: Text('Hypoallergenic'),
                            avatar: Icon(Icons.check_circle_outline, size: 16),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _DetailSection(
                title: 'Description',
                content: breed.description?.isNotEmpty == true
                    ? (breed.description ?? '')
                    : 'No description available.',
              ),
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.timer_outlined,
                label: 'Life Span',
                value: breed.lifeSpan ?? '',
              ),
              const SizedBox(height: 16),
              const Text(
                'Weight',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _WeightDetail(
                      label: '♂ Male',
                      min: breed.maleWeightMin ?? 0,
                      max: breed.maleWeightMax ?? 0,
                      color: const Color(0xFFE3F2FD),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WeightDetail(
                      label: '♀ Female',
                      min: breed.femaleWeightMin ?? 0,
                      max: breed.femaleWeightMax ?? 0,
                      color: const Color(0xFFFCE4EC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;

  const _DetailSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF616161),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WeightDetail extends StatelessWidget {
  final String label;
  final double min;
  final double max;
  final Color color;

  const _WeightDetail({
    required this.label,
    required this.min,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final weightText = (min == 0 && max == 0)
        ? 'N/A'
        : '${min.toStringAsFixed(1)} – ${max.toStringAsFixed(1)} kg';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            weightText,
            style: const TextStyle(fontSize: 13, color: Color(0xFF616161)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
