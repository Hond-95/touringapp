
# RidersLink

## 概要
バイク人口が年々減少している中で、一緒にバイクを楽しむ仲間を探すことが難しくなってきています。  
その現状の中で一緒に誰かとツーリングしたい人同士を繋げる事ができるアプリです。

  リンク  
  ・https://touringapp.herokuapp.com/

## 使用技術
・Ruby 2.6.3  
・Ruby on Rails 6.0.0  
・Mysql2 0.5.3  
・Puma  
・Heroku  
・Docker/Docker-compose  
・Rspec  
・Google Maps API

## 画面一覧
### トップ画面  
![トップページ](https://user-images.githubusercontent.com/66734337/132440085-43cb7347-83c8-41c4-8a10-30b59297f1e0.png)

### 新規登録画面(devise)

### ログイン画面(devise)

### アカウント編集画面(devise)
  - ActiveStorage + AWS-S3による、画像登録機能の追加

### ホーム画面
  - 作ったツーリング、参加予定のツーリングの一覧を表示  
  - イベント名のリンク押下時に、ツーリング詳細画面(モーダル)を表示する  
  - トークルームリンクを押下時にトークルームへ遷移する

### ツーリング検索画面
  - ページネーション機能(kaminari)

### ツーリング作成画面
  - 位置情報検索・表示機能(geocoder)

### ツーリング編集画面
  - 位置情報検索・表示機能(geocoder)

### ツーリング詳細画面(モーダルウィンドウ)
  - 位置表示機能(geocoder)  
  - 自分が作成したイベントの場合は編集ボタンを表示  
  - 自分以外が作成したイベントの場合「参加/キャンセル」ボタンを表示(Ajax)  
  - 定員が埋まっている場合は「募集人数に達しました」ボタンを非活性で表示  
  - イベント期間が過ぎた場合には「イベントは終了しました」ボタンを非活性で表示  

### トーク画面
  - 参加者一覧を表示(ActiveStorage)  
  - リアルタイムチャット機能(ActionCable)

### ユーザー詳細画面
  - ページネーション機能(kaminari)  
  - フォロー機能(Ajax)

### プロフィール編集画面

### フォロー一覧画面
  - フォロー機能(Ajax)  

### フォロワー一覧画面
  - フォロー機能(Ajax)

## テスト
### Rspec
  - 単体テスト(model)  
  - 結合テスト(feature)
