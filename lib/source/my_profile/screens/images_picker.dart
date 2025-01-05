import 'dart:io';

import 'package:app/source/my_profile/controllers/image_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImages extends StatelessWidget {
  final ImageServiceController imagePickerController;

  const ProfileImages({super.key, required this.imagePickerController});

  @override
  Widget build(BuildContext context) {
    imagePickerController.fetchImagesFromFirebase();
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return FutureBuilder<void>(
        future: imagePickerController.fetchImagesFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.yellow.shade700,
              backgroundColor: Colors.grey,
            ));
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching images')); // Error handling
          } else {
            // Images fetched successfully, now display the GridView
            return Obx(
              () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: imagePickerController.images.length,
                itemBuilder: (context, index) {
                  final image = imagePickerController.images[index];
                  return Stack(
                    children: [
                      image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (image is File
                                  ? Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )),
                            )
                          : DottedBorder(
                              color: isDark ? Colors.white : Colors.black,
                              strokeWidth: 3,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [8, 8],
                              child: Container(),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: image != null
                            ? IconButton(
                                icon: const Icon(Icons.delete, size: 30),
                                color: Colors.red,
                                onPressed: () {
                                  imagePickerController.images.removeAt(index);
                                  imagePickerController.images.add(null);
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.add, size: 30),
                                color: Colors.amber.shade700,
                                onPressed: () {
                                  imagePickerController.pickImages();
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        });
  }
}
