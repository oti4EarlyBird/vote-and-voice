<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vote and Voice - 민주주의의 새로운 목소리</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Arial', sans-serif;
            overflow: hidden;
            height: 100vh;
        }
        
        .container {
            width: 100vw;
            height: 100vh;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* 배경 파티클 시스템 */
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }
        
        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: particleFloat 8s linear infinite;
        }
        
        /* 메인 컨테이너 */
        .main-content {
            position: relative;
            z-index: 10;
            text-align: center;
            color: white;
        }
        
        /* 3D 회전하는 로고 */
        .logo-container {
            perspective: 1000px;
            margin-bottom: 40px;
        }
        
        .logo-3d {
            width: 200px;
            height: 200px;
            margin: 0 auto;
            position: relative;
            transform-style: preserve-3d;
            animation: rotate3d 10s linear infinite;
        }
        
        .logo-face {
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.3);
        }
        
        .logo-face.front {
            background: linear-gradient(135deg, rgba(255,107,107,0.9), rgba(255,142,83,0.9));
            transform: translateZ(100px);
        }
        
        .logo-face.back {
            background: linear-gradient(135deg, rgba(106,137,204,0.9), rgba(99,205,218,0.9));
            transform: translateZ(-100px) rotateY(180deg);
        }
        
        .logo-face.right {
            background: linear-gradient(135deg, rgba(161,196,253,0.9), rgba(194,233,251,0.9));
            transform: rotateY(90deg) translateZ(100px);
        }
        
        .logo-face.left {
            background: linear-gradient(135deg, rgba(255,154,158,0.9), rgba(250,208,196,0.9));
            transform: rotateY(-90deg) translateZ(100px);
        }
        
        .logo-face.top {
            background: linear-gradient(135deg, rgba(168,85,247,0.9), rgba(236,72,153,0.9));
            transform: rotateX(90deg) translateZ(100px);
        }
        
        .logo-face.bottom {
            background: linear-gradient(135deg, rgba(59,130,246,0.9), rgba(147,51,234,0.9));
            transform: rotateX(-90deg) translateZ(100px);
        }
        
        /* 타이틀 */
        .title {
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4);
            background-size: 400% 400%;
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 3s ease-in-out infinite;
            text-shadow: 0 0 30px rgba(255,255,255,0.5);
        }
        
        .subtitle {
            font-size: 1.8rem;
            margin-bottom: 40px;
            opacity: 0.9;
            animation: pulse 2s ease-in-out infinite;
        }
        
        /* 혁신적인 기능 카드들 */
        .features-orbit {
            position: absolute;
            width: 600px;
            height: 600px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation: orbitRotate 20s linear infinite;
        }
        
        .feature-card {
            position: absolute;
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            font-weight: bold;
            color: white;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            animation: counterRotate 20s linear infinite reverse;
        }
        
        .feature-card:hover {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 10px 30px rgba(255,255,255,0.3);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 8px;
        }
        
        .card1 {
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .card2 {
            top: 50%;
            right: 50px;
            transform: translateY(-50%);
        }
        
        .card3 {
            bottom: 50px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .card4 {
            top: 50%;
            left: 50px;
            transform: translateY(-50%);
        }
        
        .card5 {
            top: 120px;
            right: 120px;
        }
        
        .card6 {
            bottom: 120px;
            left: 120px;
        }
        
        /* 데이터 시각화 플로팅 차트 */
        .floating-chart {
            position: absolute;
            top: 100px;
            right: 100px;
            width: 200px;
            height: 150px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            border: 1px solid rgba(255,255,255,0.3);
            padding: 20px;
            animation: chartFloat 4s ease-in-out infinite;
        }
        
        .chart-bars {
            display: flex;
            align-items: end;
            height: 80px;
            gap: 8px;
        }
        
        .bar {
            background: linear-gradient(to top, #ff6b6b, #4ecdc4);
            border-radius: 4px 4px 0 0;
            animation: barGrow 2s ease-in-out infinite;
        }
        
        .bar:nth-child(1) { width: 20px; height: 60%; animation-delay: 0s; }
        .bar:nth-child(2) { width: 20px; height: 80%; animation-delay: 0.2s; }
        .bar:nth-child(3) { width: 20px; height: 40%; animation-delay: 0.4s; }
        .bar:nth-child(4) { width: 20px; height: 90%; animation-delay: 0.6s; }
        .bar:nth-child(5) { width: 20px; height: 70%; animation-delay: 0.8s; }
        
        .chart-title {
            color: white;
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }
        
        /* 모바일 목업 */
        .mobile-mockup {
            position: absolute;
            bottom: 100px;
            left: 100px;
            width: 120px;
            height: 220px;
            background: #2c3e50;
            border-radius: 20px;
            padding: 15px;
            animation: phoneFloat 3s ease-in-out infinite;
        }
        
        .screen {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }
        
        .screen-content {
            position: absolute;
            top: 20px;
            left: 10px;
            right: 10px;
            color: white;
            font-size: 0.7rem;
        }
        
        .mini-vote-button {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 25px;
            background: #ff6b6b;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.6rem;
            font-weight: bold;
            animation: buttonPulse 1.5s ease-in-out infinite;
        }
        
        /* 하단 프로젝트 정보 */
        .project-info {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            text-align: center;
            color: rgba(255,255,255,0.9);
            font-size: 1rem;
        }
        
        .team-info {
            margin-top: 10px;
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        /* 애니메이션들 */
        @keyframes particleFloat {
            0% {
                transform: translateY(100vh) translateX(0);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-10px) translateX(100px);
                opacity: 0;
            }
        }
        
        @keyframes rotate3d {
            0% { transform: rotateX(0deg) rotateY(0deg); }
            25% { transform: rotateX(90deg) rotateY(0deg); }
            50% { transform: rotateX(90deg) rotateY(90deg); }
            75% { transform: rotateX(0deg) rotateY(90deg); }
            100% { transform: rotateX(0deg) rotateY(360deg); }
        }
        
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.9; }
            50% { transform: scale(1.05); opacity: 1; }
        }
        
        @keyframes orbitRotate {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
        
        @keyframes counterRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(-360deg); }
        }
        
        @keyframes chartFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        
        @keyframes barGrow {
            0%, 100% { transform: scaleY(0.8); }
            50% { transform: scaleY(1); }
        }
        
        @keyframes phoneFloat {
            0%, 100% { transform: translateY(0px) rotate(-2deg); }
            50% { transform: translateY(-15px) rotate(2deg); }
        }
        
        @keyframes buttonPulse {
            0%, 100% { transform: translateX(-50%) scale(1); }
            50% { transform: translateX(-50%) scale(1.1); }
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .title { font-size: 2.5rem; }
            .subtitle { font-size: 1.2rem; }
            .features-orbit { width: 400px; height: 400px; }
            .floating-chart, .mobile-mockup { display: none; }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 배경 파티클 -->
        <div class="particles" id="particles"></div>
        
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="logo-container">
                <div class="logo-3d">
                    <div class="logo-face front">V&V</div>
                    <div class="logo-face back">투표</div>
                    <div class="logo-face right">목소리</div>
                    <div class="logo-face left">민주</div>
                    <div class="logo-face top">참여</div>
                    <div class="logo-face bottom">소통</div>
                </div>
            </div>
            
            <h1 class="title">Vote & Voice</h1>
            <p class="subtitle">민주주의의 새로운 목소리</p>
        </div>
        
        <!-- 궤도 기능 카드들 -->
        <div class="features-orbit">
            <div class="feature-card card1">
                <div class="feature-icon">🗳️</div>
                <div>실시간 투표</div>
            </div>
            <div class="feature-card card2">
                <div class="feature-icon">📊</div>
                <div>데이터 분석</div>
            </div>
            <div class="feature-card card3">
                <div class="feature-icon">💬</div>
                <div>의견 토론</div>
            </div>
            <div class="feature-card card4">
                <div class="feature-icon">🏛️</div>
                <div>의안 정보</div>
            </div>
            <div class="feature-card card5">
                <div class="feature-icon">🔔</div>
                <div>알림 서비스</div>
            </div>
            <div class="feature-card card6">
                <div class="feature-icon">👥</div>
                <div>시민 참여</div>
            </div>
        </div>
        
        <!-- 플로팅 차트 -->
        <div class="floating-chart">
            <div class="chart-title">실시간 여론</div>
            <div class="chart-bars">
                <div class="bar"></div>
                <div class="bar"></div>
                <div class="bar"></div>
                <div class="bar"></div>
                <div class="bar"></div>
            </div>
        </div>
        
        <!-- 모바일 목업 -->
        <div class="mobile-mockup">
            <div class="screen">
                <div class="screen-content">
                    <div style="margin-bottom: 10px;">📋 의안 목록</div>
                    <div style="font-size: 0.6rem; line-height: 1.4;">
                        • 교육법 개정안<br>
                        • 환경보호법<br>
                        • 주택정책
                    </div>
                </div>
                <div class="mini-vote-button">투표하기</div>
            </div>
        </div>
        
        <!-- 프로젝트 정보
        <div class="project-info">
            <div><strong>KOSA 4기 2조 얼리버드 팀</strong></div>
            <div class="team-info">국회 의안 관련 미니 2차 프로젝트</div>
        </div>
         -->
    </div>
    
    <script>
        // 파티클 시스템
        function createParticles() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 50;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + 'vw';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 3 + 5) + 's';
                particlesContainer.appendChild(particle);
            }
        }
        
        // 페이지 로드 시 파티클 생성
        window.addEventListener('load', createParticles);
        
        // 기능 카드 호버 효과
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform += ' translateZ(20px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = this.style.transform.replace(' translateZ(20px)', '');
            });
        });
    </script>
</body>
</html>