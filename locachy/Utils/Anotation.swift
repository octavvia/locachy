import MapKit

struct UserLocationAnnotation: Identifiable {
    let id = UUID()  // Conformance to Identifiable
    let coordinate: CLLocationCoordinate2D
    let title: String?
}
