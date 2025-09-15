<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<!-- 찬반 버튼 -->
<div class="d-flex justify-content-center mb-3">
	    <button type="button" id="voteYes" class="btn btn-outline-success me-3">찬성</button>
	    <button type="button" id="voteNo" class="btn btn-outline-danger">반대</button>

</div>

<!-- 차트 -->
<div style="width: 300px; margin: 20px auto;">
    <canvas id="voteChart" width="300" height="200" style="display: block;"></canvas>
</div>
<div id="voteCount" style="text-align: center; font-size: 1.2em; margin-top: 10px; display: none;">
    찬성 0표 | 반대 0표
</div>

<script>
document.addEventListener('DOMContentLoaded', function() { 
    // ----- 찬반 투표 -----
    let agreeCount = 0; 
    let disagreeCount = 0; 
    let hasVoted = false; 
    window.voteside = null; // 다른 섹션에서 사용할 수 있도록 전역 변수로 설정

    const canvas = document.getElementById('voteChart');
    const ctx = canvas.getContext('2d');
    const voteChart = new Chart(ctx, { 
        type: 'doughnut', 
        data: { 
            labels: ['찬성','반대'], 
            datasets: [{ 
                data:[agreeCount, disagreeCount], 
                backgroundColor:['#28a745','#dc3545'] 
            }] 
        }, 
        options: { 
            responsive:true, 
            plugins:{ 
                legend:{ position:'bottom' }, 
                tooltip:{ 
                    callbacks:{ 
                        label:function(context){ 
                            const total = agreeCount + disagreeCount; 
                            const value = context.raw; 
                            const percentage = total ? ((value/total)*100).toFixed(1) : 0; 
                            return context.label + ': ' + value + '표 (' + percentage + '%)';
                        } 
                    } 
                } 
            } 
        } 
    }); 

    function updateVoteDisplay(){
        voteChart.data.datasets[0].data = [agreeCount, disagreeCount]; 
        voteChart.update(); 
        
        const voteCountDiv = document.getElementById('voteCount');
        voteCountDiv.style.display='block'; 
        voteCountDiv.textContent = '찬성 ' + agreeCount + '표 | 반대 ' + disagreeCount + '표';
        
        // 캔버스 표시 보장
        document.getElementById('voteChart').style.display = 'block';
    }  

    document.getElementById("voteYes")?.addEventListener('click', function(){ 
        if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
        agreeCount++; 
        hasVoted=true; 
        window.voteside='찬성';
        updateVoteDisplay(); 
    }); 

    document.getElementById("voteNo")?.addEventListener('click', function(){ 
        if(hasVoted){ alert("이미 투표하셨습니다."); return; } 
        disagreeCount++; 
        hasVoted=true; 
        window.voteside='반대';
        updateVoteDisplay(); 
    });   
});
</script>