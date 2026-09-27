import Foundation
import CoreLocation
import Combine

struct TimeSlot {
    let openHour: Int
    let openMinute: Int
    let closeHour: Int
    let closeMinute: Int

    init(_ openH: Int, _ openM: Int, to closeH: Int, _ closeM: Int) {
        openHour = openH; openMinute = openM
        closeHour = closeH; closeMinute = closeM
    }

    func contains(hour: Int, minute: Int) -> Bool {
        let cur = hour * 60 + minute
        let op = openHour * 60 + openMinute
        let cl = closeHour * 60 + closeMinute
        return op <= cl ? (cur >= op && cur < cl) : (cur >= op || cur < cl)
    }

    var displayString: String {
        String(format: "%02d:%02d〜%02d:%02d", openHour, openMinute, closeHour, closeMinute)
    }
}

/// 営業スケジュール。曜日 (Calendar.weekday: 1=日〜7=土) → 時間帯リスト
struct BusinessHours {
    /// key: weekday (1=日, 2=月, …, 7=土)  value: 時間帯リスト (空 or nil = 定休)
    let schedule: [Int: [TimeSlot]]

    /// 全曜日に同じ時間帯を設定するファクトリ
    static func uniform(openDays: [Int], _ slots: TimeSlot...) -> BusinessHours {
        BusinessHours(schedule: Dictionary(uniqueKeysWithValues: openDays.map { ($0, Array(slots)) }))
    }

    /// 大半の日は同じ時間帯、特定の日のみ異なるファクトリ
    static func custom(baseSlots: [TimeSlot], openDays: [Int],
                       overrides: [Int: [TimeSlot]] = [:]) -> BusinessHours {
        var schedule: [Int: [TimeSlot]] = [:]
        for day in openDays { schedule[day] = baseSlots }
        for (day, slots) in overrides { schedule[day] = slots }
        return BusinessHours(schedule: schedule)
    }

    func isOpen(at date: Date = Date()) -> Bool {
        let cal = Calendar.current
        let wd = cal.component(.weekday, from: date)
        guard let slots = schedule[wd], !slots.isEmpty else { return false }
        let h = cal.component(.hour, from: date)
        let m = cal.component(.minute, from: date)
        return slots.contains { $0.contains(hour: h, minute: m) }
    }

    private static let dayNames = [1: "日", 2: "月", 3: "火", 4: "水", 5: "木", 6: "金", 7: "土"]

    /// 定休日の表示文字列
    var closedDaysText: String {
        let closed = (1...7).filter { schedule[$0] == nil || schedule[$0]!.isEmpty }
        guard !closed.isEmpty else { return "無休" }
        return closed.compactMap { Self.dayNames[$0] }.joined(separator: "・") + "曜定休"
    }

    /// 代表的な営業時間（最初の開店日の時間帯）
    var representativeHoursText: String {
        for day in [2, 3, 4, 5, 6, 7, 1] {
            if let slots = schedule[day], !slots.isEmpty {
                return slots.map(\.displayString).joined(separator: " / ")
            }
        }
        return "要確認"
    }
}

/// 各店舗の情報
@MainActor
final class Store: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let address: String
    let nearestStation: String
    let hours: BusinessHours
    let twitterAccount: String?
    let note: String

    @Published var coordinate: CLLocationCoordinate2D?
    @Published var distanceMeters: Double?

    init(name: String, address: String, nearestStation: String,
         hours: BusinessHours, twitterAccount: String? = nil, note: String = "") {
        self.name = name
        self.address = address
        self.nearestStation = nearestStation
        self.hours = hours
        self.twitterAccount = twitterAccount
        self.note = note
    }
}
