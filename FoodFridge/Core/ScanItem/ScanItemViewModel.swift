//
//  ScanItemViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import AVKit
import Foundation
import SwiftUI
import VisionKit

enum ScanType {
    case text
}

enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class ScanItemViewModel: ObservableObject {
    
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizeMultipleItems = false
    @Published var scanType: ScanType = .text
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var pantryItems: [PantryItem] = PantryItem.mockPantryItems
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    var recognizeDataType: DataScannerViewController.RecognizedDataType {
        .text(textContentType: textContentType)
   }
    
    var dataScannerViewId: Int {
      var hasher = Hasher()
      hasher.combine(scanType)
      hasher.combine(recognizeMultipleItems)
      if let textContentType {
          hasher.combine(textContentType)
      }
      return hasher.finalize()
  }
  
    
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
                
            }else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        default: break
            
        }
    }
    
    
    func addItemToPantry(item: String) {
        //pantryItems.append(item)
    }
}


#Preview {
    ScanItemViewModel() as! any View
}
