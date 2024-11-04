import CoreLocation
import Combine

protocol GetUserLocationUseCaseProtocol {
    var userLocation: Published<CLLocationCoordinate2D?>.Publisher { get }
}

class GetUserLocationUseCase: GetUserLocationUseCaseProtocol {
    private var locationService: LocationService

    init(locationService: LocationService) {
        self.locationService = locationService
    }

    var userLocation: Published<CLLocationCoordinate2D?>.Publisher {
        locationService.$userLocation
    }
}
