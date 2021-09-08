
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
![新規登録画面](https://user-images.githubusercontent.com/66734337/132440615-4302b0a0-30ba-41ca-9bd3-8cc1a32fc5af.png)


### ログイン画面(devise)  
![ログイン画面](https://user-images.githubusercontent.com/66734337/132440656-639ca6c4-fba7-43cf-be90-f81f3966a2be.png)

### アカウント編集画面(devise)
  - ActiveStorage + AWS-S3による、画像登録機能の追加  

![アカウント編集画面](https://user-images.githubusercontent.com/66734337/132440688-41bc59aa-87d5-4f0d-be5b-62d6e74df980.png)

### ホーム画面
  - 作ったツーリング、参加予定のツーリングの一覧を表示  
  - イベント名のリンク押下時に、ツーリング詳細画面(モーダル)を表示する  
  - トークルームリンクを押下時にトークルームへ遷移する  

![ホーム画面](https://user-images.githubusercontent.com/66734337/132440764-9676d28a-0bd1-4472-9afc-5e6faeb7fd6f.png)

### ツーリング検索画面
  - ページネーション機能(kaminari)  

![検索画面](https://user-images.githubusercontent.com/66734337/132440829-b2979f76-c328-48aa-96ad-ca24f8242d96.png)


### ツーリング作成画面
  - 位置情報検索・表示機能(geocoder)  

![イベント新規作成画面](https://user-images.githubusercontent.com/66734337/132440881-94555b7e-2cf2-44fb-ac86-f2889a64f63f.png)

### ツーリング編集画面
  - 位置情報検索・表示機能(geocoder)  

![イベント編集画面](https://user-images.githubusercontent.com/66734337/132440934-1f9e1aaa-65eb-43ba-836a-e8fad1869265.png)

### ツーリング詳細画面(モーダルウィンドウ)
  - 位置表示機能(geocoder)  
  - 自分が作成したイベントの場合は編集ボタンを表示  

![イベント詳細画面(編集する)](https://user-images.githubusercontent.com/66734337/132440988-f0d91e3e-d146-4063-aed8-aa79ce4198ae.png)

  - 自分以外が作成したイベントの場合「参加/キャンセル」ボタンを表示(Ajax)  
![イベント詳細画面(参加)](https://user-images.githubusercontent.com/66734337/132440987-5086d592-1a39-49bc-a124-2d504e7d5a43.png)  

![イベント詳細画面(キャンセル)](https://user-images.githubusercontent.com/66734337/132440984-9ce4af87-038d-4c7a-91a7-205462a9e088.png)

  - 定員が埋まっている場合は「募集人数に達しました」ボタンを非活性で表示  

![イベント詳細画面(募集人数定員)](https://user-images.githubusercontent.com/66734337/132440989-020a66ab-1758-4a7a-9ca5-2e9ecde439f9.png)

  - イベント期間が過ぎた場合には「イベントは終了しました」ボタンを非活性で表示  

![イベント詳細画面(イベント期間終了)](https://user-images.githubusercontent.com/66734337/132440975-b7329f8f-7188-4af5-9215-73bfb7ad95ed.png)

### トーク画面
  - 参加者一覧を表示(ActiveStorage)  
  - リアルタイムチャット機能(ActionCable)

![チャット画面](https://user-images.githubusercontent.com/66734337/132441108-e28e3d6a-0ec8-43bf-8073-1568cc0d5ce3.png)

### ユーザー詳細画面
  - ページネーション機能(kaminari)  
  - フォロー機能(Ajax)

![ユーザー詳細画面](https://user-images.githubusercontent.com/66734337/132441185-a71e73ac-882c-4082-a19f-350d742d3ba9.png)

### プロフィール編集画面  

![プロフィール編集画面](https://user-images.githubusercontent.com/66734337/132441220-3f0e61d5-6ff2-47b0-9248-14d310ae27c5.png)

### フォロー一覧画面
  - フォロー機能(Ajax)  
![フォロー一覧画面](https://user-images.githubusercontent.com/66734337/132441245-6b9e0b57-5e01-423d-affc-af3b5bdfa329.png)

### フォロワー一覧画面
  - フォロー機能(Ajax)  
![フォロワー一覧画面](https://user-images.githubusercontent.com/66734337/132441279-dc54cc0f-181e-4489-ac3f-0a705bae57a3.png)

## テスト
### Rspec
  - 単体テスト(model)  
  - 結合テスト(feature)
