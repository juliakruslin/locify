import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Welcome to Locify", "Earn Karmapoints by shopping locally"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };
