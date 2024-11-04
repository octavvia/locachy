import Combine
import CoreLocation

class MapViewModel: ObservableObject {
    private let getUserLocationUseCase: GetUserLocationUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    private let defaultLocation = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    private let defaultZoomLevel: Double = 0.05  // Zoom level default

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var zoomLevel: Double

    init(getUserLocationUseCase: GetUserLocationUseCaseProtocol) {
        self.getUserLocationUseCase = getUserLocationUseCase
        self.zoomLevel = defaultZoomLevel
        observeUserLocation()
    }

    private func observeUserLocation() {
        getUserLocationUseCase.userLocation
            .sink { [weak self] location in
                self?.userLocation = location ?? self?.defaultLocation
            }
            .store(in: &cancellables)
    }

    // Fungsi untuk mengubah zoom level
    func zoomIn() {
        zoomLevel = max(zoomLevel / 2, 0.002)  // Zoom in
    }

    func zoomOut() {
        zoomLevel = min(zoomLevel * 2, 2.0)    // Zoom out
    }
}
