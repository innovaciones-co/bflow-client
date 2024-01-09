import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_chip_widget.dart';

class JobItemWidget extends StatelessWidget {
  const JobItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ), 
      height: 120, // THIS
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 15, right: 8, top: 15, bottom: 15),
        children: [
          _cellJob(title: "Job Number", width: 110, child: const Text("SH2201")),
          _cellJob(title: "Address", width: 160, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("#94 Pola st Dianella"),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0)
                  ),
                  child: const Text("Open in Goole maps"),
                ), // THIS ?link
              ],
            )
          ),
          _cellJob(title: "Supervisor", width: 140, child: const Text("Alberto Federico")),
          _cellJob(title: "Job Stage", width: 110, child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomChipWidget(label: "Slab down",),
            ],
          ),),
          _cellJob(title: "Days in construction", width: 160, child: const Text("90")),
          _cellJob(title: "Progress", width: 150, child: _progressBar(percentage: 0.7, width: 140),
          ),
          const SizedBox(width: 40,),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20), // THIS no hace nada
                  foregroundColor: context.primary,
                  backgroundColor: context.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'View details',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _progressBar({required double percentage, required double width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          width: width,
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage, // THIS porcentaje
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Center(child: Text("${percentage*100}% complete",)),
      ],
    );
  }

  SizedBox _cellJob({required String title, required double width, required Widget child}) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
