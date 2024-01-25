import 'package:flutter/material.dart';

class JobFilesWidget extends StatelessWidget {
  const JobFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      //height: 100,
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: ("Slab down")),
                  Tab(text: ("Plate Height")),
                  Tab(text: ("Roof Cover")),
                  Tab(text: ("Lock UP")),
                  Tab(text: ("Cabinets")),
                  Tab(text: ("PCI")),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Text("Slab down"),
                    Text("Plate Height"),
                    Text("Roof Cover"),
                    Text("Lock UP"),
                    Text("Cabinets"),
                    Text("PCI"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
