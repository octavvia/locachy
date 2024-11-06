import Combine
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    private let getUserLocationUseCase: GetUserLocationUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private let defaultLocation = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    private let defaultZoomLevel: Double = 0.05
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var zoomLevel: Double
    @Published var userAnnotation: UserLocationAnnotation?  // Updated to custom annotation
    @Published var isSharingLocation = false
    
    init(getUserLocationUseCase: GetUserLocationUseCaseProtocol) {
        self.getUserLocationUseCase = getUserLocationUseCase
        self.zoomLevel = defaultZoomLevel
        observeUserLocation()
    }
    
    private func observeUserLocation() {
        getUserLocationUseCase.userLocation
            .sink { [weak self] location in
                self?.userLocation = location ?? self?.defaultLocation
                self?.updateUserAnnotation()
            }
            .store(in: &cancellables)
    }
    
    private func updateUserAnnotation() {
        guard let location = userLocation else { return }
        userAnnotation = UserLocationAnnotation(coordinate: location, title: "You are here")
    }
    
    func zoomIn() {
        zoomLevel = max(zoomLevel / 2, 0.002)
    }
    
    func zoomOut() {
        zoomLevel = min(zoomLevel * 2, 2.0)
    }
    
    
    
    // New function to generate the shareable location URL
    func shareLocation() {
        guard let location = userLocation else { return }
        let latitude = location.latitude
        let longitude = location.longitude
        let locationURL = "https://maps.apple.com/?ll=\(latitude),\(longitude)"
        share(locationURL)
    }
    
    private func share(_ locationURL: String) {
        // Trigger the sharing sheet to show
        isSharingLocation = true
    }
}
