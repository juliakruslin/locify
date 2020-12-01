import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  const element = document.querySelector('#banner-typed-text')
  if (element) {

  new Typed('#banner-typed-text', {
    strings: ["Welcome to Locify", "Earn Karmapoints by shopping locally"],
    typeSpeed: 50,
    loop: true
  });
  }
}
}

export { loadDynamicBannerText };
