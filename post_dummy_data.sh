#!/bin/zsh

# ランダムな名前を生成する関数 (ランダムな英字)
generate_random_name() {
    local name_length=8
    cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z' | fold -w $name_length | head -n 1
}

# ランダムなスコアを生成する関数 (1000～2000の範囲の数値)
generate_random_score() {
     echo $(( $(od -An -N2 -i /dev/urandom | tr -d ' ') % 1001 + 1000 ))
}

# データを指定した個数POSTする関数
post_random_data() {
    local count=$1

    for ((i = 1; i <= count; i++)); do
        local player_name=$(generate_random_name)
        local player_score=$(generate_random_score)

        echo "生成されたデータ: 名前=$player_name, スコア=$player_score"

        response=$(curl -X POST https://rankingapp-28tr.onrender.com/players \
            -H "Content-Type: application/json" \
            -d '{
                "name": "'$player_name'",
                "score": '$player_score'
            }')

        echo "サーバーからの応答: $response"
    done
}

# スクリプト実行時に個数を引数として受け取る
if [[ -z $1 ]]; then
    echo "使用方法: ./post_random_data.sh <生成するデータの個数>"
    exit 1
fi

post_random_data $1
