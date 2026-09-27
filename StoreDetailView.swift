import SwiftUI
import MapKit

struct StoreDetailView: View {
    @ObservedObject var store: Store
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(store.name).font(.title).bold()
                Text(store.address).foregroundColor(.secondary)

                if let coordinate = store.coordinate {
                    Map(position: $cameraPosition) {
                        Marker(store.name, coordinate: coordinate)
                            .tint(.red)
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                    .onAppear {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                            )
                        )
                    }
                }

                Text(store.hours.isOpen() ? "現在営業中" : "現在営業時間外")
                    .foregroundColor(store.hours.isOpen() ? .green : .red)
                    .font(.headline)

                if !store.note.isEmpty {
                    Text(store.note)
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
}
