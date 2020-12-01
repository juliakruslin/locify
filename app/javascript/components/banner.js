import Typed from 'typed.js';

const loadDynamicBannerText = () => {
   const banner = document.getElementById('banner-typed-text');
    if (banner) {
  new Typed('#banner-typed-text', {
    strings: ["Welcome to Locify", "Earn Karmapoints by shopping locally"],
    typeSpeed: 50,
    loop: true
  });
}
}

export { loadDynamicBannerText };
