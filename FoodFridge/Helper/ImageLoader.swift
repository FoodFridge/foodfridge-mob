//
//  ImageLoader.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/18/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    private let cache = NSCache<NSURL, UIImage>()
    private var cancellables = Set<AnyCancellable>()

    @Published var state: LoadingState = .loading
    
    enum LoadingState: Equatable {
           case loading
           case success(UIImage)
           case failure
           case timedOut
       }
    
    func startLoadingTimer(seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            guard let self = self, self.state == .loading else { return }
            self.state = .timedOut
        }
    }

    func loadImage(from url: URL) {
        // if got cachedImage use that cache
        if let cachedImage = cache.object(forKey: url as NSURL) {
            self.state = .success(cachedImage)
            return
        }
        
        //if not keep loading
        state = .loading
        
        // Start the timeout timer
        startLoadingTimer(seconds: 5)
        
        //make request
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self else { return }
                
                // If timed out, don't override the state
                if self.state == .timedOut {
                    return
                }
                
                guard let img = downloadedImage else {
                    self.state = .failure
                    return
                }
                // cache image as NSURL
                self.cache.setObject(img, forKey: url as NSURL)
                // set state to success with downloadedImage
                self.state = .success(img)
                
            }
            .store(in: &cancellables)
    }
}

struct CachedAsyncImage: View {
    
    @StateObject private var loader = ImageLoader()
    
    let url: URL?
    var placeholder: UIImage

    var body: some View {
        Group {
            switch loader.state {
                        case .success(let image):
                 
                            Image(uiImage: image)
                                .resizable()
                                .cornerRadius(10)
                                .frame(maxWidth: 70, maxHeight: 90)
                                .scaledToFill()
                                .backgroundStyle(.white)
                                .shadow(radius: 5, x: 5, y: 5)
                
                        case .failure, .timedOut:
                            Image(uiImage: placeholder)
                                .resizable()
                                .cornerRadius(10)
                                .frame(maxWidth: 70, maxHeight: 90)
                                .scaledToFill()
                                .backgroundStyle(.white)
                                .shadow(radius: 5, x: 5, y: 5)
                
                        case .loading:
                
                                ProgressView()
                
                                
                
                               
            }
        }
        .aspectRatio(contentMode: .fill)
        .padding(.horizontal)
        .onAppear {
            if let url {
                loader.loadImage(from: url)
            }
        }
    }
}

