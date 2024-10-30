let players = [];

async function fetchRanking() {
    try {
        const response = await fetch('/players/all');
        const rawPlayers = await response.json();
        players = calculateGlobalRankings(rawPlayers);
        displayRanking(players);
    } catch (error) {
        console.error('ランキングデータの取得に失敗しました:', error);
    }
}

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
        row.innerHTML = `
            <td>${player.rank}</td>
            <td>${player.name}</td>
            <td>${player.score}</td>
        `;
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

function startAutoRefresh() {
    setInterval(fetchRanking, 60000);
}

window.onload = function() {
    fetchRanking();
    setupSearch();
    startAutoRefresh();
};
