let players = []; // グローバル変数としてプレイヤーデータを保持

// APIからランキングデータを取得してテーブルに表示
async function fetchRanking() {
    const response = await fetch('/players/all');
    const rawPlayers = await response.json();
    players = calculateGlobalRankings(rawPlayers);
    displayRanking(players);
}

// 全体のランキングを計算する関数
function calculateGlobalRankings(rawPlayers) {
    return rawPlayers
        .sort((a, b) => b.score - a.score)
        .map((player, index) => ({
            ...player,
            rank: index + 1
        }));
}

function displayRanking(playersToDisplay) {
    const tableBody = document.querySelector('#ranking-table tbody');
    tableBody.innerHTML = '';

    playersToDisplay.forEach((player) => {
        const row = document.createElement('tr');

        const rankCell = document.createElement('td');
        rankCell.textContent = player.rank;
        row.appendChild(rankCell);

        const nameCell = document.createElement('td');
        nameCell.textContent = player.name;
        row.appendChild(nameCell);

        const scoreCell = document.createElement('td');
        scoreCell.textContent = player.score;
        row.appendChild(scoreCell);

        // 1, 2, 3位に特別なスタイルを適用
        if (player.rank === 1) {
            row.classList.add('first-place');
        } else if (player.rank === 2) {
            row.classList.add('second-place');
        } else if (player.rank === 3) {
            row.classList.add('third-place');
        }

        tableBody.appendChild(row);
    });
}

// 検索機能の実装
function setupSearch() {
    const searchInput = document.getElementById('searchInput');
    searchInput.addEventListener('input', function() {
        const filter = this.value.toLowerCase();
        const filteredPlayers = players.filter(player =>
            player.name.toLowerCase().includes(filter)
        );
        displayRanking(filteredPlayers);
    });
}

// ページが読み込まれた後、1分ごとにランキングを再取得するように設定
function startAutoRefresh() {
    setInterval(fetchRanking, 60000);
}

// ページ読み込み時にランキングを取得し、自動更新を開始
window.onload = function() {
    fetchRanking();
    setupSearch();
    startAutoRefresh();
};