const currentPosition = document.querySelector(".current_position");

const initCurrentPosition = () => {
if (currentPosition) {
currentPosition.addEventListener("click", (event) => {
  event.preventDefault();
  navigator.geolocation.getCurrentPosition((data) => {
    const lat = data.coords.latitude;
    const lon = data.coords.longitude;
  });
});
};
};

export { initCurrentPosition };
