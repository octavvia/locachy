import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            // Map with dynamic zoom level
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: viewModel.userLocation ?? CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456),
                span: MKCoordinateSpan(latitudeDelta: viewModel.zoomLevel, longitudeDelta: viewModel.zoomLevel)
            )),
                annotationItems: [viewModel.userAnnotation].compactMap { $0 }) { annotation in
                MapMarker(coordinate: annotation.coordinate, tint: .blue)
            }
            
            // Zoom and Share controls
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: viewModel.zoomIn) {
                            Image(systemName: "plus.magnifyingglass")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        Button(action: viewModel.zoomOut) {
                            Image(systemName: "minus.magnifyingglass")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        Button(action: viewModel.shareLocation) {
                            Image(systemName: "square.and.arrow.up")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $viewModel.isSharingLocation) {
                   // Present the share sheet with the generated location URL
                   if let location = viewModel.userLocation {
                       let latitude = location.latitude
                       let longitude = location.longitude
                       let locationURL = "https://maps.apple.com/?ll=\(latitude),\(longitude)"
                       ActivityViewController(activityItems: [locationURL])
                   }
               }
    }
}
