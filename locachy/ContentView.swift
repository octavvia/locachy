import SwiftUI

struct ContentView: View {
    private let locationService = LocationService()
    private var getUserLocationUseCase: GetUserLocationUseCase
    private var mapViewModel: MapViewModel

    init() {
        getUserLocationUseCase = GetUserLocationUseCase(locationService: locationService)
        mapViewModel = MapViewModel(getUserLocationUseCase: getUserLocationUseCase)
    }

    var body: some View {
        MapView(viewModel: mapViewModel)
    }
}
