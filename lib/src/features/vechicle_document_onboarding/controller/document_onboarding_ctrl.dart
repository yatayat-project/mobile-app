import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_handler.dart';
import '../../../config/api/api_s.dart';
import '../../../core/extensions/context.dart';
import '../../../core/utils/constants.dart';
import '../../../injector.dart';
import '../../../models/error/modal.dart';
import '../../../widgets/atoms/loader_dialog.dart';
import '../../vehicle_list/presentation/home.dart';
import '../../vehicle_list/presentation/home_controller.dart';
import '../modal/document_onboarding_modal.dart';

class DocumentNotifier extends AutoDisposeNotifier<DocumentOnboardingModal> {
  @override
  build() {
    return const DocumentOnboardingModal();
  }

  void add(Map<String, XFile> document) {
    action(
      state,
      () {
        state = state.copyWith(
          documentFile: {...state.documentFile, ...document},
        );
        log("✅✅✅✅✅ Added image: ${state.documentFile}");
      },
    );
  }

  void update(String key, XFile file) {
    action(
      state,
      () {
        final updatedDocumentFile = Map<String, XFile>.from(state.documentFile);
        updatedDocumentFile[key] = file;
        state = state.copyWith(documentFile: updatedDocumentFile);
      },
    );
  }

  void remove(String key) {
    action(
      state,
      () {
        final updatedDocumentFile = Map<String, XFile>.from(state.documentFile);
        updatedDocumentFile.remove(key);
        state = state.copyWith(documentFile: updatedDocumentFile);
        log("❌❌❌❌❌Removed image: ${state.documentFile}");
      },
    );
  }

  void addRejectedDocument(Map<String, XFile> rejDocument) {
    action(
      state,
      () {
        state = state.copyWith(
          updateDocumentsFile: {...state.updatedDocumentFile, ...rejDocument},
        );
        log("✅✅✅✅✅ Added rejected image: ${state.updatedDocumentFile}");
      },
    );
  }

  void removeRejectedDocument(String key) {
    action(
      state,
      () {
        final updatedDocumentFile =
            Map<String, XFile>.from(state.updatedDocumentFile);
        updatedDocumentFile.remove(key);
        state = state.copyWith(updateDocumentsFile: updatedDocumentFile);
        log("❌❌❌❌❌Removed rejected image: ${state.updatedDocumentFile}");
      },
    );
  }

  void clearRejectedDocument() {
    action(
      state,
      () {
        state = state.copyWith(
          updateDocumentsFile: {},
        );
        log("✅✅✅✅✅ Clearing: ${state.updatedDocumentFile}");
      },
    );
  }

  Future<void> onSubmit() async {
    imageUploadProgress();
    var documents = state.documentFile;
    int? vehicleID = sharedPreferences.getInt("vehicle_id");
    state = state.copyWith(isImageUploading: true);
    log("debug: document length ${documents.length}");
    if (documents.length == 12) {
      Map<String, MultipartFile> data = {};
      for (String key in documents.keys) {
        MultipartFile multipartFile = await _uploadFile(key, documents[key]!);
        data[key] = multipartFile;
      }

      if (data.length == 12) {
        var formData = FormData.fromMap({
          "vehicle_id": vehicleID,
          ...data,
        });

        // send data to api
        final request = dio.post(
          APIs.uploadDocuments,
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
          onSendProgress: (count, total) {
            state = state.copyWith(uploadProgress: count, total: total);
          },
        );
        final response = await APIHandler.hitApi(request);
        if (response is APIError) {
          currentContext.pop();
          state = state.copyWith(isImageUploading: false);
          currentContext.showError(response.message);
        } else {
          currentContext.pop();
          state = state.copyWith(isImageUploading: false, documentFile: {});
          currentContext.showSuccess("Vehicle onboard successfully!!");
          // back to form page
          currentContext.pop();
        }
      }
    } else {
      currentContext.pop();
      state = state.copyWith(isImageUploading: false);
      currentContext.showError("Some documents are missing!!");
    }
  }

  Future<void> onUpdate({
    required int vehicleID,
    required int rejectedDocs,
  }) async {
    imageUploadProgress();
    var documents = state.updatedDocumentFile;
    if (rejectedDocs == documents.length) {
      Map<String, MultipartFile> data = {};
      for (String key in documents.keys) {
        MultipartFile multipartFile = await _uploadFile(key, documents[key]!);
        data[key] = multipartFile;
      }
      if (rejectedDocs == documents.length) {
        var formData = FormData.fromMap({
          "vehicle_id": vehicleID,
          ...data,
        });
        // send data to api
        final request = dio.post(
          APIs.uploadRejectedDocuments,
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
          onSendProgress: (count, total) {
            state = state.copyWith(uploadProgress: count, total: total);
          },
        );
        final response = await APIHandler.hitApi(request);
        if (response is APIError) {
          currentContext.pop();
          currentContext.showError(response.message);
        } else {
          currentContext.pop();
          state = state.copyWith(updateDocumentsFile: {});
          currentContext.showSuccess("Vehicle document updated successfully!!");
          currentContext.go(Home.routeName);
          ref.invalidate(vehicleListControllerProvider);
        }
      }
    } else {
      currentContext.pop();
      state = state.copyWith(isImageUploading: false);
      currentContext.showError("Failed to update documents!!");
    }
  }
}

final documentNotifierProvider =
    NotifierProvider.autoDispose<DocumentNotifier, DocumentOnboardingModal>(
  DocumentNotifier.new,
);

void action(DocumentOnboardingModal state, VoidCallback actionCallBack) {
  state = state.copyWith(isImageUploading: true);
  actionCallBack();
  state = state.copyWith(isImageUploading: false);
}

Future<MultipartFile> _uploadFile(String key, XFile filePath) async {
  try {
    File file = File(filePath.path);
    return await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
  } catch (e) {
    rethrow;
  }
}
