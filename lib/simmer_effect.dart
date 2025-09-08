import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerToDataExample extends StatefulWidget {
  @override
  _ShimmerToDataExampleState createState() => _ShimmerToDataExampleState();
}

class _ShimmerToDataExampleState extends State<ShimmerToDataExample> {
  bool isLoading = true;
  List<String> data = [];

  @override
  void initState() {
    super.initState();

    // Simulate API call delay
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        data = ["John Doe", "Alice Smith", "Michael Lee", "Sarah Wilson"];
      });
    });
  }

  Widget buildShimmer() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white, radius: 25),
            title: Container(height: 12, color: Colors.white),
            subtitle: Container(height: 12, width: 100, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget buildDataList() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(data[index][0]), // First letter
          ),
          title: Text(data[index]),
          subtitle: Text("Loaded from API"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shimmer → Real Data")),
      body: isLoading ? buildShimmer() : buildDataList(),
    );
  }
}
