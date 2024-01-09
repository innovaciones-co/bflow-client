import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContainerWidget(
      title: "Jobs (Construction list)", 
      child: Column(
        children: [
          JobsFilterWidget(),
          JobItemWidget(),
          JobItemWidget(),
          JobItemWidget(),
          JobItemWidget(),
          JobItemWidget(),
        ],
      ),
    );
  }
}

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

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({
    super.key, required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 2, right: 8, left: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600, // THIS
        ),
      ),
    );
  }
}

class JobsFilterWidget extends StatelessWidget {
  const JobsFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 300,
            decoration: const BoxDecoration(
              //color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
              ),
            ),
          ),
          Container( // THIS ?ok
            width: 1,
            height: 25,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.grey.shade400,
          ),
          const TextButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.only(left: 0, right: 20),),
              
              //backgroundColor: MaterialStatePropertyAll(Colors.amber)
            ),
            onPressed: null, 
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  size: 18,
                  color: Colors.black,
                ),
                Text(
                  "Filter",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const Chip( // THIS
            label: Text("Filter Chip"),
            deleteIcon: Icon(Icons.tune), // THIS no funciona
            onDeleted: null,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey.shade800,
                width: 0.8,
              ),),
            child: const Row(
              children: [
                Text("Alberto Federico"),
                //SizedBox(width: 8),
                IconButton(
                  onPressed: null, 
                  icon: Icon(Icons.close),
                  iconSize: 15,
                  mouseCursor: MaterialStateMouseCursor.clickable,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
