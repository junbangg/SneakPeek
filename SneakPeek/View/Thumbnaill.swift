import SwiftUI


/**
 View for displaying thumbnail ( preview of shoe)
 - Reference : https://www.hackingwithswift.com/forums/swiftui/loading-images/3292
 */
struct Thumbnail: View {
    // MARK: - Properties
    
    @ObservedObject private var loader: Loader
    var loading: Image
    var failure: Image

    // MARK: - View Body
    
    var body: some View {
        selectImage()
            .resizable()
    }

    // MARK: - Initializer
    
    init(url: String,
         loading: Image = Image(systemName: "photo"),
         failure: Image = Image(systemName: "multiply.circle")
    ) {
        _loader = ObservedObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
}

// MARK: - Nested Types

extension Thumbnail {
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
}

// MARK: - Private Methods

extension Thumbnail {
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
