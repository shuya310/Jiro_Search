import Foundation
import CoreLocation
import Combine

/// 営業時間の定義と、現在時刻が営業中かどうかの判定
struct BusinessHours {
    let openHour: Int
    let openMinute: Int
    let closeHour: Int
    let closeMinute: Int
    /// 定休日。Calendar.component(.weekday) の値（1=日曜〜7=土曜）
    let closedDays: [Int]

    func isOpen(at date: Date = Date()) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        if closedDays.contains(weekday) { return false }

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let currentMinutes = hour * 60 + minute
        let openMinutes = openHour * 60 + openMinute
        let closeMinutes = closeHour * 60 + closeMinute

        if openMinutes <= closeMinutes {
            return currentMinutes >= openMinutes && currentMinutes < closeMinutes
        } else {
            // 深夜営業などで日をまたぐ場合
            return currentMinutes >= openMinutes || currentMinutes < closeMinutes
        }
    }
}

/// 各店舗の情報。座標と現在地からの距離は後から非同期に埋まるため @Published にしている
final class Store: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let address: String
    let hours: BusinessHours
    let note: String

    @Published var coordinate: CLLocationCoordinate2D?
    @Published var distanceMeters: Double?

    init(name: String, address: String, hours: BusinessHours, note: String = "") {
        self.name = name
        self.address = address
        self.hours = hours
        self.note = note
    }
}
