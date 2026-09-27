import SwiftUI
import MapKit

struct StoreDetailView: View {
    @ObservedObject var store: Store
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(store.name).font(.title).bold()

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.address).foregroundColor(.secondary)
                    Label(store.nearestStation, systemImage: "tram.fill")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let coordinate = store.coordinate {
                    Map(position: $cameraPosition, interactionModes: []) {
                        Marker(store.name, coordinate: coordinate)
                            .tint(.red)
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                    .overlay(alignment: .bottomTrailing) {
                        Label("マップで開く", systemImage: "arrow.up.right.square")
                            .font(.caption)
                            .padding(6)
                            .background(.ultraThinMaterial, in: Capsule())
                            .padding(8)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        openInMaps(coordinate: coordinate)
                    }
                    .onAppear {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                            )
                        )
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.hours.isOpen() ? "現在営業中" : "現在営業時間外")
                        .foregroundColor(store.hours.isOpen() ? .green : .red)
                        .font(.headline)
                    Text(store.hours.representativeHoursText)
                        .font(.subheadline)
                    Text(store.hours.closedDaysText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let twitter = store.twitterAccount {
                    let handle = twitter.hasPrefix("@") ? String(twitter.dropFirst()) : twitter
                    if let url = URL(string: "https://x.com/\(handle)") {
                        Link(destination: url) {
                            Label(twitter, systemImage: "link")
                                .font(.subheadline)
                        }
                    }
                }

                if !store.note.isEmpty {
                    Text(store.note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let distance = store.distanceMeters {
                    Text("現在地から \(String(format: "%.2f", distance / 1000)) km")
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .navigationTitle(store.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openInMaps(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let mapItem = MKMapItem(location: location, address: nil)
        mapItem.name = store.name
        mapItem.openInMaps()
    }
}
