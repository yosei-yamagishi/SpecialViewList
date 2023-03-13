struct SubtitleInfo: Equatable {
    var thumbnailImageName: String = ""
    var subtitle: String
    var startTime: Double
    var endTime: Double
    
    func isActive(currentTime: Double) -> Bool {
        startTime <= currentTime && currentTime < endTime
    }
}

extension SubtitleInfo {
    static let sampleList: [SubtitleInfo] = [
        SubtitleInfo(subtitle: "あのドラマのような", startTime: 0.0, endTime: 2.5),
        SubtitleInfo(subtitle: "リアルの恋っていう", startTime: 2.5, endTime: 5.2),
        SubtitleInfo(subtitle: "感じかは", startTime: 5.2, endTime: 6.0),
        SubtitleInfo(subtitle: "ちょっと", startTime: 6.0, endTime: 6.2),
        SubtitleInfo(subtitle: "わかんないけど", startTime: 6.2, endTime: 6.8),
        SubtitleInfo(subtitle: "俺はそう思ってないけど", startTime: 6.8, endTime: 9.2),
        SubtitleInfo(subtitle: "相手は思ってたみたいな", startTime: 9.2, endTime: 9.8),
        SubtitleInfo(subtitle: "そういう話ですけど", startTime: 9.8, endTime: 12.4),
        SubtitleInfo(subtitle: "あのー", startTime: 12.4, endTime: 13.7),
        SubtitleInfo(subtitle: "僕セブ島に留学してたことがあって", startTime: 13.7, endTime: 16.3),
        SubtitleInfo(subtitle: "あの結構", startTime: 16.3, endTime: 17.6),
        SubtitleInfo(subtitle: "あのーセブって", startTime: 17.6, endTime: 18.2),
        SubtitleInfo(subtitle: "結構", startTime: 18.2, endTime: 18.7),
        SubtitleInfo(subtitle: "フレンドリーなんですよ", startTime: 18.7, endTime: 19.6),
        SubtitleInfo(subtitle: "人が", startTime: 19.6, endTime: 20.6),
        SubtitleInfo(subtitle: "なんかいろいろ", startTime: 20.6, endTime: 21.3),
        SubtitleInfo(subtitle: "俺もなんか", startTime: 21.3, endTime: 22.1),
        SubtitleInfo(subtitle: "話しかけられたりしたら", startTime: 22.1, endTime: 23.4),
        SubtitleInfo(subtitle: "すぐfacebook", startTime: 23.4, endTime: 24.0),
        SubtitleInfo(subtitle: "交換して", startTime: 24.0, endTime: 25.3),
        SubtitleInfo(subtitle: "友達になって", startTime: 25.3, endTime: 26.1),
        SubtitleInfo(subtitle: "ある日", startTime: 26.1, endTime: 27.2),
        SubtitleInfo(subtitle: "そのカフェで", startTime: 27.2, endTime: 28.3),
        SubtitleInfo(subtitle: "勉強してたんですけど", startTime: 28.3, endTime: 30.0)
    ]
}

extension SubtitleInfo {
    
    static let videoSampleList: [SubtitleInfo] = [
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page1",
            subtitle: "[音楽]",
            startTime: 0,
            endTime: 5
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page2",
            subtitle: "[拍手]",
            startTime: 5,
            endTime: 13
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page3",
            subtitle: "はいどうもー！言ってますけども元気に始めていきたいなと思います！",
            startTime: 13,
            endTime: 18
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page3",
            subtitle: "今回ですね発表させていただくのはCloud SpeechToTextで音声を動画にして",
            startTime: 18,
            endTime: 24
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "話っていうところで刃喋っていきたいとおもいます。はいでは自己紹介的な感じなんですけど僕の名前妖精って言うんですけどまぁ本名で",
            startTime: 24,
            endTime: 33
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "あのフェアリーエンジニアというアカウントでやってるんでよかったらフォローしてください",
            startTime: 33,
            endTime: 38
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "手を大阪出身なんであの関西弁は多めなんであのう 聞きづらいなぁって思うところあるかもしれないですけどちょっと耐えていただいて",
            startTime: 38,
            endTime: 48
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "っていうことですねぼく ios エンジンや3年目3れきっと歴で言ったら3年目な",
            startTime: 48,
            endTime: 54
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "んですけど で今まで担当してきたサービスなんですけど僕エキサイトという所に就職して",
            startTime: 54,
            endTime: 60
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page4",
            subtitle: "エキサイトブログっていう ios の担当したりとかですね ドラ子をトークっていうアプリの ios のエンジニアをやってました",
            startTime: 60,
            endTime: 68
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page5",
            subtitle: "やってます でまぁアジェンダなんですけどラジオトークの紹介僕が今作っているアプリですね",
            startTime: 68,
            endTime: 77
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page5",
            subtitle: "でなぜ音声を動画にしたかっていうところとあと テロップ動画の実装っていうところ説明していきたいとおもいます",
            startTime: 77,
            endTime: 86
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page6",
            subtitle: "でまぁラジオトークなんですけど皆さんラジオトークってご存知ですか",
            startTime: 86,
            endTime: 92
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page6",
            subtitle: "あ、います、あ、います。知らない人は今日覚えていてくれてください。えっとラジオトークっていうのはですね。まぁ株式エキサイト株式会社から",
            startTime: 92,
            endTime: 102
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page6",
            subtitle: "えっとサービスとして出したんですけどまぁその mbs の出資を受けて後会社化し",
            startTime: 102,
            endTime: 108
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "カーブアウトした会社になっていますそこのサービスなんですけど、Radiotalkってどんなサービスかっていうと",
            startTime: 108,
            endTime: 116
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "説明していきます。 Radiotalkというのは1タップで簡単にいつでもどこでも音声配信できるアプリなん",
            startTime: 116,
            endTime: 125
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "ですけどまぁ まぁこんな感じでですね。ホーム画面があってユーザーさんがアップ",
            startTime: 125,
            endTime: 133
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "ラジオトークのアプリ内で収録した音声コンテンツを",
            startTime: 133,
            endTime: 139
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "その音声コンテンツを聞けたりとかですね、音声配信のプラットフォームになってい",
            startTime: 139,
            endTime: 144
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "ます まあここのはですねマイクボタンを押してもらうと 収録ボタン",
            startTime: 144,
            endTime: 151
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "をしてもらうと収録回収録画面が立ち上がって収録の開始ボタンを押してもらうと",
            startTime: 151,
            endTime: 158
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "MAX12分まで収録することができて まあその収録時に効果音であったりとか大台とかであったりとかっていうのを見ながら",
            startTime: 158,
            endTime: 167
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page7",
            subtitle: "配信できるんでまぁ初心者の人でも 簡単にトークの配信をすることができます",
            startTime: 167,
            endTime: 175
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page8",
            subtitle: "今回はですねラジオトークの",
            startTime: 175,
            endTime: 180
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page8",
            subtitle: "この内の音声コンテンツを動画にしたっていう話をしていきたいとおもいます",
            startTime: 180,
            endTime: 187
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page9",
            subtitle: "では なぜ音声を動画にしたんだっていうところなんですけど",
            startTime: 187,
            endTime: 193
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page10",
            subtitle: "皆さん音声コンテンツって聞かれたりしますか?ラジオとかでもいいんですけど あ結構聞かれる、結構聞かれますね",
            startTime: 193,
            endTime: 201
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page11",
            subtitle: "で 音声コンテンツって配信経験あったりしますか皆さんどうでしょうか？結構少ないと思うんですけども配信された方はわかると思うんですけど",
            startTime: 201,
            endTime: 214
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page12",
            subtitle: " 音声コンテンツの課題として届けに来いっていう課題があるんですね",
            startTime: 214,
            endTime: 218
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page12",
            subtitle: "何が届けにくいかっていうと音声コンテンツって動画とか画像と違ってですねビジュアルがない分、届けにくいてところなんですけど、情報量が少ないっていうところと",
            startTime: 218,
            endTime: 232
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page12",
            subtitle: "あと再生しないとコンテンツを摂取できないそもそも っていうところでまあ環境によっては音声を再生できなかったりイヤホンをつけて",
            startTime: 232,
            endTime: 242
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page12",
            subtitle: "なかったから再生できなかったいっていうところがあると思うんですね ではですね越冬音声コンテンツって結構たくさん面白いものがあるんですね",
            startTime: 242,
            endTime: 251
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page13",
            subtitle: "でもっと 届けたいと思うんですね今思った時にどうすればいいかっていうところで",
            startTime: 251,
            endTime: 259
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page14",
            subtitle: "音声コンテンツを聞く以外の体験 だったりとか聞く以外の情報を提供できたらどうなんだろうって考えました",
            startTime: 259,
            endTime: 269
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page15",
            subtitle: "でそこでですね音声コンテンツ自体を音声解析して文字起こしして動画にしちゃえ",
            startTime: 269,
            endTime: 276
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page16",
            subtitle: "っていう感じで動画にしちゃいました。 テロップ動画機能を作ったんですけど",
            startTime: 276,
            endTime: 284
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page16",
            subtitle: "これはテロップ動画どういうものかってちょっと見てほしいんですけど、こんな感じでほんと音声流れるんですけど",
            startTime: 284,
            endTime: 291
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page16",
            subtitle: "音声と同じようにして音声解析した文字が次から次へと",
            startTime: 291,
            endTime: 298
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page16",
            subtitle: "パラパラ漫画みたいな感じで出てきます。これをラジオトーク内で配信した音声の20秒間を取り出して音声解析を行って、その文字起こしを起こした内容を使って動画を作るということをしています。テロップ動画を作ることによって",
            startTime: 298,
            endTime: 324
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page17",
            subtitle: "テロップで情報量がアップするっていうのとsns での接触機会っていうのがアップするっていうのと 面白い部分が切り撮れるというところがありますでまぁテロップ動画ってどれ実装者の",
            startTime: 324,
            endTime: 337
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page18",
            subtitle: "っていうところを説明していきたいとおもいます",
            startTime: 337,
            endTime: 342
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page19",
            subtitle: "はいテロップ動画を作る手順として3つの画面があるんですけど トリミング画面、音声トリミングする画面でテロップ編集画面、シェア画面ってあるんですけど一つ一つどういうことを行っているかというのを説明していきます",
            startTime: 342,
            endTime: 357
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page20",
            subtitle: "トリミング画面では音声のトークのトリミングを行って音声解析の APIに投げています。",
            startTime: 357,
            endTime: 367
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page21",
            subtitle: "テロップ編集画面ではその音声解析後の文字起こしされたものっていうのを使ってプレビュー再生ができてテロップの編集が行えて動画の作成をすることができます",
            startTime: 367,
            endTime: 381
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page22",
            subtitle: "シェア画面ではプレビューその文字を越されテロップ画面が動画を再生することができてSNSにシェアできて端末に保存することができます",
            startTime: 381,
            endTime: 394
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page23",
            subtitle: "では処理の切り分けなんですけど、アプリ側とサーバーサイド側でどういうことをやっているかと言うところなんですけどアプリ側では音声ファイルをトリミングを行います。",
            startTime: 394,
            endTime: 408
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page23",
            subtitle: "音声ファイルをサーバーサイド方にアップロードします 。音声ファイルを変換させ変換して音声解析で文字起こしします",
            startTime: 408,
            endTime: 419
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page23",
            subtitle: "文字起こし結果をアプリの方に 戻してそれをテロップ編集してテロップ動画を作成します",
            startTime: 419,
            endTime: 426
        ),
        SubtitleInfo(
            thumbnailImageName: "cloud-speech-to-text_page23",
            subtitle: "アプリのほうで動画を作成しています",
            startTime: 426,
            endTime: 429
        )
    ]
}
