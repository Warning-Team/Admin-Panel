import 'package:admin_panel/services/request_http_serrvice.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/models/request.dart';

class RequestDetailsScreen extends StatefulWidget {
  final String requestId;

  const RequestDetailsScreen({super.key, required this.requestId});

  @override
  // ignore: library_private_types_in_public_api
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final RequestsHttpService _requestsHttpService = RequestsHttpService();
  late Future<Request> _requestFuture;

  @override
  void initState() {
    super.initState();
    _requestFuture = _requestsHttpService.getRequest(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
      ),
      body: FutureBuilder<Request>(
        future: _requestFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No request found'));
          }

          final request = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: request.imgUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              request.imgUrls[index],
                              height: 100,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text('ID: ${request.id}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Employee ID: ${request.eId}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Client ID: ${request.cId}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Date: ${request.date}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Description: ${request.description}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
