import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class DisclaimerWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  
  const DisclaimerWidget({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => showBacInfoDialog(context),
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, size: 18, color: Colors.grey[500]),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                loc.disclaimer,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showBacInfoDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  Widget buildBacRangeRow(String range, String effect, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 13, color: Theme.of(ctx).colorScheme.onSurface),
          children: [
            TextSpan(text: "$range g/l: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: effect),
          ],
        ),
      ),
    );
  }

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(width: 8),
          Flexible(child: Text(loc.infoResponsibilityTitle)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              loc.bacDisclaimer,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const Divider(height: 24),
            Text(loc.calculationExplanationTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(loc.calculationExplanationBody, style: const TextStyle(fontSize: 13)),
            const Divider(height: 24),
            Text(loc.estimatedEffectsTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            buildBacRangeRow("0.01 - 0.05", loc.bacEffect1, ctx),
            buildBacRangeRow("0.05 - 0.08", loc.bacEffect2, ctx),
            buildBacRangeRow("0.08 - 0.15", loc.bacEffect3, ctx),
            buildBacRangeRow("0.15 - 0.30", loc.bacEffect4, ctx),
            buildBacRangeRow(loc.over30, loc.bacEffect5, ctx),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(loc.gotItBtn),
        ),
      ],
    ),
  );
}
