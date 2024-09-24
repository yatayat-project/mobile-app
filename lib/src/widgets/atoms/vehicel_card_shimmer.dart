import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VehicleCardShimmer extends StatelessWidget {
  const VehicleCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.white,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Main Details Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 150,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 80,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 120,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Metadata Section
              Container(
                width: 150,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(height: 5),
              Container(
                width: 150,
                height: 15,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
