import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:admin_panel/models/client.dart';
import 'package:admin_panel/models/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestScreen extends StatefulWidget {
  final Request request;
  RequestScreen({super.key, required this.request});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Client? client;

  @override
  void initState() {
    super.initState();
    _fetchClient();
  }

  Future<void> _fetchClient() async {
    try {
      final value =
          await CilentsController.getClinetByClientId(widget.request.cId);
      if (value['error'] == null) {
        setState(() {
          client = Client.fromJson(
              "", value); // Ensure this matches the expected constructor
        });
      } else {
        // Handle the error case
        print('Error fetching client: ${value['error']}');
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
    }
  }

  void _openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude";
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Handle the error, e.g., show a message to the user
      print('Could not open the map.');
    }
  }

  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      title: "Company Name",
                      content: client?.companyName ?? "Loading...",
                    ),
                    _buildInfoRow(
                      title: "STIR",
                      content: client?.stir.toString() ?? "Loading...",
                    ),
                    _buildInfoRow(
                      title: "Phone Number",
                      content: client?.phoneNumber ?? "Loading...",
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  widget.request.description,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _openGoogleMaps(widget.request.lat, widget.request.long);
              },
              icon: const Icon(Icons.location_on),
              label: const Text(
                "Open Location",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                textStyle: TextStyle(fontSize: 18.sp),
              ),
            ),
            SizedBox(height: 16.h),
            _buildImageGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h), // Add some space between title and content
          Text(
            content,
            style: TextStyle(fontSize: 14.sp),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1,
      ),
      itemCount: widget.request.imageUrls.length,
      itemBuilder: (ctx, index) {
        final imageUrl = widget.request.imageUrls[index];
        return GestureDetector(
          onTap: () => _showFullScreenImage(imageUrl),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
