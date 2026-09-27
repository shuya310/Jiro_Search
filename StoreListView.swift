import SwiftUI
import MapKit
import CoreLocation

struct StoreListView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var stores: [Store] = SampleData.jiroStores
    @State private var showOnlyOpen = false

    var sortedStores: [Store] {
        let filtered = showOnlyOpen ? stores.filter { $0.hours.isOpen() } : stores
        return filtered.sorted {
            ($0.distanceMeters ?? .greatestFiniteMagnitude) < ($1.distanceMeters ?? .greatestFiniteMagnitude)
        }
    }

    var body: some View {
        NavigationStack {
            List(sortedStores) { store in
                NavigationLink(destination: StoreDetailView(store: store)) {
                    StoreRow(store: store)
                }
            }
            .navigationTitle("二郎 直系店マップ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle("営業中のみ", isOn: $showOnlyOpen)
                        .toggleStyle(.switch)
                }
            }
            .task {
                locationManager.requestPermission()
                await geocodeAllStores()
            }
            .onChange(of: locationManager.currentLocation) { _, newLocation in
                guard let location = newLocation else { return }
                updateDistances(from: location)
            }
        }
    }

<<<<<<< HEAD:StoreListView.swift
    /// 住所文字列を座標に変換（MKGeocodingRequest を使用）
=======
    /// 住所文字列を座標に変換（Appleのジオコーダーを使うので、緯度経度を自前で持つ必要がない）
>>>>>>> a6f236f (アイコンの設定):RamenJiro_Search/StoreListView.swift
    private func geocodeAllStores() async {
        await withTaskGroup(of: Void.self) { group in
            for store in stores {
                group.addTask {
<<<<<<< HEAD:StoreListView.swift
                    guard let request = MKGeocodingRequest(addressString: store.address) else { return }
                    do {
                        let mapItems = try await request.mapItems
                        guard let coordinate = mapItems.first?.location.coordinate else { return }

=======
                    let geocoder = CLGeocoder()
                    do {
                        let placemarks = try await geocoder.geocodeAddressString(store.address)
                        guard let coordinate = placemarks.first?.location?.coordinate else { return }
                        
>>>>>>> a6f236f (アイコンの設定):RamenJiro_Search/StoreListView.swift
                        await MainActor.run {
                            store.coordinate = coordinate
                            if let current = locationManager.currentLocation {
                                updateDistance(for: store, from: current)
                            }
                        }
                    } catch {
                        print("ジオコーディングエラー(\(store.name)): \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    private func updateDistances(from location: CLLocation) {
        for store in stores {
            updateDistance(for: store, from: location)
        }
    }

    private func updateDistance(for store: Store, from location: CLLocation) {
        guard let coordinate = store.coordinate else { return }
        let storeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        store.distanceMeters = location.distance(from: storeLocation)
    }
}

struct StoreRow: View {
    @ObservedObject var store: Store

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(store.name).font(.headline)
                Text(store.nearestStation)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(store.hours.isOpen() ? "営業中" : "営業時間外")
                    .font(.caption)
                    .foregroundColor(store.hours.isOpen() ? .green : .red)
            }
            Spacer()
            if let distance = store.distanceMeters {
                Text(String(format: "%.1f km", distance / 1000))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("計測中…")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
