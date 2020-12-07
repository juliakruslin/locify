import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  const element = document.querySelector('#banner-typed-text')
  if (element) {

  new Typed('#banner-typed-text', {
    strings: ["Welcome! My name is"],
    typeSpeed: 50,
    loop: false
  });
  }
}

export { loadDynamicBannerText };
