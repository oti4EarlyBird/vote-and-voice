<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page isELIgnored="false" %>

<!-- Chart.js 라이브러리 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

<!-- 찬반 버튼 -->
<div class="d-flex justify-content-center mb-3">
    <button type="button" id="voteYes" class="btn btn-outline-success me-3">찬성</button>
    <button type="button" id="voteNo" class="btn btn-outline-danger">반대</button>
</div>

<!-- 투표 알림창 -->
<div id="voteAlert" class="alert alert-primary alert-dismissible" role="alert" style="display:none;">
    <span id="alertMessage">이미 투표하셨습니다!</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<!-- 차트 -->
<div style="width: 300px; margin: 20px auto;">
    <canvas id="voteChart" width="300" height="200"></canvas>
</div>
<div id="voteCount" style="text-align: center; font-size: 1.2em; margin-top: 10px;">
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('=== 투표 스크립트 시작 ===');
    
    // Chart.js 로드 확인
    if (typeof Chart === 'undefined') {
        console.error('Chart.js가 로드되지 않았습니다!');
        document.getElementById('voteChart').innerHTML = '<p style="text-align:center; color:red;">차트 로드 오류</p>';
        return;
    }

    const billId = "${bill.billId}" + ""; // 문자열로 안전하게 변환
    let agreeCount = ${agreeCount};
    let disagreeCount = ${disagreeCount};
    console.log("초기 찬성표:", agreeCount, "초기 반대표:", disagreeCount);
    console.log("billId:", billId);

    let hasVoted = false;
    
    // 차트 초기화
    const ctx = document.getElementById('voteChart');
    if (!ctx) {
        console.error('voteChart 캔버스를 찾을 수 없습니다!');
        return;
    }
    
    console.log('차트 초기화 시작...');
    const voteChart = new Chart(ctx.getContext('2d'), {
        type: 'doughnut',
        data: {
            labels: ['찬성', '반대'],
            datasets: [{
                data: [agreeCount, disagreeCount],
                backgroundColor: ['#28a745', '#dc3545']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const total = agreeCount + disagreeCount;
                            const value = context.raw;
                            const percentage = total ? ((value / total) * 100).toFixed(1) : 0;
                            return context.label + ': ' + value + '표 (' + percentage + '%)';
                        }
                    }
                }
            }
        } 
    });
    console.log('차트 초기화 완료');

    function updateVoteDisplay() {
        voteChart.data.datasets[0].data = [agreeCount, disagreeCount];
        voteChart.update();
        console.log('차트 업데이트:', agreeCount, disagreeCount);
    }

    // 서버에서 최신 투표 현황 가져오기
    function refreshVoteStats() {
        console.log('투표 통계 새로고침 요청...');
        fetch("${pageContext.request.contextPath}/user/vote-stats?billId=" + billId)
            .then(res => {
                console.log('vote-stats 응답 상태:', res.status);
                return res.json();
            })
            .then(data => {
                console.log('vote-stats 응답 데이터:', data);
                if (data.success) {
                    agreeCount = data.agreeCount;
                    disagreeCount = data.disagreeCount;
                    updateVoteDisplay();
                    console.log("투표 현황 업데이트:", data);
                } else {
                    console.error('투표 통계 조회 실패:', data);
                }
            })
            .catch(err => {
                console.error("투표 현황 조회 오류:", err);
            });
    } 

    // 공통 함수: 서버에 투표 전송
    function sendVote(result) {
        if (hasVoted) {
            showAlert("이미 투표하셨습니다.", "primary");
            return;
        }

        console.log('투표 전송:', result);
        fetch("${pageContext.request.contextPath}/user/vote", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "billId=" + billId + "&result=" + result
        })
        .then(res => {
            console.log('투표 응답 상태:', res.status);
            return res.json();
        })
        .then(data => { 
            console.log('투표 응답 데이터:', data);
            if (data.success) {
                hasVoted = true;
                window.voteside = result === "AGREE" ? "찬성" : "반대";
                showAlert("투표가 완료되었습니다", "success");
                
                // 응답에서 받은 데이터로 즉시 업데이트
                if (data.agreeCount !== undefined && data.disagreeCount !== undefined) {
                    agreeCount = data.agreeCount;
                    disagreeCount = data.disagreeCount;
                    updateVoteDisplay();
                } else {
                    refreshVoteStats();
                }
            } else {
                hasVoted = true;
                showAlert(data.message || "투표에 실패하였습니다", "warning");
            }
        }) 
        .catch(err => {
            console.error('투표 오류:', err);
            showAlert("서버 오류가 발생했습니다.", "danger");
        });
    }
	
    // 알림창 표시
    function showAlert(message, type) {
        const alertDiv = document.getElementById('voteAlert');
        const alertMessage = document.getElementById('alertMessage');
        alertMessage.textContent = message;
        alertDiv.className = `alert alert-${type} alert-dismissible`;
        alertDiv.style.display = 'block';
    } 
 
    // 버튼 이벤트
    document.getElementById("voteYes").addEventListener('click', () => sendVote("AGREE"));
    document.getElementById("voteNo").addEventListener('click', () => sendVote("DISAGREE"));

    // 초기 표시
    updateVoteDisplay(); 
    console.log('=== 투표 스크립트 초기화 완료 ===');
});
</script>