import Foundation

// 注意: 営業時間・定休日は変更されることが多いため、必ず各店の公式SNSで最新情報を確認すること。
// weekday: 1=日, 2=月, 3=火, 4=水, 5=木, 6=金, 7=土

private typealias BH = BusinessHours
private typealias TS = TimeSlot

enum SampleData {
    static let jiroStores: [Store] = [

        // MARK: - 東京都

        Store(
            name: "ラーメン二郎 三田本店",
            address: "東京都港区三田2-16-4",
            nearestStation: "JR田町駅・都営三田駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(8,30, to: 20,0))
        ),
        Store(
            name: "ラーメン二郎 目黒店",
            address: "東京都目黒区目黒3-7-2",
            nearestStation: "JR目黒駅・東急中目黒駅",
            hours: BH.uniform(openDays: [1,2,3,4,5,6,7], TS(11,0, to: 16,0), TS(18,0, to: 22,0)),
            twitterAccount: "@meguro_jiro"
        ),
        Store(
            name: "ラーメン二郎 仙川店",
            address: "東京都調布市仙川町1-10-17",
            nearestStation: "京王仙川駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(17,0, to: 21,0)),
            twitterAccount: "@senjiro26",
            note: "スープ切れ次第終了"
        ),
        Store(
            name: "ラーメン二郎 新宿歌舞伎町店",
            address: "東京都新宿区歌舞伎町2-37-5",
            nearestStation: "JR新宿駅・西武新宿駅",
            // 11:30〜翌2:30（26:30表記）
            hours: BH.uniform(openDays: [1,2,3,5,6,7], TS(11,30, to: 2,30)),
            twitterAccount: "@kabujiikeji"
        ),
        Store(
            name: "ラーメン二郎 品川店",
            address: "東京都品川区北品川1-18-5",
            nearestStation: "JR品川駅・京急北品川駅",
            hours: BH.custom(
                baseSlots: [TS(10,0, to: 14,0), TS(17,0, to: 21,0)],
                openDays: [2,3,4,5,6],
                overrides: [7: [TS(10,0, to: 14,0)]]
            ),
            twitterAccount: "@shinagawa26"
        ),
        Store(
            name: "ラーメン二郎 新宿小滝橋通り店",
            address: "東京都新宿区西新宿7-5-5",
            nearestStation: "JR新宿駅・西武新宿駅",
            hours: BH.uniform(openDays: [1,2,3,4,5,6,7], TS(11,0, to: 22,0)),
            note: "元日のみ休業"
        ),
        Store(
            name: "ラーメン二郎 環七新新代田店",
            address: "東京都世田谷区代田5-29-5",
            nearestStation: "京王新代田駅",
            hours: BH.uniform(openDays: [1,3,4,5,6,7], TS(11,0, to: 15,0)),
            twitterAccount: "@26shinshindaita",
            note: "不定休あり・公式Xで確認"
        ),
        Store(
            name: "ラーメン二郎 八王子野猿街道店2",
            address: "東京都八王子市堀之内2-13-16",
            nearestStation: "京王堀之内駅",
            hours: BH(schedule: [
                1: [TS(8,0, to: 15,0)],                          // 日
                3: [TS(11,0, to: 15,0), TS(17,30, to: 21,0)],   // 火
                4: [TS(11,0, to: 15,0), TS(17,30, to: 21,0)],   // 水
                5: [TS(11,0, to: 15,0), TS(17,30, to: 21,0)],   // 木
                6: [TS(11,0, to: 15,0), TS(17,30, to: 21,0)],   // 金
                7: [TS(11,0, to: 20,0)]                           // 土・祝
            ]),
            twitterAccount: "@Jiro_Yaenkaido2"
        ),
        Store(
            name: "ラーメン二郎 池袋東口店",
            address: "東京都豊島区南池袋2-27-17",
            nearestStation: "JR池袋駅",
            hours: BH.uniform(openDays: [1,3,4,5,6,7], TS(10,30, to: 16,30)),
            twitterAccount: "@ikejikabuji",
            note: "月曜は祝日のみ営業・翌火曜振替休"
        ),
        Store(
            name: "ラーメン二郎 亀戸店",
            address: "東京都江東区亀戸4-35-17",
            nearestStation: "JR亀戸駅",
            hours: BH.uniform(openDays: [1,2,3,4,5,6,7], TS(11,0, to: 14,0), TS(17,30, to: 21,0)),
            twitterAccount: "@jiro_kame",
            note: "臨時休業は公式Xで告知"
        ),
        Store(
            name: "ラーメン二郎 府中店",
            address: "東京都府中市宮西町1-15-5",
            nearestStation: "京王府中駅",
            hours: BH.uniform(openDays: [2,3,4,5,6], TS(17,0, to: 22,0)),
            twitterAccount: "@jiro_fuchu"
        ),
        Store(
            name: "ラーメン二郎 めじろ台店",
            address: "東京都八王子市椚田町513-9",
            nearestStation: "京王めじろ台駅",
            hours: BH(schedule: [
                1: [TS(11,0, to: 15,0)],                          // 日
                2: [TS(11,0, to: 14,30), TS(17,30, to: 20,30)],  // 月
                3: [TS(11,0, to: 14,30), TS(17,30, to: 20,30)],  // 火
                4: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],   // 水
                6: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],   // 金
                7: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)]    // 土
            ]),
            twitterAccount: "@mejirodai_jiro"
        ),
        Store(
            name: "ラーメン二郎 荻窪店",
            address: "東京都杉並区荻窪4-33-1",
            nearestStation: "JR荻窪駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(11,30, to: 14,15), TS(18,0, to: 21,45)),
            twitterAccount: "@ogkb_jiro"
        ),
        Store(
            name: "ラーメン二郎 上野毛店",
            address: "東京都世田谷区上野毛1-26-16",
            nearestStation: "東急上野毛駅",
            hours: BH.custom(
                baseSlots: [TS(11,0, to: 14,15), TS(18,0, to: 22,0)],
                openDays: [2,3,4,5,6],
                overrides: [7: [TS(11,0, to: 14,30)]]
            ),
            twitterAccount: "@KaminogeJiro"
        ),
        Store(
            name: "ラーメン二郎 環七一之江店",
            address: "東京都江戸川区一之江8-3-4",
            nearestStation: "都営一之江駅",
            hours: BH(schedule: [
                1: [TS(9,0, to: 14,0)],                           // 日・祝
                2: [TS(10,30, to: 14,0), TS(17,30, to: 20,30)],  // 月
                3: [TS(10,30, to: 14,0), TS(17,30, to: 20,30)],  // 火
                5: [TS(10,30, to: 14,0), TS(17,30, to: 20,30)],  // 木
                6: [TS(10,30, to: 14,0), TS(17,30, to: 20,30)],  // 金
                7: [TS(9,0, to: 14,0)]                            // 土・祝
            ]),
            twitterAccount: "@ichinoejiro"
        ),
        Store(
            name: "ラーメン二郎 神田神保町店",
            address: "東京都千代田区神田神保町1-21-4",
            nearestStation: "都営・メトロ神保町駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(11,0, to: 17,30)),
            twitterAccount: "@jbc_jimbolian",
            note: "材料切れ次第終了"
        ),
        Store(
            name: "ラーメン二郎 小岩店",
            address: "東京都江戸川区西小岩3-31-13",
            nearestStation: "JR小岩駅",
            hours: BH.uniform(openDays: [3,4,5,6], TS(10,30, to: 15,0)),
            twitterAccount: "@koiwajiro",
            note: "土曜はテイクアウト事前予約者のみ（公式X要確認）・麺切れ次第終了"
        ),
        Store(
            name: "ラーメン二郎 ひばりヶ丘駅前店",
            address: "東京都西東京市谷戸町3-27-24",
            nearestStation: "西武ひばりヶ丘駅",
            hours: BH(schedule: [
                2: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],  // 月
                3: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],  // 火
                4: [TS(11,30, to: 14,30)],                         // 水
                5: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],  // 木
                6: [TS(11,30, to: 14,30), TS(18,0, to: 21,0)],  // 金
                7: [TS(11,0, to: 17,0)]                           // 土
            ]),
            twitterAccount: "@Aarf0xvdBXkWd7o",
            note: "不定休あり・公式Xで確認"
        ),
        Store(
            name: "ラーメン二郎 立川店",
            address: "東京都立川市柴崎町2-10-1",
            nearestStation: "JR立川駅",
            hours: BH.uniform(openDays: [1,2,3,5,6,7], TS(11,0, to: 14,30), TS(17,30, to: 20,30)),
            twitterAccount: "@jirotachikawa",
            note: "不定休あり・公式Xで確認"
        ),
        Store(
            name: "ラーメン二郎 千住大橋駅前店",
            address: "東京都足立区千住橋戸町10-8",
            nearestStation: "京成千住大橋駅",
            hours: BH.uniform(openDays: [2,3,4,6], TS(10,30, to: 15,30)),
            twitterAccount: "@senjujirou26",
            note: "土曜はテイクアウト販売のみ"
        ),
        Store(
            name: "ラーメン二郎 西台駅前店",
            address: "東京都板橋区蓮根3-9-7",
            nearestStation: "都営西台駅",
            hours: BH(schedule: [
                2: [TS(11,0, to: 13,30), TS(17,30, to: 20,30)],  // 月
                3: [TS(11,0, to: 13,30), TS(17,30, to: 20,30)],  // 火
                4: [TS(11,0, to: 13,30)],                           // 水
                5: [TS(11,0, to: 13,30), TS(17,30, to: 20,30)],  // 木
                6: [TS(11,0, to: 13,30), TS(17,30, to: 20,30)],  // 金
                7: [TS(9,30, to: 12,30)]                            // 土
            ]),
            twitterAccount: "@jiro_nishidai"
        ),
        Store(
            name: "ラーメン二郎 一橋学園店",
            address: "東京都小平市学園西町2-13-4",
            nearestStation: "西武一橋学園駅",
            hours: BH(schedule: [
                1: [TS(11,0, to: 16,0)],                           // 日
                2: [TS(11,0, to: 14,0), TS(17,30, to: 20,30)],   // 月
                3: [TS(11,0, to: 14,0), TS(17,30, to: 20,30)],   // 火
                4: [TS(11,0, to: 14,0), TS(17,30, to: 20,30)],   // 水
                6: [TS(11,0, to: 14,0), TS(17,30, to: 20,30)],   // 金
                7: [TS(11,0, to: 15,0)]                            // 土
            ]),
            twitterAccount: "@1284jiro"
        ),

        // MARK: - 神奈川県

        Store(
            name: "ラーメン二郎 京急川崎店",
            address: "神奈川県川崎市川崎区本町2-10",
            nearestStation: "京急川崎駅",
            hours: BH.custom(
                baseSlots: [TS(11,0, to: 14,0), TS(18,0, to: 22,0)],
                openDays: [2,3,4,5,6],
                overrides: [7: [TS(11,0, to: 16,0)]]
            ),
            twitterAccount: "@jiro_kwsk_bot"
        ),
        Store(
            name: "ラーメン二郎 相模大野店",
            address: "神奈川県相模原市南区相模大野6-14-9",
            nearestStation: "小田急相模大野駅",
            hours: BH(schedule: [
                1: [TS(10,0, to: 15,0)],                           // 日
                3: [TS(10,20, to: 14,0)],                           // 火
                4: [TS(10,20, to: 14,0), TS(17,0, to: 20,30)],    // 水
                5: [TS(10,20, to: 14,0), TS(17,0, to: 20,30)],    // 木
                6: [TS(17,0, to: 20,30)],                           // 金
                7: [TS(10,0, to: 15,0)]                             // 土
            ]),
            twitterAccount: "@sumo_jiro",
            note: "不定休あり・公式Xで確認"
        ),
        Store(
            name: "ラーメン二郎 横浜関内店",
            address: "神奈川県横浜市中区長者町6-94",
            nearestStation: "JR関内駅・市営地下鉄伊勢佐木長者町駅",
            hours: BH.uniform(openDays: [1,2,3,5,6,7], TS(11,0, to: 14,30), TS(17,0, to: 21,0)),
            twitterAccount: "@kannaijiro"
        ),
        Store(
            name: "ラーメン二郎 湘南藤沢店",
            address: "神奈川県藤沢市本町1-10-14",
            nearestStation: "JR・小田急藤沢駅",
            hours: BH.uniform(openDays: [1,2,4,5,6,7], TS(11,0, to: 14,30), TS(17,0, to: 21,0)),
            twitterAccount: "@fujirow26"
        ),
        Store(
            name: "ラーメン二郎 中山駅前店",
            address: "神奈川県横浜市緑区台村町309-1",
            nearestStation: "JR・市営地下鉄中山駅",
            hours: BH.uniform(openDays: [1,2,3,4,6,7], TS(11,0, to: 14,0), TS(18,0, to: 21,30)),
            twitterAccount: "@NKYMJIRO"
        ),
        Store(
            name: "ラーメン二郎 生田駅前店",
            address: "神奈川県川崎市多摩区生田8-1-15",
            nearestStation: "小田急生田駅",
            hours: BH.uniform(openDays: [1,2,3,5,6,7], TS(11,0, to: 15,0), TS(18,0, to: 21,0)),
            twitterAccount: "@ikuta_jiro"
        ),

        // MARK: - 千葉県

        Store(
            name: "ラーメン二郎 松戸駅前店III",
            address: "千葉県松戸市本町17-9",
            nearestStation: "JR・新京成松戸駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(17,30, to: 21,30)),
            twitterAccount: "@matsudojiro3",
            note: "不定休あり・公式Xで確認"
        ),
        Store(
            name: "ラーメン二郎 京成大久保店",
            address: "千葉県船橋市三山2-1-11",
            nearestStation: "京成大久保駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(11,0, to: 15,0))
        ),
        Store(
            name: "ラーメン二郎 柏店",
            address: "千葉県柏市十余二249-5",
            nearestStation: "つくばエクスプレス柏の葉キャンパス駅",
            hours: BH.uniform(openDays: [1,3,4,5,6,7], TS(11,0, to: 15,0), TS(17,30, to: 21,30)),
            twitterAccount: "@genkimoriya"
        ),
        Store(
            name: "ラーメン二郎 千葉店",
            address: "千葉県千葉市中央区中央1-7-8",
            nearestStation: "JR千葉駅・千葉都市モノレール葭川公園駅",
            hours: BH.uniform(openDays: [2,3,4,5,6,7], TS(11,0, to: 14,30), TS(17,0, to: 21,30)),
            twitterAccount: "@jiro_chiba",
            note: "不定休あり・公式Xで確認"
        ),

        // MARK: - 埼玉県

        Store(
            name: "ラーメン二郎 川越店",
            address: "埼玉県川越市旭町1-4-15",
            nearestStation: "JR・東武川越駅",
            hours: BH.custom(
                baseSlots: [TS(11,0, to: 14,0), TS(18,0, to: 21,0)],
                openDays: [3,4,5,6,7],
                overrides: [1: [TS(11,0, to: 14,0)]]
            ),
            twitterAccount: "@kwge26"
        ),
        Store(
            name: "ラーメン二郎 越谷店",
            address: "埼玉県越谷市越ヶ谷2-3-7",
            nearestStation: "東武越谷駅",
            hours: BH.uniform(openDays: [2,3,4,5,6], TS(11,30, to: 19,0)),
            twitterAccount: "@ksgy26"
        ),
        Store(
            name: "ラーメン二郎 大宮公園駅前店",
            address: "埼玉県さいたま市大宮区寿能町1-24",
            nearestStation: "東武大宮公園駅",
            hours: BH(schedule: [
                1: [TS(11,0, to: 15,0)],                            // 日・祝
                2: [TS(11,30, to: 14,30), TS(17,30, to: 21,0)],   // 月
                3: [TS(11,30, to: 14,30), TS(17,30, to: 21,0)],   // 火
                5: [TS(11,30, to: 14,30), TS(17,30, to: 21,0)],   // 木
                6: [TS(11,30, to: 14,30), TS(17,30, to: 21,0)],   // 金
                7: [TS(11,30, to: 14,30), TS(17,30, to: 21,0)]    // 土
            ]),
            twitterAccount: "@omiyapark26"
        ),

        // MARK: - 茨城県

        Store(
            name: "ラーメン二郎 ひたちなか店",
            address: "茨城県ひたちなか市田彦1648-4",
            nearestStation: "JR勝田駅",
            hours: BH.custom(
                baseSlots: [TS(11,0, to: 14,30), TS(17,30, to: 21,0)],
                openDays: [2,3,4,5,6],
                overrides: [7: [TS(10,0, to: 16,0)]]
            ),
            twitterAccount: "@26_hitachinaka",
            note: "連休時は変更あり"
        ),

        // MARK: - 栃木県

        Store(
            name: "ラーメン二郎 栃木街道店",
            address: "栃木県下都賀郡壬生町本丸2-15-67",
            nearestStation: "東武壬生駅",
            hours: BH.custom(
                baseSlots: [TS(11,30, to: 14,45), TS(18,0, to: 21,0)],
                openDays: [2,3,4,5,6],
                overrides: [7: [TS(11,30, to: 16,0)]]
            ),
            twitterAccount: "@Tochigikaidoten",
            note: "不定休あり・公式Xで確認"
        ),

        // MARK: - 群馬県

        Store(
            name: "ラーメン二郎 前橋千代田町店",
            address: "群馬県前橋市千代田町4-12-3",
            nearestStation: "上毛電鉄中央前橋駅",
            hours: BH.uniform(openDays: [1,3,4,5,6,7], TS(10,30, to: 14,30), TS(17,0, to: 20,0)),
            twitterAccount: "@SnBZt6eRCdz7lQw"
        ),
    ]
}
