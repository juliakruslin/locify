
const handleClick = (event) => {
  const highlightBox = document.querySelector('#highlight-photo')
  highlightBox.src = event.currentTarget.src
}


const initLightbox = () => {


  const photos = document.querySelectorAll('.photos img')

  photos.forEach(photo => {
    photo.addEventListener('click', handleClick)
  })
};

export { initLightbox };
