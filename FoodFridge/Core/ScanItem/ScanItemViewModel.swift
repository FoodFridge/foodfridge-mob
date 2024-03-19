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
    @Published var pantryItems = [PantryItem]()
    @Published var isLoading: Bool = false
    
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        Task {
            await self.getPantry()
        }
   }
    
    
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
        
        Task {
            try await AddPantry(sessionManager: sessionManager).addPantry(with: item)
        }
        
    }
    
    func deleteItem(at offsets: IndexSet, from dateSection: String) {
        
        // find the index of the section from which we're deleting
        if let sectionIndex = pantryItems.firstIndex(where: { $0.date == dateSection }) {
            print("sectionIndex = \(sectionIndex)")
            // retrieve the specific section
            var section = pantryItems[sectionIndex]
            print("section = \(section)")
            // pantryInfo items have an 'id' property that is a String
            // and represents the pantryId to delete
            if let itemIndex = offsets.first, itemIndex < section.pantryInfo.count {
                let pantryIdToDelete = section.pantryInfo[itemIndex].id
                // remove the item from pantryInfo array within this section
                section.pantryInfo.remove(atOffsets: offsets)
                print("deleted \(String(describing: pantryIdToDelete))")
                
                // update the section in the main array
                pantryItems[sectionIndex] = section
                
                // If the section is now empty, remove the entire section
                if section.pantryInfo.isEmpty {
                        pantryItems.remove(at: sectionIndex)
                        print("Removed empty section")
                }
                
                // Call API to delete pantry
                Task {
                    do {
                        try await DeletePantry.delete(of: pantryIdToDelete ?? "testId")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
            
        }
    }
    
    func getPantry() async {
        isLoading = true
        do {
            pantryItems = try await GetPantry(sessionManager: sessionManager).getPantry()
        } catch {
            print("Error fetching pantry:", error)
        }
        isLoading = false
    }
    
}


#Preview {
    ScanItemViewModel(sessionManager: SessionManager()) as! any View
}
