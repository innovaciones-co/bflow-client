import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: TextField(
                onChanged: (val) => _searchJobs(val, context),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                ),
              ),
            ),
          ),
          // Container(
          //   // THIS ?ok
          //   width: 1,
          //   height: 25,
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   color: Colors.grey.shade400,
          // ),
          // ActionButtonWidget(
          //   onPressed: () {},
          //   type: ButtonType.textButton,
          //   title: "Filter",
          //   icon: Icons.tune,
          //   foregroundColor: Colors.black,
          // ),
          // const Chip(
          //   // THIS
          //   label: Text("Filter Chip"),
          //   deleteIcon: Icon(Icons.tune), // THIS no funciona
          //   onDeleted: null,
          // ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15, right: 8),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(25),
          //     border: Border.all(
          //       color: Colors.grey.shade800,
          //       width: 0.8,
          //     ),
          //   ),
          //   child: const Row(
          //     children: [
          //       Text("Alberto Federico"),
          //       //SizedBox(width: 8),
          //       IconButton(
          //         onPressed: null,
          //         icon: Icon(Icons.close),
          //         iconSize: 15,
          //         mouseCursor: MaterialStateMouseCursor.clickable,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _searchJobs(String value, BuildContext context) {
    if (value.isNotEmpty) {
      context.read<JobsBloc>().add(FilterJobsEvent(value));
    } else {
      context.read<JobsBloc>().add(GetJobsEvent());
    }
  }
}
