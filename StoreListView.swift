import SwiftUI
import MapKit
import CoreLocation

struct StoreListView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var stores: [Store] = SampleData.jiroStores
    @State private var showOnlyOpen = false
    @State private var lastUpdateTime = Date()

    var sortedStores: [Store] {
        // lastUpdateTimeを参照することで、距離更新時にこの計算が再実行される
        _ = lastUpdateTime
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
                // 位置情報の取得を開始
                locationManager.requestPermission()
                
                // 位置情報の取得を待つ（最大5秒）
                var attempts = 0
                while locationManager.currentLocation == nil && attempts < 50 {
                    try? await Task.sleep(for: .milliseconds(100))
                    attempts += 1
                }
                
                // 位置情報が取得できなかった場合はデフォルト位置（東京駅）を使用
                if locationManager.currentLocation == nil {
                    print("⚠️ 位置情報が取得できませんでした。東京駅をデフォルト位置として使用します")
                    locationManager.currentLocation = CLLocation(latitude: 35.6812, longitude: 139.7671)
                }
                
                print("📍 基準位置: \(locationManager.currentLocation!.coordinate.latitude), \(locationManager.currentLocation!.coordinate.longitude)")
                
                await geocodeAllStores()
            }
            .onChange(of: locationManager.currentLocation) { oldLocation, newLocation in
                guard let newLocation = newLocation else { return }
                // 初回のジオコーディング完了後のみ距離を更新
                guard stores.first?.coordinate != nil else { return }
                print("📍 位置情報が更新されました。距離を再計算します")
                updateDistances(from: newLocation)
            }
        }
    }

<<<<<<< HEAD:StoreListView.swift
<<<<<<< HEAD:StoreListView.swift
<<<<<<< HEAD:StoreListView.swift
    /// 住所文字列を座標に変換（MKGeocodingRequest を使用）
=======
    /// 住所文字列を座標に変換（Appleのジオコーダーを使うので、緯度経度を自前で持つ必要がない）
>>>>>>> a6f236f (アイコンの設定):RamenJiro_Search/StoreListView.swift
=======
    /// 住所文字列を座標に変換（MKGeocodingRequest を使用）
>>>>>>> 3d2e622 (首都圏38店舗データ追加・モデル刷新・ビルドエラー修正):RamenJiro_Search/StoreListView.swift
=======
    /// 住所文字列を座標に変換(MKGeocodingRequest を使用)
>>>>>>> bef8202 (Fix: 距離表示が8000km以上になる問題を修正):RamenJiro_Search/StoreListView.swift
    private func geocodeAllStores() async {
        print("🗺️ ジオコーディング開始")
        
        await withTaskGroup(of: Void.self) { group in
            for store in stores {
                group.addTask {
<<<<<<< HEAD:StoreListView.swift
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
=======
                    guard let request = MKGeocodingRequest(addressString: store.address) else { return }
                    do {
                        let mapItems = try await request.mapItems
                        guard let coordinate = mapItems.first?.location.coordinate else { return }

>>>>>>> 3d2e622 (首都圏38店舗データ追加・モデル刷新・ビルドエラー修正):RamenJiro_Search/StoreListView.swift
                        await MainActor.run {
                            store.coordinate = coordinate
                            if let current = locationManager.currentLocation {
                                let storeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                store.distanceMeters = current.distance(from: storeLocation)
                            }
                        }
                    } catch {
                        print("❌ ジオコーディングエラー(\(store.name)): \(error.localizedDescription)")
                    }
                }
            }
        }
        // ジオコーディング完了後にビューを更新
        await MainActor.run {
            lastUpdateTime = Date()
            print("✅ ジオコーディング完了。\(stores.filter { $0.coordinate != nil }.count)/\(stores.count)店舗の座標を取得")
        }
    }

    private func updateDistances(from location: CLLocation) {
        Task { @MainActor in
            for store in stores {
                guard let coordinate = store.coordinate else { continue }
                let storeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distance = location.distance(from: storeLocation)
                store.distanceMeters = distance
            }
            // 距離更新後にビューを更新
            lastUpdateTime = Date()
            print("🔄 距離を更新しました")
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
