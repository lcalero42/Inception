const btn = document.getElementById('trollBtn');

document.addEventListener('mousemove', (e) => {
    const rect = btn.getBoundingClientRect();
    const distance = Math.hypot(e.clientX - (rect.left + rect.width/2),
                                e.clientY - (rect.top + rect.height/2));
    if(distance < 100) {  // moves when mouse is close
        btn.style.left = Math.random() * (window.innerWidth - rect.width) + 'px';
        btn.style.top  = Math.random() * (window.innerHeight - rect.height) + 'px';
    }
});
