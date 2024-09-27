#!/bin/zsh

# 確認のためのメッセージを表示
read "confirm?本当にすべてのデータを削除しますか？(y/N): "

# 小文字に変換して入力内容をチェック
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "データを削除しています..."

    # 削除処理をここに記述
    # 例えば、curlを使ってAPIのDELETEリクエストを送信
    curl -X DELETE https://rankingapp-28tr.onrender.com/players

    echo "データが削除されました。"
else
    echo "削除がキャンセルされました。"
fi
