---
title: "YouTube DataAPIv3 でプレイリストに動画を追加する"
slug: youtube-data-api-insert-playlistitems
date: 2020-04-29T12:41:01+09:00
draft: false
author: sakamossan
---

工程はこんな感じになる

- GCPのコンソールでYouTubeDataAPIv3をenableにする
- OAuthトークンを取得
- `youtube.playlistItems.insert` を呼ぶ

トークンを取得するのが面倒なのだが、サービスアカウントの認証情報でそのままリクエストを投げることはできないようだ

> アプリケーションは OAuth 2.0 トークンを、非公開のユーザー情報にアクセスするリクエストと共に送信しなければなりません。アプリケーションはクライアント ID と、場合によってクライアント シークレットを、トークンを取得するために送信します。ウェブ アプリケーション、サービス アカウント、インストール型アプリケーションで使用する OAuth 2.0 認証情報を作成できます。

- [承認の認証情報を取得する  |  YouTube Data API  |  Google Developers](https://developers.google.com/youtube/registering_an_application?hl=ja)


## GCPのコンソールでYouTubeDataAPIv3をenableにする

GCPの管理画面で操作してenableにする

この記事はスクショが多くてよさそうである

- [YouTube API APIキーの取得方法 - Qiita](https://qiita.com/chieeeeno/items/ba0d2fb0a45db786746f)

ただし、今回は `youtube.playlistItems.insert` を呼びたいので、払い出す認証はAPIキーではなくOAuthクライアントになる。APIキーはreadonlyな処理しかできず、writeっぽい操作はOAuthトークンが必要ということらしい


## OAuthトークンを取得

ここにあるスクリプトをコピペして実行するとトークンが得られる
一箇所 `SCOPES` のところはいじる必要がある (スクリプトだとreadonlyになっている)

- [Node.js Quickstart  |  YouTube Data API  |  Google Developers](https://developers.google.com/youtube/v3/quickstart/nodejs)

トークンの取得はこんな感じになる

- スクリプトを実行
- コンソールにURLが表示されるのでブラウザでアクセス
- Googleアカウントの認証、渡す権限についても承認する
- ブラウザでcodeが提示されるので、それをコンソールに戻って入力
- `$HOME/.credentials/youtube-nodejs-quickstart.json` にトークンが置かれる


## `youtube.playlistItems.insert` を呼ぶ

- `clientId`, `clientSecret` は OAuthクライアントの認証情報
- `auth.credentials` は `youtube-nodejs-quickstart.json` の中身

```js
import { youtube_v3, google } from 'googleapis';
const auth = new google.auth.OAuth2({
  clientId: 'xxxxxxxx.apps.googleusercontent.com',
  clientSecret: 'xxxxxxxxxxx9',
});
auth.credentials = {
  access_token: 'xxxxxxxxxx',
  refresh_token: 'xxxxxxxxxxxxx',
  token_type: 'Bearer',
  expiry_date: 1588132656533,
};
const youtube = new youtube_v3.Youtube({ auth });

youtube.playlistItems
  .insert({
    part: 'id,snippet,contentDetails',
    requestBody: {
      snippet: {
        playlistId: 'xxxxxxxxxGLoNoixAluaV',
        position: 0,
        resourceId: {
          videoId: 'sqPbMsssiFw',
          kind: 'youtube#video',
        },
      },
    },
  })
  .then((res) => console.log(res.data))
  .catch(console.error);
```

#### 参考

- [PlaylistItems: insert  |  YouTube Data API  |  Google Developers](https://developers.google.com/youtube/v3/docs/playlistItems/insert)
- [insert video into a playlist with youtube api v3 - Stack Overflow](https://stackoverflow.com/questions/20650415/insert-video-into-a-playlist-with-youtube-api-v3)
