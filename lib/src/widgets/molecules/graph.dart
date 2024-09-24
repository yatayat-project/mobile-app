import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';

class BarGraphView extends StatefulWidget {
  const BarGraphView({
    super.key,
    required this.approved,
    required this.pending,
    required this.rejected,
  });
  final int approved;
  final int pending;
  final int rejected;
  @override
  State<BarGraphView> createState() => _BarGraphViewState();
}

class _BarGraphViewState extends State<BarGraphView> {
  late int maxYAsix;
  @override
  void initState() {
    List<int> temp = [widget.approved, widget.pending, widget.rejected];
    maxYAsix =
        temp.reduce((value, element) => value > element ? value : element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.sp),
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Onboarding Status',
            textStyle: context.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.9),
              fontSize: 18,
            ),
          ),
          primaryXAxis: CategoryAxis(
            labelStyle: context.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: maxYAsix.toDouble(),
            interval: 5,
          ),
          series: <ChartSeries>[
            ColumnSeries<ChartData, String>(
              dataSource: [
                ChartData('Approved', widget.approved, Colors.green),
                ChartData('Pending', widget.pending, AppColors.warning),
                ChartData('Rejected', widget.rejected, AppColors.error),
              ],
              xValueMapper: (ChartData data, _) => data.status,
              yValueMapper: (ChartData data, _) => data.count,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: context.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
              width: 0.6,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.status, this.count, this.color);
  final String status;
  final int count;
  final Color color;
}
