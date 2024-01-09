import 'package:flutter/material.dart';

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
