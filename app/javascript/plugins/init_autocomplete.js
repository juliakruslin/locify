import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('location-search');
  const reconfigurableOptions = {
    language: 'en', // Receives results in German
    countries: ['nl', 'de', 'at'],
  };

  if (addressInput) {
    places({ container: addressInput }).configure(reconfigurableOptions)
  }
};


export { initAutocomplete };
