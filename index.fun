<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MineHood SMP — next‑gen survival realm</title>
    <!-- meta tags for SEO & social -->
    <meta name="description" content="MineHood SMP: next‑gen survival with 3D blocks, live maps, vote rewards & a godlike community. Join the legend.">
    <meta name="keywords" content="Minecraft SMP, MineHood, Minecraft server, vote rewards, survival multiplayer, 1.21">
    <meta name="author" content="MineHood Team">
    <meta property="og:title" content="MineHood SMP - Epic Minecraft Adventures">
    <meta property="og:description" content="Dive into the ultimate Minecraft SMP experience with custom features and a vibrant community.">
    <meta property="og:image" content="https://images.unsplash.com/photo-1600924779116-927b4f81457d?q=80&w=1200&auto=format&fit=crop">
    <meta property="og:url" content="https://MineHood.example.com">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' fill='%232ecc71'/><text x='10' y='90' font-size='80' fill='white'>⛏️</text></svg>">
    <!-- fonts & icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz@14..32&family=Montserrat:wght@400;500;600;700;800&family=Press+Start+2P&display=swap" rel="stylesheet">
    <style>
        /* ----- RESET & VARIABLES ----- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --grass: #2ecc71;
            --grass-dark: #27ae60;
            --dirt: #8B5A2B;
            --stone: #bdc3c7;
            --water: #3498db;
            --deep-water: #2980b9;
            --gold: #f1c40f;
            --cloud: #ecf0f1;
            --dark-bg: #0f172a;
            --card-bg: rgba(255, 255, 255, 0.75);
            --card-bg-dark: rgba(15, 23, 42, 0.8);
            --shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --shadow-hover: 0 30px 60px -12px rgba(0, 0, 0, 0.35);
            --border-radius: 28px;
            --font-main: 'Inter', sans-serif;
            --font-head: 'Montserrat', sans-serif;
            --font-pixel: 'Press Start 2P', cursive;
            --transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1);
            --primary: var(--grass);
            --secondary: var(--grass-dark);
            --accent: var(--water);
            --dark: #1e2a3a;
            --light: var(--cloud);
            --white: #FFFFFF;
            --error: #e74c3c;
            --success: #2ecc71;
            --warning: #f39c12;
        }
        body {
            font-family: var(--font-main);
            background: linear-gradient(145deg, #d4edda 0%, #a9dfbf 50%, #a3c9f0 100%);
            color: var(--dark);
            line-height: 1.6;
            overflow-x: hidden;
            position: relative;
            transition: background 0.5s, color 0.3s;
            
        }
        body.dark {
            background: linear-gradient(145deg, #0b1a2e 0%, #1a2f3f 50%, #1e293b 100%);
            color: #e2e8f0;
            --card-bg: rgba(20, 30, 45, 0.9);
            --dark: #e2e8f0;
        }
        html{
scroll-behavior:smooth;
}
        /* floating 3D blocks canvas (background) */
        #block-canvas {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: -1;
            pointer-events: none;
            opacity: 0.3;
        }
        /* particle canvas for effects */
        #particle-canvas {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            pointer-events: none;
            z-index: 9999;
            opacity: 0.5;
        }
        /* rain canvas */
        #rain-canvas {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            pointer-events: none;
            z-index: 9998;
            opacity: 0.2;
        }
        /* custom scrollbar */
        ::-webkit-scrollbar { width: 12px; }
        ::-webkit-scrollbar-track { background: rgba(46, 204, 113, 0.1); backdrop-filter: blur(4px); }
        ::-webkit-scrollbar-thumb { background: var(--grass); border-radius: 20px; border: 2px solid var(--grass-dark); }
        ::-webkit-scrollbar-thumb:hover { background: var(--grass-dark); }

        /* progress bar */
        #progress-bar {
            position: fixed; top: 0; left: 0; width: 0%; height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            z-index: 1002; transition: width 0.1s;
        }

        /* ----- HEADER & NAV (glass) ----- */
        header {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px) saturate(180%);
               border-bottom: none;

            box-shadow: 0 15px 35px -15px rgba(0, 0, 0, 0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        body.dark header {
            background: rgba(10, 20, 30, 0.8);
            border-bottom: none;
        }
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0.8rem clamp(1rem, 3vw, 2rem);
        }
        .logo {
            font-family: var(--font-pixel);
            font-size: 1.2rem;
            background: linear-gradient(135deg, var(--grass), var(--water));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            transition: transform 0.2s;
            text-decoration: none;
            letter-spacing: -0.5px;
            position: relative;
        }
        .logo:hover { transform: scale(1.05) rotate(-1deg); }
        .logo::after {
            content: '';
            position: absolute;
            bottom: -5px; left: 0; width: 100%; height: 2px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0); transition: transform 0.3s;
        }
        .logo:hover::after { transform: scaleX(1); }
        .nav-tabs {
            display: flex;
            list-style: none;
            gap: clamp(1rem, 2vw, 2rem);
        }
       .nav-tabs a {
    color: var(--dark);
    text-decoration: none;
    font-weight: 600;
    position: relative;
    overflow: hidden;   /* ADD THIS */
    display: inline-block; /* ADD THIS */
}
  .nav-tabs a {
    position: relative;
    padding: 6px 12px;
}

.nav-tabs a::after {
    content: "";
    position: absolute;
    left: 50%;
    bottom: -4px;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg,var(--primary),var(--accent));
    transform: translateX(-50%);
    transition: width .25s ease;
}

.nav-tabs a:hover::after,
.nav-tabs a.active::after {
    width: 70%;
}
      .nav-tabs a:hover {
    color: var(--primary);
}

.nav-tabs a.active {
    color: var(--primary);
}

        .nav-tabs a:focus-visible, .btn:focus-visible, .copy-ip:focus-visible {
            outline: 3px solid var(--primary);
            outline-offset: 2px;
        }
        .hamburger {
            display: none;
            flex-direction: column;
            cursor: pointer;
            gap: 5px;
            z-index: 1001;
        }
        .hamburger span {
            width: 25px; height: 3px;
            background: var(--dark);
            transition: var(--transition);
            border-radius: 2px;
        }
        .hamburger.active span:nth-child(1) { transform: rotate(45deg) translate(5px, 5px); }
        .hamburger.active span:nth-child(2) { opacity: 0; }
        .hamburger.active span:nth-child(3) { transform: rotate(-45deg) translate(6px, -6px); }

        .lang-selector select {
            padding: 0.3rem 0.8rem; border-radius: 30px;
            background: var(--card-bg); border: 1px solid var(--primary);
            color: var(--dark); font-weight: 600;
            cursor: pointer;
        }

        /* ----- MAIN LAYOUT ----- */
        main { margin-top: clamp(60px, 10vh, 80px); min-height: 100vh; }
        .tab-content { display: none; max-width: 1400px; margin: 2rem auto; padding: 0 1.5rem; animation: fadeInUp 0.5s ease-out; }
        .tab-content.active { display: block; }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ----- SECTION CARDS with animated gradient border ----- */
        section {
            margin-bottom: 4rem;
            padding: 2.5rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(15px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.6);
            position: relative;
            overflow: hidden;
        }
        section::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent), var(--primary));
            background-size: 200% 100%;
            animation: gradientShift 4s infinite;
        }
        @keyframes gradientShift {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 0%; }
            100% { background-position: 0% 0%; }
        }
        section:hover { transform: translateY(-4px); box-shadow: var(--shadow-hover); }

        h1, h2, h3 {
            font-family: var(--font-head);
            color: var(--dark);
            margin-bottom: 1.5rem;
            font-weight: 600;
            letter-spacing: -0.5px;
        }
        h1 { font-size: clamp(2.5rem, 5vw, 4rem); text-align: center; }
        h2 { font-size: clamp(2rem, 3.5vw, 2.6rem); display: flex; align-items: center; gap: 10px; }
        h2 i { color: var(--grass); }
        h3 { font-size: 1.4rem; }

        /* ----- HERO SECTION with typewriter effect ----- */
        .hero {
            text-align: center;
            padding: 5rem 2rem;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(12px);
            border: 2px solid rgba(255, 255, 255, 0.6);
            border-radius: var(--border-radius);
            margin-bottom: 4rem;
            position: relative;
            overflow: hidden;
        }
        .hero h1 {
            font-size: clamp(2.8rem, 8vw, 5rem);
            text-shadow: 4px 4px 0 rgba(46, 204, 113, 0.3), 8px 8px 0 rgba(52, 152, 219, 0.2);
            animation: floatText 3s infinite alternate;
        }
        @keyframes floatText {
            0% { transform: translateY(0); text-shadow: 4px 4px 0 #2ecc71, 8px 8px 0 #3498db; }
            100% { transform: translateY(-8px); text-shadow: 6px 6px 0 #27ae60, 12px 12px 0 #2980b9; }
        }
       

        /* ----- BUTTONS with pulse animation ----- */
        .btn {
            display: inline-block;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: var(--white);
            padding: 0.9rem 2.2rem;
            text-decoration: none;
            border-radius: 40px;
            transition: 0.2s;
            margin: 0.5rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            box-shadow: 0 10px 20px -5px rgba(46, 204, 113, 0.4);
            font-size: 1rem;
            position: relative;
            overflow: hidden;
        }
        .btn.secondary { background: linear-gradient(45deg, var(--accent), var(--deep-water)); box-shadow: 0 10px 20px -5px rgba(52, 152, 219, 0.4); }
        .btn.shop { background: linear-gradient(45deg, #f1c40f, #e67e22); box-shadow: 0 10px 20px -5px #f39c12; }
        .btn::after {
            content: ''; position: absolute; top: 50%; left: 50%;
            width: 0; height: 0; border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: translate(-50%, -50%);
            transition: width 0.4s, height 0.4s;
        }
        .btn:hover::after { width: 300px; height: 300px; }
        .btn:hover { transform: scale(1.02) translateY(-2px); animation: pulse 1s infinite; }
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(46, 204, 113, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(46, 204, 113, 0); }
            100% { box-shadow: 0 0 0 0 rgba(46, 204, 113, 0); }
        }

        /* ----- FEATURE GRIDS with 3D tilt effect ----- */
        .features, .server-info, .gallery, .staff-grid, .shop-grid, .stats-grid, .vote-sites, .achievements-grid, .player-heads-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .feature, .info-card, .staff-card, .shop-card, .stat-card, .achievement-card, .player-head {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            padding: 2rem 1.5rem;
            border-radius: 24px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.6);
            box-shadow: 0 20px 30px -15px rgba(0, 0, 0, 0.2);
            transform-style: preserve-3d;
            transform: perspective(1000px) rotateX(0deg) rotateY(0deg);
        }
        .feature:hover, .info-card:hover, .staff-card:hover, .shop-card:hover, .stat-card:hover, .achievement-card:hover, .player-head:hover {
            transform: perspective(1000px) rotateX(2deg) rotateY(2deg) translateY(-8px) scale(1.02);
            border-color: var(--primary);
            box-shadow: 0 30px 45px -15px #2ecc71;
        }
        .feature i, .info-card i, .shop-card i, .stat-card i, .achievement-card i {
            font-size: 2.8rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        .info-card i { color: var(--accent); }
        .shop-card i { color: var(--gold); }
        .stat-card i { color: var(--water); }

        /* ----- SERVER INFO ----- */
        .copy-ip {
            background: #2ecc71; border: none; border-radius: 60px;
            padding: 0.3rem 1rem; color: white; font-weight: 600;
            margin-left: 0.8rem; cursor: pointer; transition: 0.2s;
            font-size: 0.8rem;
        }
        .copy-ip:hover { background: #27ae60; transform: scale(1.05); }

        [data-tooltip] {
            position: relative;
            cursor: help;
        }
        [data-tooltip]:before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%; left: 50%; transform: translateX(-50%);
            padding: 0.5rem; background: var(--dark); color: white; border-radius: 8px;
            white-space: nowrap; font-size: 0.8rem; opacity: 0; transition: opacity 0.2s;
            pointer-events: none; z-index: 10;
        }
        [data-tooltip]:hover:before { opacity: 1; }

        /* ----- VOTE SECTION ----- */
        .cooldown-progress {
            height: 10px; background: rgba(0,0,0,0.1); border-radius: 20px;
            margin: 15px 0; width: 100%; overflow: hidden;
        }
        .cooldown-progress div { height: 100%; background: linear-gradient(90deg, #f1c40f, #e67e22); width: 0%; transition: width 0.3s; }
        #vote-form input {
            width: 100%; padding: 1rem; margin: 1rem 0;
            border: 1px solid rgba(0,0,0,0.1); border-radius: 60px;
            font-size: 1rem; background: rgba(255,255,255,0.8);
        }
        #vote-form input:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(46,204,113,0.2); }

        /* toast notification */
        #toast {
            position: fixed; bottom: 100px; left: 50%; transform: translateX(-50%);
            background: var(--dark); color: white; padding: 0.8rem 2rem;
            border-radius: 60px; box-shadow: var(--shadow); z-index: 2001;
            display: none; align-items: center; gap: 10px;
        }
        #toast.show { display: flex; animation: slideUp 0.3s; }
        @keyframes slideUp {
            from { opacity: 0; transform: translate(-50%, 20px); }
            to { opacity: 1; transform: translate(-50%, 0); }
        }

        /* ----- MODAL (for confirm, rules, bug report) ----- */
        .modal {
            display: none; position: fixed; inset: 0;
            background: rgba(0,0,0,0.6); backdrop-filter: blur(10px);
            z-index: 2000; justify-content: center; align-items: center;
        }
        .modal-content {
            background: var(--card-bg); padding: 2.5rem; border-radius: 40px;
            max-width: 500px; width: 90%; text-align: center; animation: modalSlide 0.3s;
            border: 2px solid var(--primary);
        }
        @keyframes modalSlide {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ----- GALLERY LIGHTBOX ----- */
        .gallery-item {
            position: relative; overflow: hidden; border-radius: 28px;
            cursor: pointer; box-shadow: 0 20px 30px -15px rgba(0,0,0,0.2);
            border: 1px solid rgba(255,255,255,0.6);
        }
        .gallery-item img { width: 100%; height: 200px; object-fit: cover; transition: 0.4s; }
        .gallery-item:hover img { transform: scale(1.05); }
        .gallery-item::after {
            content: attr(data-title); position: absolute; bottom: 0; left: 0; right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.7)); color: white;
            padding: 1rem; opacity: 0; transition: 0.3s; font-weight: 500;
        }
        .gallery-item:hover::after { opacity: 1; }
        #lightbox {
            display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.9);
            backdrop-filter: blur(15px); z-index: 2000;
            justify-content: center; align-items: center;
        }
        #lightbox img { max-width: 80%; max-height: 80%; border-radius: 30px; border: 4px solid #2ecc71; }

        /* ----- STAFF AVATARS ----- */
        .staff-avatar {
            width: 90px; height: 90px; border-radius: 50%;
            background: linear-gradient(145deg, #2ecc71, #3498db);
            margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center;
            font-size: 2rem; color: white; padding: 3px;
        }
        .staff-avatar img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; }
        .online-badge {
            display: inline-block; width: 12px; height: 12px; background: #2ecc71; border-radius: 50%;
            margin-left: 5px; animation: pulse 1.5s infinite;
        }

        

        /* quick actions */
        .quick-actions {
            position: fixed; bottom: 100px; right: 30px; z-index: 998;
            display: flex; flex-direction: column; gap: 10px;
        }
        .quick-actions button {
            width: 50px; height: 50px; border-radius: 50%; background: var(--primary);
            color: white; border: none; cursor: pointer; box-shadow: var(--shadow);
            transition: 0.2s; font-size: 1.2rem;
        }
        .quick-actions button:hover { transform: scale(1.1); background: var(--secondary); }

        /* ----- FAQ ACCORDION ----- */
        .faq-item {
            margin-bottom: 1rem; border-radius: 20px; background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
        }
        .faq-question {
            padding: 1.2rem; cursor: pointer; font-weight: 600; display: flex; justify-content: space-between;
        }
        .faq-answer {
            max-height: 0; overflow: hidden; transition: max-height 0.4s; padding: 0 1.2rem;
        }
        .faq-item.active .faq-answer { max-height: 200px; padding-bottom: 1.2rem; }

        /* ----- TESTIMONIAL CAROUSEL ----- */
        .testimonial-carousel {
            display: flex; overflow-x: auto; scroll-snap-type: x mandatory; gap: 2rem; padding: 1rem 0;
            scrollbar-width: thin;
        }
        .testimonial {
            min-width: 280px; background: var(--card-bg); padding: 1.5rem; border-radius: 30px; scroll-snap-align: start;
        }

        /* ----- SOCIAL FOOTER ----- */
        .social {
            text-align: center; padding: 4rem 2rem;
            background: linear-gradient(135deg, var(--dark-bg) 0%, #2c3e50 100%);
            color: white; margin-top: 5rem;
        }
        .social h2 { color: white; justify-content: center; }
        .social-icons {
            display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap;
            margin-top: 2rem;
        }
        .social a {
            color: white; font-size: 1.8rem; transition: 0.3s;
            width: 60px; height: 60px; background: rgba(255,255,255,0.1);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            border: 1px solid rgba(255,255,255,0.2);
        }
        .social a:hover { color: var(--primary); transform: translateY(-6px); background: rgba(46,204,113,0.2); }

        footer {
            background: var(--dark-bg); color: white; text-align: center;
            padding: 2.5rem; border-top: 2px solid var(--primary);
        }
        footer a { color: var(--primary); text-decoration: none; cursor: pointer; }

        /* ----- FIXED ELEMENTS ----- */
        .dark-mode-toggle {
            position: fixed; top: 100px; right: 20px; z-index: 1001;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: white; border: none; width: 50px; height: 50px;
            border-radius: 50%; cursor: pointer; box-shadow: var(--shadow);
            font-size: 1.2rem; transition: 0.3s;
        }
        .dark-mode-toggle:hover { transform: rotate(180deg) scale(1.1); }
        .join-float {
            position: fixed; bottom: 30px; right: 30px; z-index: 999;
            background: linear-gradient(145deg, #2ecc71, #27ae60);
            color: white; border: none; border-radius: 60px;
            padding: 1rem 2rem; font-weight: 700; box-shadow: 0 15px 30px rgba(46,204,113,0.5);
            cursor: pointer; transition: 0.2s; border: 2px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(5px);
        }
        .join-float:hover { transform: scale(1.1) translateY(-5px); box-shadow: 0 25px 40px #2ecc71; }
        #back2top {
            position: fixed; bottom: 30px; left: 30px; z-index: 998;
            background: var(--grass); border: none; border-radius: 50%;
            width: 50px; height: 50px; color: white; font-size: 1.4rem;
            cursor: pointer; opacity: 0; transition: 0.3s; pointer-events: none;
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
        }
        #back2top.visible { opacity: 1; pointer-events: all; }

        /* CSS counters for stats */
        .stats-grid {
            counter-reset: stat-counter;
        }
        .stat-card {
            counter-increment: stat-counter;
        }
        .stat-card h3::before {
            content: counter(stat-counter) ". ";
            color: var(--primary);
            font-weight: bold;
        }

        /* ========== 50 NEW CSS ENHANCEMENTS ========== */
        /* 1. Animated glowing text on hero h1 */
        .hero h1 {
            animation: floatText 3s infinite alternate, glowPulse 2s infinite alternate;
        }
        @keyframes glowPulse {
            from { text-shadow: 4px 4px 0 #2ecc71, 8px 8px 0 #3498db, 0 0 10px #2ecc71; }
            to { text-shadow: 6px 6px 0 #27ae60, 12px 12px 0 #2980b9, 0 0 20px #2ecc71; }
        }

        /* 2. Pulsing ring on hover for buttons */
        .btn:hover {
            box-shadow: 0 0 0 5px rgba(46, 204, 113, 0.3), 0 10px 20px -5px rgba(46,204,113,0.4);
        }

        /* 3. Rotating icons on feature cards */
        .feature:hover i {
            transform: rotate(360deg) scale(1.1);
            transition: transform 0.6s ease;
        }

        /* 4. Shimmer effect on cards */
        .feature::after, .info-card::after, .staff-card::after {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: linear-gradient(135deg, transparent, rgba(255,255,255,0.2), transparent);
            transform: rotate(45deg);
            transition: all 0.5s;
            opacity: 0;
        }
        .feature:hover::after, .info-card:hover::after, .staff-card:hover::after {
            opacity: 1;
            transform: rotate(45deg) translate(50%, 50%);
        }

        /* 5. Animated underline for section headings */
        h2 {
            position: relative;
            display: inline-block;
        }
        h2::after {
            content: '';
            position: absolute;
            bottom: -5px; left: 0;
            width: 100%; height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }
        h2:hover::after {
            transform: scaleX(1);
        }

      /* Active nav tab */
/* .nav-tabs a.active {
    color: var(--primary);
    background: rgba(124, 189, 46, 0.12);
    border-radius: 40px;
} */

        /* 7. Bouncing quick action buttons on hover */
        .quick-actions button:hover {
            animation: bounce 0.4s ease;
        }
        @keyframes bounce {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }

        /* 8. Fade-in animation for toast */
        #toast.show {
            animation: slideUp 0.3s, fadeGlow 1.5s infinite;
        }
        @keyframes fadeGlow {
            0%, 100% { box-shadow: 0 0 10px var(--primary); }
            50% { box-shadow: 0 0 20px var(--primary); }
        }

        /* 9. Custom selection color */
        ::selection {
            background: var(--primary);
            color: white;
        }

        /* 10. Rotating chevron in FAQ */
        .faq-item.active .faq-question i {
            transform: rotate(180deg);
            transition: transform 0.3s;
        }

        /* 11. Staggered animation for gallery items */
        .gallery-item {
            animation: fadeInUp 0.6s backwards;
        }
        .gallery-item:nth-child(1) { animation-delay: 0.1s; }
        .gallery-item:nth-child(2) { animation-delay: 0.2s; }
        .gallery-item:nth-child(3) { animation-delay: 0.3s; }
        .gallery-item:nth-child(4) { animation-delay: 0.4s; }

        /* 12. Gradient text for stats numbers */
        .stat-card h3 {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            display: inline-block;
        }

        /* 13. Image filter on gallery hover */
        .gallery-item:hover img {
            filter: brightness(1.1) contrast(1.2);
        }

        /* 14. Animated background on social icons */
        .social a {
            background: linear-gradient(45deg, var(--primary), var(--accent));
            background-size: 200% 200%;
            animation: socialGradient 3s infinite alternate;
        }
        @keyframes socialGradient {
            0% { background-position: 0% 0%; }
            100% { background-position: 100% 100%; }
        }

        /* 15. Pulsing badge on staff */
        .online-badge {
            animation: pulseBadge 1.5s infinite;
        }
        @keyframes pulseBadge {
            0% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.2); }
            100% { opacity: 1; transform: scale(1); }
        }

        /* 16. Border animation on copy button */
        .copy-ip {
            border: 1px solid transparent;
            transition: all 0.3s;
        }
        .copy-ip:hover {
            border-color: white;
        }

        /* 17. Custom list markers for rules */
        .faq-answer ul {
            list-style: none;
        }
        .faq-answer li::before {
            content: '▹';
            color: var(--primary);
            margin-right: 0.5rem;
        }

        /* 18. Blur effect on modal backdrop */
        .modal {
            backdrop-filter: blur(15px) brightness(0.8);
        }

        /* 19. Flip card effect for player heads (limited) */
        .player-head {
            perspective: 1000px;
        }
        .player-head img {
            transition: transform 0.6s;
            transform-style: preserve-3d;
        }
        .player-head:hover img {
            transform: rotateY(180deg);
        }

        /* 20. Glowing progress bar */
        .cooldown-progress div {
            box-shadow: 0 0 10px var(--gold);
        }

        /* 21. Animated border radius on cards */
        .feature, .info-card, .staff-card {
            transition: border-radius 0.3s, transform 0.3s, box-shadow 0.3s;
        }
        .feature:hover, .info-card:hover, .staff-card:hover {
            border-radius: 40px 20px 40px 20px;
        }

        /* 22. Typewriter cursor color change */
       

        /* 23. Rain canvas opacity change on hover (global) */
        body:hover #rain-canvas {
            opacity: 0.3;
            transition: opacity 0.5s;
        }

        /* 24. Particle canvas color shift */
        #particle-canvas {
            filter: hue-rotate(0deg);
            transition: filter 0.5s;
        }
        body:hover #particle-canvas {
            filter: hue-rotate(20deg);
        }

        /* 25. 3D perspective on hero */
        .hero {
            transform: perspective(1000px) rotateX(0deg);
            transition: transform 0.3s;
        }
        .hero:hover {
            transform: perspective(1000px) rotateX(1deg);
        }

        /* 26. Gradient overlay on images */
        .gallery-item::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(46,204,113,0.2), rgba(52,152,219,0.2));
            opacity: 0;
            transition: opacity 0.3s;
            z-index: 1;
        }
        .gallery-item:hover::before {
            opacity: 1;
        }

        /* 27. Slide-in animation for footer links */
        footer a {
            position: relative;
            overflow: hidden;
        }
        footer a::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0;
            width: 100%; height: 1px;
            background: var(--primary);
            transform: translateX(-100%);
            transition: transform 0.3s;
        }
        footer a:hover::after {
            transform: translateX(0);
        }

        /* 28. Spinning language selector arrow */
        .lang-selector select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%232ecc71" stroke-width="2"><polyline points="6 9 12 15 18 9"/></svg>');
            background-repeat: no-repeat;
            background-position: right 0.5rem center;
            padding-right: 2rem;
        }

        /* 29. Hover scale for vote site buttons */
        .vote-btn {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .vote-btn:hover {
            transform: scale(1.05) rotate(-1deg);
        }

        /* 30. Animated underline for footer links */
        footer a {
            position: relative;
        }
        footer a::before {
            content: '';
            position: absolute;
            bottom: -2px; left: 0;
            width: 100%; height: 2px;
            background: var(--primary);
            transform: scaleX(0);
            transform-origin: right;
            transition: transform 0.3s;
        }
        footer a:hover::before {
            transform: scaleX(1);
            transform-origin: left;
        }

        /* 31. Gradient text for logo */
        .logo {
            background: linear-gradient(135deg, var(--primary), var(--accent), var(--gold));
            background-size: 200% 200%;
            -webkit-background-clip: text;
            background-clip: text;
            animation: logoGradient 3s infinite alternate;
        }
        @keyframes logoGradient {
            0% { background-position: 0% 0%; }
            100% { background-position: 100% 100%; }
        }

        /* 32. Shine effect on buttons */
        .btn {
            position: relative;
            overflow: hidden;
        }
        .btn::before {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.2), transparent);
            transform: rotate(45deg) translateX(-100%);
            transition: transform 0.6s;
        }
        .btn:hover::before {
            transform: rotate(45deg) translateX(100%);
        }

        

        /* 34. Progress bar animation */
        .cooldown-progress div {
            background: linear-gradient(90deg, #f1c40f, #e67e22, #f1c40f);
            background-size: 200% 100%;
            animation: progressShimmer 2s linear infinite;
        }
        @keyframes progressShimmer {
            0% { background-position: 0% 0%; }
            100% { background-position: 200% 0%; }
        }

        /* 35. Neon border on modal */
        .modal-content {
            box-shadow: 0 0 30px var(--primary);
        }

        /* 36. Fade-in animation for modals */
        .modal {
            animation: modalFadeIn 0.3s;
        }
        @keyframes modalFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* 37. Staggered fade for staff cards */
        .staff-card {
            animation: fadeInUp 0.6s backwards;
        }
        .staff-card:nth-child(1) { animation-delay: 0.1s; }
        .staff-card:nth-child(2) { animation-delay: 0.2s; }
        .staff-card:nth-child(3) { animation-delay: 0.3s; }

        /* 38. Rotating chevron on quick actions */
        .quick-actions button i {
            transition: transform 0.3s;
        }
        .quick-actions button:hover i {
            transform: rotate(360deg);
        }

        /* 39. Animated background on dark mode toggle */
        .dark-mode-toggle {
            background: linear-gradient(45deg, var(--primary), var(--accent), var(--primary));
            background-size: 200% 200%;
            animation: toggleGradient 3s infinite alternate;
        }
        @keyframes toggleGradient {
            0% { background-position: 0% 0%; }
            100% { background-position: 100% 100%; }
        }

        /* 40. Pulse effect on join float */
        .join-float {
            animation: floatPulse 2s infinite;
        }
        @keyframes floatPulse {
            0% { box-shadow: 0 15px 30px rgba(46,204,113,0.5); }
            50% { box-shadow: 0 20px 40px rgba(46,204,113,0.8); }
            100% { box-shadow: 0 15px 30px rgba(46,204,113,0.5); }
        }

        /* 41. Text shadow on hover for links */
        .nav-tabs a:hover {
            text-shadow: 0 0 5px var(--primary);
        }

       

        /* 43. Gradient overlay on hero */
        .hero::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(46,204,113,0.1), transparent 50%);
            pointer-events: none;
        }

        /* 44. 3D lift on stat cards */
        .stat-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-10px) rotateX(2deg);
        }

        /* 45. Animated border on input focus */
        #vote-form input:focus {
            border-image: linear-gradient(45deg, var(--primary), var(--accent)) 1;
            border-width: 2px;
            border-style: solid;
        }

        /* 46. Rotating icon on shop cards */
        .shop-card:hover i {
            transform: rotateY(180deg);
            transition: transform 0.5s;
        }

        /* 47. Glow on live player list */
        #live-players li {
            transition: text-shadow 0.2s;
        }
        #live-players li:hover {
            text-shadow: 0 0 5px var(--primary);
        }

        /* 48. Animated underline for headings */
        h3 {
            position: relative;
            display: inline-block;
        }
        h3::after {
            content: '';
            position: absolute;
            bottom: -5px; left: 0;
            width: 100%; height: 2px;
            background: var(--primary);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s;
        }
        h3:hover::after {
            transform: scaleX(1);
        }

        /* 49. Gradient text for vote status */
        #vote-status {
            background: linear-gradient(135deg, var(--success), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* 50. Fade-in animation for all sections on load */
        section {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        /* ----- RESPONSIVE ----- */
        @media (max-width: 768px) {
            .nav-tabs {
                display: none; position: absolute; top: 100%; left: 0; width: 100%;
                background: rgba(255,255,255,0.98); flex-direction: column;
                padding: 1rem; border-bottom: 1px solid rgba(0,0,0,0.05);
            }
            .nav-tabs.active { display: flex; }
            .hamburger { display: flex; }
            .features, .server-info, .gallery, .staff-grid, .shop-grid, .stats-grid, .vote-sites, .achievements-grid, .player-heads-grid { grid-template-columns: 1fr; }
            .hero h1 { font-size: 2.5rem; }
           
            .quick-actions { bottom: 80px; }
        }
        @media (prefers-reduced-motion: reduce) { * { animation-duration: 0.01ms !important; } }


        button:focus,
a:focus{
outline:2px solid #2ecc71;
}

.gallery-item::before{
pointer-events:none;
}

[data-tooltip]{
z-index:10000;
}


    </style>
</head>
<body>
    <canvas id="block-canvas"></canvas>
    <canvas id="particle-canvas"></canvas>
    <canvas id="rain-canvas"></canvas>
    <div id="progress-bar"></div>
    <div id="toast"><i class="fas fa-check-circle"></i> <span id="toast-message"></span></div>
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" aria-label="Toggle dark mode"><i class="fas fa-moon"></i></button>
    <button class="join-float" onclick="copyIPAndJoin()" data-tooltip="Click to copy IP"><i class="fas fa-cube"></i> play.minehood.fun:19146 <i class="fas fa-copy"></i></button>
    <button id="back2top" onclick="window.scrollTo({top:0,behavior:'smooth'})"><i class="fas fa-arrow-up"></i></button>
    <div class="quick-actions">
        <button onclick="window.scrollTo({top:0,behavior:'smooth'})" data-tooltip="Top"><i class="fas fa-arrow-up"></i></button>
        <button onclick="copyIP()" data-tooltip="Copy IP"><i class="fas fa-copy"></i></button>
        <button onclick="toggleDarkMode()" data-tooltip="Dark mode"><i class="fas fa-moon"></i></button>
    </div>

    <header>
        <nav>
            <a href="#" class="logo">MineHood</a>
            <ul class="nav-tabs">
                <li><a href="#" data-tab="home" class="active">🏡 Home</a></li>
                <li><a href="#" data-tab="server">⚔️ Server</a></li>
                <li><a href="#" data-tab="vote">🗳️ Vote</a></li>
                <li><a href="#" data-tab="shop">🛒 Shop</a></li>
                <li><a href="#" data-tab="community">🌍 Community</a></li>
                <li><a href="#" data-tab="more">➕ More</a></li>
            </ul>
            <div class="hamburger" onclick="toggleMobileNav()">
                <span></span><span></span><span></span>
            </div>
            <div class="lang-selector">
                <select id="lang-select" onchange="changeLanguage()" aria-label="Language selector">
                    <option value="en">🇬🇧 EN</option>
                    <option value="es">🇪🇸 ES</option>
                    <option value="fr">🇫🇷 FR</option>
                </select>
            </div>
        </nav>
    </header>



    <main>
        <!-- HOME TAB -->
        <div id="home" class="tab-content active">
            <section class="hero">
                <h1>⛏️ ENTER THE HAVEN</h1>
                
                <a href="#" data-tab="server" class="btn" onclick="switchTab('server')">▶️ launch adventure</a>
                <a href="#" data-tab="vote" class="btn secondary" onclick="switchTab('vote')">⚡ empower us</a>
            </section>

           

            <section>
                <h2><i class="fas fa-crown"></i> Why Choose MineHood?</h2>
                <div class="features">
                    <div class="feature"><i class="fas fa-rocket"></i><h3>Dynamic Events</h3><p>Weekly tournaments, build contests, and survival challenges with exclusive prizes.</p></div>
                    <div class="feature"><i class="fas fa-shield-halved"></i><h3>Fortified Security</h3><p>AI grief detection, instant rollbacks, and 24/7 moderation. Your builds are eternal.</p></div>
                    <div class="feature"><i class="fas fa-crown"></i><h3>Elite Rewards</h3><p>Vote perks, loyalty programs, and custom enchants. Rise through ranks.</p></div>
                </div>
            </section>

            <section>
                <h2><i class="fas fa-image"></i> Community Showcase</h2>
                <div class="gallery">
                    <div class="gallery-item" data-title="Sky City"><img src="https://images.unsplash.com/photo-1589652717521-10c0d092dea9?w=500&auto=format" alt="Sky City" loading="lazy"></div>
                    <div class="gallery-item" data-title="Automated Farm"><img src="https://images.unsplash.com/photo-1603714221042-46b00ac9e4c0?w=500&auto=format" alt="Farm" loading="lazy"></div>
                    <div class="gallery-item" data-title="Medieval Port"><img src="https://images.unsplash.com/photo-1600679472489-5c16b9b4f1e0?w=500&auto=format" alt="Port" loading="lazy"></div>
                    <div class="gallery-item" data-title="Underwater Base"><img src="https://images.unsplash.com/photo-1604076913837-52ab5629fba9?w=500&auto=format" alt="Underwater" loading="lazy"></div>
                </div>
                <!-- screenshot of the month -->
                <div style="margin-top: 2rem; text-align: center;">
                   
                    <img src="https://images.unsplash.com/photo-1605902711622-cfb43c4437b5?w=800&auto=format" alt="SOTM" style="max-width:100%; border-radius:30px; border:4px solid var(--primary);">
                </div>
            </section>

            <section>
                <h2><i class="fas fa-shield"></i> Meet the Guardians <span class="online-badge"></span> <span id="staff-online-count">3 online</span></h2>
                <div class="staff-grid">
                    <div class="staff-card"><div class="staff-avatar"><img src="https://minotar.net/avatar/MHF_Steve/100" alt="Alex"></div><h3>AlexTheAdmin <span class="online-badge"></span></h3><p>Lead Architect</p></div>
                    <div class="staff-card"><div class="staff-avatar"><img src="https://minotar.net/avatar/MHF_Creeper/100" alt="Creeper"></div><h3>SteveSecure <span class="online-badge"></span></h3><p>Security Enforcer</p></div>
                    <div class="staff-card"><div class="staff-avatar"><img src="https://minotar.net/avatar/Herobrine/100" alt="Herobrine"></div><h3>CreeperCoder <span class="online-badge"></span></h3><p>Plugin Wizard</p></div>
                </div>
                <!-- player of the week -->
                <div style="margin-top:2rem; background:var(--card-bg); padding:1.5rem; border-radius:30px;">
                    <h3>🏆 Player of the Week</h3>
                    <div style="display:flex; align-items:center; gap:1rem;">
                        <img src="https://minotar.net/avatar/BuildMaster42/100" alt="BuildMaster42" style="border-radius:50%;">
                        <div><strong>BuildMaster42</strong> – built the mega sky city and helped 15 new players!</div>
                    </div>
                </div>
            </section>

            <!-- testimonial carousel -->
            <section>
                <h2><i class="fas fa-comment"></i> Player Testimonials</h2>
                <div class="testimonial-carousel">
                    <div class="testimonial">"Best SMP ever! The community is so welcoming." – BuildMaster42</div>
                    <div class="testimonial">"I love the vote rewards, got a dragon egg!" – NetherKing</div>
                    <div class="testimonial">"Staff are super helpful and friendly." – Steve</div>
                </div>
            </section>

            <!-- new: achievements -->
            <section>
                <h2><i class="fas fa-trophy"></i> Recent Achievements</h2>
                <div class="achievements-grid">
                    <div class="achievement-card"><i class="fas fa-dragon"></i><h3>Dragon Slayer</h3><p>Defeated the Ender Dragon 100 times</p></div>
                    <div class="achievement-card"><i class="fas fa-tree"></i><h3>Forester</h3><p>Planted 10,000 trees</p></div>
                    <div class="achievement-card"><i class="fas fa-chest"></i><h3>Treasure Hunter</h3><p>Found 500 buried treasures</p></div>
                </div>
            </section>
        </div>

        <!-- SERVER TAB -->
        <div id="server" class="tab-content">
            <section>
                <h2><i class="fas fa-server"></i> Realm Specifications</h2>
                <div class="server-info">
                    <div class="info-card"><i class="fas fa-globe"></i><h3>Connection Portal <span class="copy-ip" onclick="copyIP()" data-tooltip="Copy IP">📋 copy</span></h3><p>play.minehood.fun:19146</p></div>
                    <div class="info-card"><i class="fas fa-code"></i><h3>Version</h3><p>1.20.4 - 1.21 <span class="badge" data-tooltip="Latest stable">✨ latest</span></p></div>
                    <div class="info-card"><i class="fas fa-heartbeat"></i><h3>Live Census</h3><p id="player-count">342 / 1000 <span style="color:#2ecc71;">⬤ live</span></p></div>
                    <div class="info-card"><i class="fas fa-bolt"></i><h3>Uptime</h3><p>99.99%</p></div>
                </div>
                <div style="text-align:center; margin-top:1rem;">
                    <span class="online-badge" style="width:20px; height:20px;"></span> Server Status: <strong id="server-status">Online</strong> | Ping: <span id="server-ping">25ms</span>
                </div>
                
                
            </section>
            <section>
                <h2><i class="fas fa-book-open"></i> The Sacred Codex</h2>
                <ul style="list-style:none;">
                    <li style="margin:1rem 0; padding:1rem; background:var(--card-bg); border-radius:40px;">⚖️ No griefing, stealing, or sabotage.</li>
                    <li style="margin:1rem 0; padding:1rem; background:var(--card-bg); border-radius:40px;">💬 Foster kindness; harassment is banned.</li>
                    <li style="margin:1rem 0; padding:1rem; background:var(--card-bg); border-radius:40px;">📢 /report for issues – sentinels respond.</li>
                </ul>
            </section>
            <!-- FAQ accordion -->
            <section>
                <h2><i class="fas fa-question-circle"></i> Frequently Asked Questions</h2>
                <div class="faq-item active">
                    <div class="faq-question">How do I claim rewards? <i class="fas fa-chevron-down"></i></div>
                    <div class="faq-answer">Use /claim in game after voting or purchasing.</div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">Is there a whitelist? <i class="fas fa-chevron-down"></i></div>
                    <div class="faq-answer">No, it's open to everyone!</div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">How do I become staff? <i class="fas fa-chevron-down"></i></div>
                    <div class="faq-answer">Staff applications open every 3 months on Discord.</div>
                </div>
            </section>
           </div>

        <!-- VOTE TAB -->
        <div id="vote" class="tab-content">
            <section>
                <h2><i class="fas fa-vote-yea"></i> Vote For Exclusive Reward</h2>
                <p>Vote every 14 hours for epic rewards! Next cooldown: <span id="cooldown-timer">ready</span></p>
                <div class="cooldown-progress"><div id="cooldown-fill" style="width:0%"></div></div>
                <form id="vote-form">
                    <input type="text" id="username" placeholder="Minecraft username (e.g., Notch)" required maxlength="16">
                    <button type="submit" class="btn">🌟 vote now</button>
                </form>
                <p id="vote-status" style="margin-top:1.5rem; font-weight:600;"></p>
                <div id="loading" style="display:none;"><i class="fas fa-spinner fa-spin fa-2x"></i><p>Transmitting vote...</p></div>
               
                <h3 style="margin-top:2rem;">🏆 Top Voters</h3>
                <div id="leaderboard" style="background:var(--card-bg); padding:1.5rem; border-radius:40px;">1. BuildMaster42 (342) · 2. NetherKing (301) · 3. Steve (289)</div>
                <!-- vote reminder -->
                <div id="vote-reminder" style="margin-top:2rem; display:none; background:var(--warning); padding:1rem; border-radius:30px;">
                    ⏰ Reminder: You haven't voted today! Vote now for rewards.
                </div>
                <!-- new: vote streak -->
                <div style="margin-top:2rem; background:var(--card-bg); padding:1.5rem; border-radius:40px;">
                    <h3>🔥 Your Vote Streak</h3>
                    <p id="vote-streak">0 days</p>
                </div>
                <!-- new: daily reward timer -->
                <div style="margin-top:1rem; background:var(--card-bg); padding:1.5rem; border-radius:40px;">
                    <h3>⏳ Daily Reward</h3>
                    <p>Next daily reward: <span id="daily-timer">ready</span></p>
                </div>
               
            </section>
        </div>

        <!-- SHOP TAB -->
        <div id="shop" class="tab-content">
            <section>
                <h2><i class="fas fa-store"></i> MineHood Emporium</h2>
                <p>Support the server and grab exclusive perks with in-game currency (earned by voting & playing).</p>
               <div class="shop-grid" id="shop-items">

<div class="shop-card" data-price="0.6">
<i class="fas fa-crown"></i>
<h3>Gladiator Rank</h3>
<p>Starter rank with basic perks</p>
<span class="btn shop add-to-cart">₹50 / $0.6</span>
</div>

<div class="shop-card" data-price="1.2">
<i class="fas fa-star"></i>
<h3>Eternal Rank</h3>
<p>Enhanced perks & cosmetic bonuses</p>
<span class="btn shop add-to-cart">₹99 / $1.2</span>
</div>

<div class="shop-card" data-price="2">
<i class="fas fa-galaxy"></i>
<h3>Nebula Rank</h3>
<p>Advanced abilities and server perks</p>
<span class="btn shop add-to-cart">₹159 / $2</span>
</div>

<div class="shop-card" data-price="3">
<i class="fas fa-meteor"></i>
<h3>Astral Rank</h3>
<p>Premium perks and powerful abilities</p>
<span class="btn shop add-to-cart">₹259 / $3</span>
</div>

<div class="shop-card" data-price="4.0">
<i class="fas fa-infinity"></i>
<h3>Cosmic Rank</h3>
<p>Ultimate rank with all perks unlocked</p>
<span class="btn shop add-to-cart">₹329 / $4.0</span>
</div>

</div>
            </section>
        </div>

        <!-- COMMUNITY TAB -->
        <div id="community" class="tab-content">
            <section>
                <h2><i class="fas fa-users"></i> Community Hub</h2>
                <p>Discord member count: <span id="discord-count">12,345</span> online <span class="online-badge"></span></p>
                <div style="background:var(--card-bg); border-radius:30px; padding:1rem; height:200px; overflow-y:auto; margin-bottom:2rem;" id="live-chat">
                    <p><strong>Alex:</strong> Welcome new players!</p>
                    <p><strong>Steve:</strong> Anyone up for a raid?</p>
                    <p><strong>CreeperCoder:</strong> Server update at 6pm UTC.</p>
                </div>
                
                <div class="cooldown-progress"><div style="width:65%;"></div></div>
                <p>Level 13/20</p>
                <a href="#" class="btn" onclick="showToast('Joining Discord...')"><i class="fab fa-discord"></i> Join Discord</a>
                <!-- new: staff application -->
                <a href="#" class="btn secondary" onclick="showToast('Staff application opens next month')"><i class="fas fa-clipboard-list"></i> Staff Application</a>
                <!-- new: referral program -->
                
                <!-- new: player heads gallery -->
                <h3>🎭 Player Heads</h3>
                <div class="player-heads-grid">
                    <div class="player-head"><img src="https://minotar.net/avatar/BuildMaster42/100" alt="head" style="width:100%; border-radius:50%;"></div>
                    <div class="player-head"><img src="https://minotar.net/avatar/NetherKing/100" alt="head"></div>
                    <div class="player-head"><img src="https://minotar.net/avatar/Steve/100" alt="head"></div>
                    <div class="player-head"><img src="https://minotar.net/avatar/Alex/100" alt="head"></div>
                </div>
            </section>
        </div>

        <!-- MORE TAB (new) -->
        <div id="more" class="tab-content">
            <section>
                <h2><i class="fas fa-ellipsis-h"></i> More Features</h2>
                <!-- bug report form -->
                <h3>🐞 Report a Bug</h3>
                <form id="bug-form" onsubmit="event.preventDefault(); showToast('Bug reported (simulated)');">
                    <input type="text" placeholder="Your username" style="width:100%; padding:1rem; margin-bottom:1rem; border-radius:60px; border:1px solid #ccc;">
                    <textarea placeholder="Describe the bug..." style="width:100%; padding:1rem; border-radius:30px; border:1px solid #ccc;"></textarea>
                    <button type="submit" class="btn">Submit Report</button>
                </form>
                <!-- server podcast -->
                <h3>🎙️ MineHood Podcast</h3>
                <a href="#" class="btn" onclick="showToast('Opening YouTube')"><i class="fab fa-youtube"></i> Watch Latest Episode</a>
                <!-- live player list -->
                <h3>🟢 Live Players (sample)</h3>
                <ul id="live-players" style="background:var(--card-bg); padding:1.5rem; border-radius:40px;">
                    <li>BuildMaster42</li>
                    <li>NetherKing</li>
                    <li>Steve</li>
                    <li>Alex</li>
                    <li>CreeperCoder</li>
                </ul>
                <!-- server version tooltip already added -->
                <!-- gift card already added -->
                <!-- achievements already added -->
                <!-- resource pack already added -->
                <!-- referral already added -->
            </section>
        </div>
    </main>

    <!-- MODALS -->
    <div id="confirm-modal" class="modal">
        <div class="modal-content">
            <h3>Confirm your vote</h3>
            <p id="confirm-username" style="font-size:1.4rem; color:var(--primary); margin:1rem 0;"></p>
            <p>This will dispatch your vote and grant rewards after cooldown. Continue?</p>
            <div style="display:flex; gap:1rem; justify-content:center; margin-top:2rem;">
                <button id="confirm-vote" class="btn">Yes, vote</button>
                <button id="cancel-vote" class="btn secondary" style="background:linear-gradient(45deg,#e74c3c,#c0392b);">Cancel</button>
            </div>
        </div>
    </div>

    <!-- rules modal -->
    <div id="rules-modal" class="modal">
        <div class="modal-content">
            <h3>Server Rules</h3>
            <ul style="text-align:left;">
                <li>No griefing</li>
                <li>No hacking</li>
                <li>Be respectful</li>
                <li>No spam</li>
            </ul>
            <button class="btn" onclick="document.getElementById('rules-modal').style.display='none'">Close</button>
        </div>
    </div>

    <!-- LIGHTBOX -->
    <div id="lightbox" onclick="this.style.display='none'"><img src="" alt=""></div>

    <!-- SOCIAL SECTION -->
    <section class="social">
        <h2>Forge Eternal Bonds</h2>
        <div class="social-icons">
            <a href="https://discord.gg/example" target="_blank" aria-label="Discord"><i class="fab fa-discord"></i></a>
            <a href="https://youtube.com/@MineHood" target="_blank" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
            <a href="https://instagram.com/MineHood" target="_blank" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
        </div>
    </section>

    <footer>
        <p>&copy; 2026 MineHood SMP. | <a onclick="showModal('rules-modal')">Rules</a> | <a href="#">Privacy</a> | <a href="#">Support</a></p>
    </footer>

    <script>
        // ========== GLOBAL FUNCTIONS ==========
        function toggleDarkMode() {
            document.body.classList.toggle('dark');
            const icon = document.querySelector('.dark-mode-toggle i');
            icon.classList.toggle('fa-moon'); icon.classList.toggle('fa-sun');
            localStorage.setItem('darkMode', document.body.classList.contains('dark'));
        }
        if (localStorage.getItem('darkMode') === 'true') document.body.classList.add('dark');

        function toggleMobileNav() {
            document.querySelector('.hamburger').classList.toggle('active');
            document.querySelector('.nav-tabs').classList.toggle('active');
        }

        function switchTab(tabId) {
            document.querySelectorAll('.nav-tabs a').forEach(l => l.classList.remove('active'));
            const tabLink = document.querySelector(`.nav-tabs a[data-tab="${tabId}"]`);
if(tabLink) tabLink.classList.add('active');
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            if (window.innerWidth <= 768) toggleMobileNav();
        }

        document.querySelectorAll('.nav-tabs a').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                switchTab(link.dataset.tab);
            });
        });


      // ===== COPY IP FUNCTION =====
function copyIP() {
    const ip = "play.minehood.fun:19146";

    if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(ip);
    } else {
        const input = document.createElement("input");
        input.value = ip;
        document.body.appendChild(input);
        input.select();
        document.execCommand("copy");
        document.body.removeChild(input);
    }

    showToast("IP copied to clipboard!");
}

window.copyIP = copyIP;
window.copyIPAndJoin = copyIP;


// ===== TOAST NOTIFICATION =====
function showToast(msg) {
    const toast = document.getElementById('toast');
    const message = document.getElementById('toast-message');

    if (!toast || !message) return;

    message.innerText = msg;
    toast.classList.add('show');

    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}


// ===== SHOW MODAL =====
function showModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.style.display = 'flex';
}


// ===== CLOSE MODAL WHEN CLICK OUTSIDE =====
window.addEventListener('click', (e) => {
    if (e.target.classList.contains("modal")) {
        e.target.style.display = "none";
    }
});


// ===== SCROLL PROGRESS BAR =====
window.addEventListener('scroll', () => {
    const scrollTop = window.scrollY;
    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    const scrollPercent = (scrollTop / docHeight) * 100;

    const progressBar = document.getElementById('progress-bar');
    const backToTop = document.getElementById('back2top');

    if (progressBar) progressBar.style.width = scrollPercent + '%';
    if (backToTop) backToTop.classList.toggle('visible', scrollTop > 300);
});

       // ========== CANVAS BLOCKS ==========
const canvas = document.getElementById('block-canvas');
let ctx = null;

if (canvas) {
    ctx = canvas.getContext('2d');
}

let width = 0, height = 0;

function resizeCanvas() {
    if (!canvas) return;
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
}

window.addEventListener('resize', resizeCanvas);
resizeCanvas();

const blocks = [];

for (let i = 0; i < 20; i++) {
    blocks.push({
        x: Math.random() * width,
        y: Math.random() * height,
        size: 15 + Math.random() * 40,
        speedX: (Math.random() - 0.5) * 0.2,
        speedY: (Math.random() - 0.5) * 0.15,
        color: `hsl(${Math.random() * 60 + 80}, 70%, 50%)`,
        rot: Math.random() * 360
    });
}

function drawBlocks() {

    if (!ctx) return;

    ctx.clearRect(0, 0, width, height);

    blocks.forEach(b => {

        b.x += b.speedX;
        b.y += b.speedY;

        if (b.x < -50) b.x = width + 50;
        if (b.x > width + 50) b.x = -50;

        if (b.y < -50) b.y = height + 50;
        if (b.y > height + 50) b.y = -50;

        ctx.save();

        ctx.translate(b.x, b.y);
        ctx.rotate(b.rot += 0.0004);

        ctx.fillStyle = b.color;
        ctx.shadowColor = '#2ecc71';
        ctx.shadowBlur = 15;

        ctx.fillRect(-b.size / 2, -b.size / 2, b.size, b.size);

        ctx.strokeStyle = '#2c3e50';
        ctx.lineWidth = 2;
        ctx.strokeRect(-b.size / 2, -b.size / 2, b.size, b.size);

        ctx.restore();

    });

    requestAnimationFrame(drawBlocks);
}

if (ctx) drawBlocks();
        // ========== PARTICLE EFFECT ==========
const particleCanvas = document.getElementById('particle-canvas');
const pCtx = particleCanvas.getContext('2d');
let particles = [];

function resizeParticleCanvas() {
    particleCanvas.width = window.innerWidth;
    particleCanvas.height = window.innerHeight;
}

window.addEventListener('resize', resizeParticleCanvas);
resizeParticleCanvas();

document.querySelectorAll('.btn, .copy-ip, .join-float').forEach(btn => {
    btn.addEventListener('mouseenter', (e) => {

        for (let i = 0; i < 10; i++) {

            if (particles.length < 200) {

                particles.push({
                    x: e.clientX,
                    y: e.clientY,
                    vx: (Math.random() - 0.5) * 4,
                    vy: (Math.random() - 0.5) * 4 - 2,
                    life: 1
                });

            }

        }

    });
});
        // ========== RAIN EFFECT ==========
        const rainCanvas = document.getElementById('rain-canvas');
        const rCtx = rainCanvas.getContext('2d');
        let rainDrops = [];
        function resizeRain() { rainCanvas.width = window.innerWidth; rainCanvas.height = window.innerHeight; }
        window.addEventListener('resize', resizeRain);
        resizeRain();
        for (let i = 0; i < 40; i++) {
            rainDrops.push({ x: Math.random()*window.innerWidth, y: Math.random()*window.innerHeight, len: 10+Math.random()*20, speed: 2+Math.random()*5 });
        }
        function drawRain() {
            rCtx.clearRect(0, 0, window.innerWidth, window.innerHeight);
            rCtx.strokeStyle = 'rgba(52, 152, 219, 0.3)'; rCtx.lineWidth = 1;
            rainDrops.forEach(d => {
                rCtx.beginPath(); rCtx.moveTo(d.x, d.y); rCtx.lineTo(d.x, d.y+d.len); rCtx.stroke();
                d.y += d.speed;
                if (d.y > window.innerHeight) { d.y = -20; d.x = Math.random()*window.innerWidth; }
            });
            requestAnimationFrame(drawRain);
        }
        drawRain();

        // ========== DYNAMIC PLAYER COUNT ==========
        setInterval(() => {
            let p = document.getElementById('player-count');
            if (p) {
                let cur = parseInt(p.innerText.split('/')[0]) || 342;
                cur = Math.min(1000, Math.max(280, cur + (Math.random() > 0.5 ? 1 : -1)));
                p.innerHTML = cur + ' / 1000 <span style="color:#2ecc71;">⬤ live</span>';
            }
            let pingEl = document.getElementById('server-ping');
            if (pingEl) pingEl.innerText = (20 + Math.floor(Math.random()*20)) + 'ms';
            let statusEl = document.getElementById('server-status');
            if (statusEl) statusEl.innerText = Math.random() > 0.1 ? 'Online' : 'Maintenance';
        }, 5000);

        // ========== VOTE COOLDOWN, STREAK, DAILY ==========
        const VOTE_KEY = 'bhLastVote';
        const STREAK_KEY = 'bhVoteStreak';
        const DAILY_KEY = 'bhLastDaily';
        const COOLDOWN = 14 * 60 * 60 * 1000;
        const DAY_MS = 24 * 60 * 60 * 1000;

        function updateCooldownUI() {
            const last = localStorage.getItem(VOTE_KEY);
            const now = Date.now();
            const timer = document.getElementById('cooldown-timer');
            const fill = document.getElementById('cooldown-fill');
            if (!timer || !fill) return;
            if (!last) { timer.innerText = 'ready!'; fill.style.width = '0%'; return; }
            const diff = now - parseInt(last);
            if (diff >= COOLDOWN) { timer.innerText = 'ready!'; fill.style.width = '0%'; }
            else {
                const left = COOLDOWN - diff;
                const hours = Math.floor(left / 3600000);
                const mins = Math.floor((left % 3600000) / 60000);
                timer.innerText = `${hours}h ${mins}m`;
                fill.style.width = (diff / COOLDOWN * 100) + '%';
            }
        }

        function updateStreak() {
            const last = localStorage.getItem(VOTE_KEY);
            const now = Date.now();
            let streak = parseInt(localStorage.getItem(STREAK_KEY)) || 0;
            if (last) {
                const diff = now - parseInt(last);
                if (diff < COOLDOWN + DAY_MS) { // voted within last 38h (14+24) to maintain streak
                    // streak maintained
                } else {
                    streak = 0;
                }
            } else {
                streak = 0;
            }
            const streakEl=document.getElementById("vote-streak");
if(streakEl) streakEl.innerText=streak+" days";
        }

        function updateDailyTimer() {
            const last = localStorage.getItem(DAILY_KEY);
            const now = Date.now();
            const timer = document.getElementById('daily-timer');
            if (!last) { timer.innerText = 'ready!'; return; }
            const diff = now - parseInt(last);
            if (diff >= DAY_MS) { timer.innerText = 'ready!'; }
            else {
                const left = DAY_MS - diff;
                const hours = Math.floor(left / 3600000);
                const mins = Math.floor((left % 3600000) / 60000);
                timer.innerText = `${hours}h ${mins}m`;
            }
        }

        setInterval(updateCooldownUI, 1000);
        updateCooldownUI();
        updateStreak();
        updateDailyTimer();

        // vote reminder
        setTimeout(() => {
            const last = localStorage.getItem(VOTE_KEY);
            if ((!last || (Date.now() - parseInt(last) > COOLDOWN)) && document.getElementById('vote-reminder')) {
                document.getElementById('vote-reminder').style.display = 'block';
            }
        }, 10000);

        // ========== VOTE FORM WITH MODAL + CONFETTI ==========
        const voteForm = document.getElementById('vote-form');
        const usernameInput = document.getElementById('username');
        const statusP = document.getElementById('vote-status');
        const loadingDiv = document.getElementById('loading');
        const modal = document.getElementById('confirm-modal');
        const confirmUsername = document.getElementById('confirm-username');
        const confirmBtn = document.getElementById('confirm-vote');
        const cancelBtn = document.getElementById('cancel-vote');

        function confetti() {
            for (let i=0; i<50; i++) {
                particles.push({ x: window.innerWidth/2, y: window.innerHeight/2, vx: (Math.random()-0.5)*10, vy: (Math.random()-0.5)*10-5, life: 1 });
            }
        }

        if (voteForm) {
            voteForm.addEventListener('submit', (e) => {
                e.preventDefault();
                const name = usernameInput.value.trim();
                if (!name || name.length < 3) { 
                    statusP.innerText = '❌ Username must be at least 3 characters.';
                    statusP.style.color = 'var(--error)';
                    return; 
                }
                const last = localStorage.getItem(VOTE_KEY);
                if (last && (Date.now() - parseInt(last) < COOLDOWN)) {
                    statusP.innerText = '⏳ You are on cooldown!';
                    statusP.style.color = 'var(--warning)';
                    return;
                }
                confirmUsername.textContent = name;
                modal.style.display = 'flex';
            });
        }

       confirmBtn.addEventListener('click', async () => {

    const name = usernameInput.value.trim();

    loadingDiv.style.display = 'block';
    statusP.innerText = '';

    try {

        const response = await fetch("https://api.minehood.fun/vote", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: name
            })
        });

        const data = await response.json();

        if (data.success) {

            statusP.innerHTML = "✅ Vote successful! Vote key sent in-game.";
            statusP.style.color = "var(--success)";

            confetti();
            showToast("Vote reward sent!");

        } else {

            statusP.innerHTML = "❌ Vote failed.";
            statusP.style.color = "var(--error)";

        }

    } catch (err) {

        statusP.innerHTML = "❌ Server connection error.";
        statusP.style.color = "var(--error)";

    }

    loadingDiv.style.display = "none";
    modal.style.display = "none";

});

        // ========== GALLERY LIGHTBOX ==========
        document.querySelectorAll('.gallery-item').forEach(item => {
            item.addEventListener('click', () => {
                const imgEl = item.querySelector('img');
if(!imgEl) return;
const img = imgEl.src;
                document.querySelector('#lightbox img').src = img;
                document.getElementById('lightbox').style.display = 'flex';
            });
        });

     // ========== SHOP CART SYSTEM ==========

// ========== CLOSE MOBILE NAV WHEN CLICK OUTSIDE ==========
document.addEventListener("click", (e) => {

    const nav = document.querySelector("nav");
    const navTabs = document.querySelector(".nav-tabs");
    const hamburger = document.querySelector(".hamburger");

    if (!nav) return;

    if (!nav.contains(e.target)) {

        if (navTabs) navTabs.classList.remove("active");
        if (hamburger) hamburger.classList.remove("active");

    }

});

        // ========== LIVE CHAT SIMULATION ==========
        setInterval(() => {
            const chat = document.getElementById('live-chat');
            if (!chat) return;
            const msgs = ['New player joined!', 'Anyone need help?', 'Vote for rewards!', 'Dragon fight at 8pm!'];
            const newMsg = document.createElement('p');
            newMsg.innerHTML = `<strong>Chat:</strong> ${msgs[Math.floor(Math.random()*msgs.length)]}`;
            chat.appendChild(newMsg);
            chat.scrollTop = chat.scrollHeight;
            if (chat.children.length > 10) chat.removeChild(chat.children[0]);
        }, 8000);

        // ========== EVENT COUNTDOWN ==========
        function updateEventCountdown() {
            const now = new Date();
            const nextSat = new Date();
            nextSat.setDate(now.getDate() + (6 - now.getDay() + 7) % 7);
            nextSat.setHours(20,0,0,0);
            const diff = nextSat - now;
            const days = Math.floor(diff / (1000*60*60*24));
            const hours = Math.floor((diff % (86400000)) / 3600000);
            let el = document.getElementById('event-countdown');
            if (el) el.innerText = `${days}d ${hours}h`;
        }
        setInterval(updateEventCountdown, 60000);
        updateEventCountdown();

        // ========== LANGUAGE SELECTOR (mock) ==========
        window.changeLanguage = function() {
            showToast('Language changed (demo)');
        };

        function drawParticles() {

    pCtx.clearRect(0,0,particleCanvas.width,particleCanvas.height);

    particles = particles.filter(p => p.life > 0);

    particles.forEach(p => {

        p.x += p.vx;
        p.y += p.vy;
        p.vy += 0.1;

        p.life -= 0.02;

        pCtx.fillStyle = "rgba(46,204,113,"+p.life+")";

        pCtx.beginPath();
        pCtx.arc(p.x,p.y,3,0,Math.PI*2);
        pCtx.fill();

    });

    requestAnimationFrame(drawParticles);
}

drawParticles();

       

        // ========== FAQ ACCORDION ==========
        document.querySelectorAll('.faq-question').forEach(q => {
            q.addEventListener('click', () => {
                q.parentElement.classList.toggle('active');
            });
        });

        // ========== LOGO CLICK PARTICLE ==========
      const logo = document.querySelector('.logo');
if (logo) {
    logo.addEventListener('click', (e) => {
        for (let i = 0; i < 20; i++) {
            particles.push({
                x: e.clientX,
                y: e.clientY,
                vx: (Math.random() - 0.5) * 8,
                vy: (Math.random() - 0.5) * 8 - 4,
                life: 1
            });
        }
    });
}

        // ========== INITIAL TOAST ==========
        showToast('Welcome to MineHood!');


    </script>
</body>
</html>
