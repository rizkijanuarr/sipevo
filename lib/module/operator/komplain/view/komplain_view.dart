import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class KomplainView extends StatelessWidget {
  const KomplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KomplainController>(
      init: KomplainController(),
      builder: (controller) {
        controller.view = this;
        return Scaffold(
          appBar: AppBar(
            title: Text("List Complaints (${controller.total_complaints})"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshComplaints(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (controller.complaints.isNotEmpty)
                      ...List.generate(controller.complaints.length, (index) {
                        var complaint = controller.complaints[index];
                        return InkWell(
                          onTap: () async {
                            // Aksi yang akan diambil saat card ditekan
                            String? result =
                                await controller.showOption(complaint);
                            if (result == 'update') {
                              // update
                            } else if (result == 'delete') {
                              // del
                            } else {
                              // close
                            }
                            return;
                          },
                          child: Card(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          controller.basePhotoComplaints +
                                              complaint.photoComplaints!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Container(
                                              width: 200,
                                              height: 200,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _truncateStringIfNeeded(
                                                  complaint.subject, 30),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              _truncateStringIfNeeded(
                                                  complaint.description, 30),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              _truncateStringIfNeeded(
                                                  "Lokasi: ${complaint.location!}",
                                                  30),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${complaint.name!} |",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 5.0),
                                                Text(
                                                  _truncateStringIfNeeded(
                                                      complaint.prodi!, 12),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(complaint.status),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      complaint.status,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    if (controller.complaints.isEmpty)
                      const Center(
                        child: Text(
                          'Data Kosong',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk mendapatkan warna berdasarkan status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tunggu sebentar':
        return Colors.deepOrange[500]!;
      case 'Sedang diproses':
        return Colors.red[500]!;
      case 'Telah diselesaikan':
        return Colors.green[500]!;
      default:
        return Colors.grey[500]!;
    }
  }

  // KEBUTUHAN MEMOTONG STRING YANG PANJANGNYA MELEBIHI BATAS
  String _truncateStringIfNeeded(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
}
