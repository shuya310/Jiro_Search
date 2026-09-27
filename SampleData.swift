import Foundation

// 注意: 営業時間・定休日は変更されることが多いため、必ず各店の公式SNSなどで
// 最新情報を確認して書き換えること。ここではアプリの動作確認用のサンプル値。
enum SampleData {
    static let jiroStores: [Store] = [
        Store(
            name: "ラーメン二郎 三田本店",
            address: "東京都港区三田2丁目16-4",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 15, closeMinute: 0, closedDays: [1, 7])
        ),
        Store(
            name: "ラーメン二郎 ひばりヶ丘駅前店",
            address: "東京都西東京市谷戸町3丁目27-24",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 20, closeMinute: 0, closedDays: [2])
        ),
        Store(
            name: "ラーメン二郎 千葉店",
            address: "千葉県千葉市中央区中央1丁目7-8",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 15, closeMinute: 0, closedDays: [1])
        ),
        Store(
            name: "ラーメン二郎 めじろ台店",
            address: "東京都八王子市椚田町513-9",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 15, closeMinute: 0, closedDays: [1])
        ),
        Store(
            name: "ラーメン二郎 横浜関内店",
            address: "神奈川県横浜市中区長者町6丁目94-94",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 21, closeMinute: 0, closedDays: [1])
        ),
        Store(
            name: "ラーメン二郎 神田神保町店",
            address: "東京都千代田区神田神保町1丁目21-4",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 16, closeMinute: 0, closedDays: [1])
        ),
        Store(
            name: "ラーメン二郎 上野毛店",
            address: "東京都世田谷区上野毛1丁目26-16",
            hours: BusinessHours(openHour: 11, openMinute: 0, closeHour: 15, closeMinute: 0, closedDays: [1])
        ),
        Store(
            name: "ラーメン二郎 環七一之江店",
            address: "東京都江戸川区一之江8丁目3-4",
            hours: BusinessHours(openHour: 10, openMinute: 45, closeHour: 15, closeMinute: 0, closedDays: [1])
        )
    ]
}
