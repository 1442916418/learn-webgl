import './style.css'

import Experience from './Experience/Experience'

document.querySelector('#app').innerHTML = `
<div id="sketch"></div>
<div class="loader-screen">
    <div class="loading-container">
        <div class="loading">
            <span style="--i: 0">L</span>
            <span style="--i: 1">O</span>
            <span style="--i: 2">A</span>
            <span style="--i: 3">D</span>
            <span style="--i: 4">I</span>
            <span style="--i: 5">N</span>
            <span style="--i: 6">G</span>
        </div>
    </div>
</div>
<div class="gallery">
    <img class="gallery-item" src="https://s2.loli.net/2023/09/12/ySLGYKhVqH3BtN4.jpg" crossorigin="anonymous" alt="" />
    <img class="gallery-item" src="https://s2.loli.net/2023/09/12/BhmSdM2XA9yYftK.jpg" crossorigin="anonymous" alt="" />
    <img class="gallery-item" src="https://s2.loli.net/2023/09/12/CqIlJd1XO9rh68e.jpg" crossorigin="anonymous" alt="" />
    <img class="gallery-item" src="https://s2.loli.net/2023/09/12/RzwqhImAV9H57xs.jpg" crossorigin="anonymous" alt="" />
    <img class="gallery-item" src="https://s2.loli.net/2023/09/12/p3FME9qcUAnJixm.jpg" crossorigin="anonymous" alt="" />
</div>
`

new Experience('#sketch')
