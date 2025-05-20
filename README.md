# SpecialViewList
UIKit をベースにした少し手間のかかる View を `CustomView` として切り出し、
サンプル集としてまとめたデモアプリです。スクリーンショットと実際の動作例を
下記に掲載しています。

<img src="https://user-images.githubusercontent.com/22518469/169925865-82edfd54-7b50-4164-9830-177651f8ed69.png" width="278">

ex)
<video src="https://user-images.githubusercontent.com/22518469/174517908-6fd87132-cfa9-4c66-a3bd-bafc7948397d.mp4"></video>

## はじめかた
1. `SpecialViewList.xcodeproj` を Xcode で開きます。
2. `SpecialViewList` ターゲットを選択し、ビルドして実行します。

## 主なディレクトリ
- `Component/` - 各画面やカスタムビューの実装
- `Extenstion/` - UIKit など既存クラスの拡張
- `Foundation/` - 共通部品や基盤コード
- `Entity/` - サンプルで使用するモデル定義
- `Assets/` - 画像や動画などのリソース

## 収録されているサンプル一例
- `grid3x3` – ラベル幅が可変になる 3 行 × 3 列のアイテム表示
- `subtitlePlayer` – 音声再生と字幕表示を連動させたプレイヤー
- `videoCollection` – フリックで複数動画を閲覧できるビュー
- `choiceForm` – 選択肢を追加できる入力フォーム

その他にも SwiftUI の `UIHostingController` を利用した画面など、
様々な UI 実装方法を試すことができます。
