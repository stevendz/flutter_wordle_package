import 'package:wordle_game/src/models/chart_model.dart';
import 'package:wordle_game/src/utils/chart_series.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: FutureBuilder(
        future: getSeries(),
        builder: (context, snapshot) {
          final List<charts.Series<ChartModel, String>> series;
          if (snapshot.hasData) {
            series = snapshot.data!;
            return Consumer(
              builder: (_, notifier, __) {
                return charts.BarChart(
                  series,
                  vertical: false,
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      lineStyle: const charts.LineStyleSpec(
                        color: charts.MaterialPalette.transparent,
                      ),
                      labelStyle: charts.TextStyleSpec(
                        fontSize: textStyle.fontSize?.round(), // Set font size
                        fontFamily: textStyle.fontFamily, // Set font family
                        color: charts.ColorUtil.fromDartColor(textStyle.color!), // Set font color
                      ),
                    ),
                  ),
                  primaryMeasureAxis: const charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      lineStyle: charts.LineStyleSpec(
                        color: charts.MaterialPalette.transparent,
                      ),
                      labelStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.transparent,
                      ),
                    ),
                  ),
                  barRendererDecorator: charts.BarLabelDecorator(
                    labelAnchor: charts.BarLabelAnchor.end,
                    outsideLabelStyleSpec: charts.TextStyleSpec(
                      fontSize: textStyle.fontSize?.round(),
                      fontFamily: textStyle.fontFamily,
                      color: charts.ColorUtil.fromDartColor(textStyle.color!),
                    ),
                  ),
                  behaviors: [
                    charts.ChartTitle(
                      'VERSUCHE',
                      titleStyleSpec: charts.TextStyleSpec(
                        fontSize: textStyle.fontSize?.round(),
                        fontFamily: textStyle.fontFamily,
                        color: charts.ColorUtil.fromDartColor(textStyle.color!),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
