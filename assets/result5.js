function onChangeHash() {
    const section = window.location.hash.replace('#', '').split('_')[0] || 'persons';
    console.log({section});
    const navItems = document.querySelectorAll('.navigation-bar-link');
    navItems.forEach(navItem => {
        if (navItem.href.split('#')[1] === section) {
            navItem.classList.add('active');
        } else {
            navItem.classList.remove('active');
        }
    });
    
    const tabItems = document.querySelectorAll('.laurate-tab');
    tabItems.forEach(tabItem => {
        console.log(tabItem.classList, tabItem.classList.contains(section));
        if (tabItem.classList.contains(section)) {
            tabItem.classList.add('active');
        } else {
            tabItem.classList.remove('active');
        }
    });
}

window.addEventListener('hashchange', onChangeHash)

setTimeout(onChangeHash, 500);
