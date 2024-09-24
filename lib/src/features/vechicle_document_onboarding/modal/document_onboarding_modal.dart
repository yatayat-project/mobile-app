import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class DocumentOnboardingModal extends Equatable {
  final Map<String, XFile> documentFile;
  final bool isImageUploading;
  final List<Map<String, dynamic>> documentKeys;
  final int uploadProgress;
  final int total;
  final Map<String, XFile> updatedDocumentFile;

  const DocumentOnboardingModal({
    this.documentFile = const {},
    this.updatedDocumentFile = const {},
    this.uploadProgress = 0,
    this.total = 0,
    this.isImageUploading = false,
    this.documentKeys = const [
      {
        "id": 1,
        "slug": "prajapanpatra",
        "name": "प्रजापन पत्र",
      },
      {
        "id": 2,
        "slug": "bhansarko-rasid",
        "name": "भन्सारको रसिद",
      },
      {
        "id": 3,
        "slug": "shuru-vat-bill",
        "name": "शुरु VAT Bill",
      },
      {
        "id": 4,
        "slug": "company-wa-sansthako-hakama-darta-pramanpatra",
        "name": "कम्पनी वा संस्थाको हकमा दर्ता प्रमाणपत्र",
      },
      {
        "id": 5,
        "slug": "shuru-darta-farm",
        "name": "शुरु दर्ता फारम",
      },
      {
        "id": 6,
        "slug": "sawari-darta-card",
        "name": "सवारी दर्ता कार्ड",
      },
      {
        "id": 7,
        "slug": "antim-namasari-dhakako-pramanit-pana",
        "name": "अन्तिम नामसारी ढड्‌डाको प्रमाणित पाना",
      },
      {
        "id": 8,
        "slug": "engine-ko-photo",
        "name": "Engine को फोटो",
      },
      {
        "id": 9,
        "slug": "chassis-ko-photo",
        "name": "Chassis को फोटो",
      },
      {
        "id": 10,
        "slug": "shuru-saruwa-sahmati-patra",
        "name": "सुरु सरुवा सहमति पत्र",
      },
      {
        "id": 11,
        "slug": "antim-sawaridhanikko-nagrikata-ko-pratilipi",
        "name": "अन्तिम सवारीधनीको नागरिकताको प्रतिलिपी",
      },
      {
        "id": 12,
        "slug": "antim-saruwa-sahmati-patra",
        "name": "अन्तिम सरुवा सहमति पत्र",
      }
    ],
  });

  DocumentOnboardingModal copyWith({
    Map<String, XFile>? documentFile,
    bool? isImageUploading,
    int? uploadProgress,
    int? total,
    Map<String, XFile>? updateDocumentsFile,
  }) {
    return DocumentOnboardingModal(
      documentFile: documentFile ?? this.documentFile,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      total: total ?? this.total,
      isImageUploading: isImageUploading ?? this.isImageUploading,
      updatedDocumentFile: updateDocumentsFile ?? updatedDocumentFile,
    );
  }

  @override
  List<Object?> get props => [
        documentFile,
        isImageUploading,
        documentKeys,
        uploadProgress,
        updatedDocumentFile,
      ];
}
