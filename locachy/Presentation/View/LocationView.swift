import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel

    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            // Menampilkan peta dengan region yang didasarkan pada zoomLevel
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: viewModel.userLocation ?? CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456),
                span: MKCoordinateSpan(latitudeDelta: viewModel.zoomLevel, longitudeDelta: viewModel.zoomLevel)
            )))

            // Tombol Zoom In dan Zoom Out di atas peta
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
                    }
                    .padding()
                }
            }
        }
    }
}
