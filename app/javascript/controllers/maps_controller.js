import { Controller } from "@hotwired/stimulus"

const darkModeStyles = [
  { elementType: 'geometry', stylers: [{ color: '#242f3e' }] },
  { elementType: 'labels.text.stroke', stylers: [{ color: '#242f3e' }] },
  { elementType: 'labels.text.fill', stylers: [{ color: '#555574' }] },
  {
    featureType: 'administrative.locality',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#6363d5' }]
  },
  {
    featureType: 'poi',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#6363d5' }]
  },
  {
    featureType: 'poi.park',
    elementType: 'geometry',
    stylers: [{ color: '#263c3f' }]
  },
  {
    featureType: 'poi.park',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#6b9a76' }]
  },
  {
    featureType: 'road',
    elementType: 'geometry',
    stylers: [{ color: '#38414e' }]
  },
  {
    featureType: 'road',
    elementType: 'geometry.stroke',
    stylers: [{ color: '#212a37' }]
  },
  {
    featureType: 'road',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#9ca5b3' }]
  },
  {
    featureType: 'road.highway',
    elementType: 'geometry',
    stylers: [{ color: '#555574' }]
  },
  {
    featureType: 'road.highway',
    elementType: 'geometry.stroke',
    stylers: [{ color: '#1f2835' }]
  },
  {
    featureType: 'road.highway',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#f3d19c' }]
  },
  {
    featureType: 'transit',
    elementType: 'geometry',
    stylers: [{ color: '#2f3948' }]
  },
  {
    featureType: 'transit.station',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#6363d5' }]
  },
  {
    featureType: 'water',
    elementType: 'geometry',
    stylers: [{ color: '#17263c' }]
  },
  {
    featureType: 'water',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#515c6d' }]
  },
  {
    featureType: 'water',
    elementType: 'labels.text.stroke',
    stylers: [{ color: '#17263c' }]
  }
];


export default class extends Controller {
  static targets = ["map", "eventsToggle", "regionsToggle"]
  static values = { showRegions: Boolean, showEvents: Boolean, key: String }

  connect() {
    this.eventMarkers = [];
    this.regionMarkers = [];
    this.loadGoogleMapsScript();
    this.eventsToggleTarget.style.opacity = this.showEventsValue ? "1" : "0.5";
    this.regionsToggleTarget.style.opacity = this.showRegionsValue ? "1" : "0.5";
  }


  loadGoogleMapsScript() {
   
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.keyValue}`;
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);

    script.onload = () => this.initMap();
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      zoom: 5,
      center: { lat: 48.4219215, lng: -123.3652339 },
      styles: darkModeStyles,
      mapTypeControl: false,
      streetViewControl: false
    });
    this.loadMarkers();
    this.infoWindow = new google.maps.InfoWindow();

  }

  loadMarkers() {
    // Example: Fetching events and regions data passed from Rails
   // const events = JSON.parse(this.data.get("maps-events-value"))
   // let elem = document.querySelector('[data-controller="maps"]');
   // const events = document.querySelector('[data-controller="maps"]').dataset.mapsEventsValue;
    const eventsJson = document.querySelector('[data-controller="maps"]').dataset.mapsEventsValue;
    const events = JSON.parse(eventsJson);

    const regionsJson = document.querySelector('[data-controller="maps"]').dataset.mapsRegionsValue;
    const regions = JSON.parse(regionsJson);
    //const regions = JSON.parse(this.data.get("maps-regions-value"))

    // Add markers for events
    events.forEach(event => this.addMarker(event, 'event'));

    // Add markers for regions
    regions.forEach(region => this.addMarker(region, 'region'));
  }
  
  svgIcon = `
  <svg xmlns="http://www.w3.org/2000/svg" class="citizen-grey" fill="#5865F2" 
  width="40" height="40" 
  viewBox="0 0 130 100"> <!-- Adjusted viewBox to encompass the entire graphic -->
 <g>
     <g id="Discord_Logos" data-name="Discord Logos">
         <g id="Discord_Logo_-_Large_-_White" data-name="Discord Logo - Large - White">
             <path d="M107.7,8.07A105.15,105.15,0,0,0,81.47,0a72.06,72.06,0,0,0-3.36,6.83A97.68,97.68,0,0,0,49,6.83,72.37,72.37,0,0,0,45.64,0,105.89,105.89,0,0,0,19.39,8.09C2.79,32.65-1.71,56.6.54,80.21h0A105.73,105.73,0,0,0,32.71,96.36,77.7,77.7,0,0,0,39.6,85.25a68.42,68.42,0,0,1-10.85-5.18c.91-.66,1.8-1.34,2.66-2a75.57,75.57,0,0,0,64.32,0c.87.71,1.76,1.39,2.66,2a68.68,68.68,0,0,1-10.87,5.19,77,77,0,0,0,6.89,11.1A105.25,105.25,0,0,0,126.6,80.22h0C129.24,52.84,122.09,29.11,107.7,8.07ZM42.45,65.69C36.18,65.69,31,60,31,53s5-12.74,11.43-12.74S54,46,53.89,53,48.84,65.69,42.45,65.69Zm42.24,0C78.41,65.69,73.25,60,73.25,53s5-12.74,11.44-12.74S96.23,46,96.12,53,91.08,65.69,84.69,65.69Z"/>
         </g>
     </g>
 </g>
</svg>
  `;

  eventIcon = `  
  <svg version="1.1" id="Layer_2_00000156571489727549800430000003530302192383424166_" xmlns="http://www.w3.org/2000/svg" x="0" y="0" viewBox="0 0 881.5 1080.2" style="enable-background:new 0 0 881.5 1080.2; background-color:white;" xml:space="preserve"><style>.st0{fill:#161616}</style><g id="Layer_1-2"><path class="st0" d="M430.1 488.2c4.8-10.2 6.9-25.2 7.8-36.6-29.5 1.2-53.3 24.8-54.6 54.2 6.3-.5 12.4-1.2 16.8-1.8 15.1-2.3 25-5.4 30-15.8zM383.3 509.9c.8 30 24.8 54.3 54.7 55.4-1-10.8-2.5-21-4.6-28.6-5.8-20.9-18.4-24.5-50.1-26.8z"/><path class="st0" d="M772.7 396.3c-9.2-21.1-20.1-41.2-33.3-60.1-13.1-18.3-27.5-36.3-44-52.2-16.5-16.2-34.2-30.5-53.4-43.1-4-2.7-7.9-5.5-12.5-7.6 95.3 62.6 157.9 171 157.9 294.6v6.7c0 89.5-34.8 170.7-92.2 231.7-39.7 43.1-89.8 76.2-146.4 94.9-1.9-6.6-4.1-14.4-6.5-22.8 8.5-2.8 16.9-6 25.2-9.5 38.8-16.5 73.9-40 103.8-70.2 30.2-30.2 53.7-65 70.2-103.8 17.1-40.3 26-83.1 26-127 0-44-8.9-87-26-127-16.5-38.8-40-73.9-70.2-103.8-30.2-30.2-65-53.7-103.8-70.2-39.7-17.4-82.7-26-127-26s-87 8.9-127 26c-38.8 16.5-73.9 40-103.8 70.2-29.9 30.2-53.7 65-70.2 103.8-17.1 40.3-26 83.1-26 127 0 44 8.9 87 26 127 16.5 38.8 40 73.9 70.2 103.8 30.2 30.2 65 53.7 103.8 70.2 8.2 3.5 16.5 6.6 24.9 9.4-2.3 8.4-4.6 16.2-6.5 22.9-56.5-18.8-106.5-51.8-146.3-94.8C127.8 705.3 93 623.8 93 534.6v-6.7c0-123.3 62.9-231.7 157.9-294.6-4.3 2.4-8.2 5.5-12.5 7.6-18.6 12.8-36.3 27.2-52.8 43.1-16.5 16.2-30.8 33.9-44 52.2-13.1 18.9-24.1 38.8-33.3 60.1-18.9 43.7-28.1 89.8-28.1 138s9.8 94.3 28.1 138c9.2 21.1 20.1 41.2 33.3 60.1 13.1 18.3 27.5 36.3 44 52.2 16.5 16.2 34.2 30.5 53.4 43.1 19.2 12.8 40 23.8 61.4 32.7 9.4 3.9 19 7.4 28.7 10.5-1.4 4.9-2.5 8.5-2.9 10.3-2.4 9.4-7 31.1-5.3 38.4 0 0-.2 7.3 48 7.1 28.3-.1 110-.2 142.9 0 48.2.2 48-7.1 48-7.1 1.7-7.4-2.9-29-5.3-38.4-.4-1.7-1.4-5.2-2.8-10 10-3.1 19.9-6.7 29.6-10.7 21.4-9.2 41.8-19.8 61.4-32.7 19.2-12.8 36.9-27.2 53.4-43.1 16.5-16.2 30.8-33.9 44-52.2 13.1-18.9 24.1-38.8 33.3-60.1 18.9-43.7 28.1-89.8 28.1-138s-10.2-94.4-28.8-138.1zm-192-7.8c35.4 35.7 57.3 84.9 57.3 139.1 0 78.8-46.2 146.8-113 178.6 1.8-16.5 4.3-31.1 5.8-42.6 9.9-76.1 44-120.5 49.4-217.6 1.1-21 1.2-40.1.5-57.5zM525 727.9c26.3-10.7 49.2-26.6 69-46.7 19.8-19.8 35.4-43.4 46.7-69 11.3-26.9 17.1-55.3 17.1-84.6s-6.1-58-17.1-84.6c-10.7-26.3-26.6-49.2-46.7-69-4.8-4.8-9.9-9.4-15.1-13.7-5-55.1-16.7-85.7-17.1-86.7H318.7c-.3 1-12.1 31.6-17.1 86.7-5.1 4.3-10 8.9-14.7 13.7-19.8 19.8-35.4 43.4-46.7 69-11.3 26.9-17.1 55.3-17.1 84.6s6.1 58 17.1 84.6c10.7 26.3 26.6 49.2 46.7 69 19.8 19.8 43.4 35.4 69 46.7.4.2.9.4 1.3.5.3 6.7.3 13.6 0 20.6-.5 12.6-4.4 32.3-9.4 52.6-114.3-38.6-196.6-146.7-196.6-274 0-159.7 129.5-289.1 289.1-289.1S729.4 368 729.4 527.6c0 127.4-82.5 235.6-197 274.1-4.9-20.4-8.9-40-9.4-52.7-.3-6.9-.2-13.8 0-20.4.9-.2 1.5-.5 2-.7zM300.4 446c5.4 97 39.4 141.5 49.4 217.6 1.5 11.4 4 26 5.8 42.4C289.1 674.2 243 606.2 243 527.7c0-54 21.7-102.9 56.9-138.6-.8 17.2-.7 36.2.5 56.9zm51.1 61.9s12.8-.6 26.1-1.7c.3-7.7 1.9-15.1 4.9-22.2 3.3-7.4 7.7-14.2 13.5-19.9 5.7-5.8 12.3-10.4 19.9-13.5 7.1-2.9 14.6-4.6 22.5-4.9.8-13.4 2-36 2-36s1.1 22.6 1.9 36c7.8.2 15.3 1.8 22.4 4.9 7.4 3.3 14.2 7.7 19.9 13.5 5.8 5.7 10.4 12.3 13.5 19.9 2.9 7 4.6 14.6 4.9 22.3 12.9 1 25.4 1.6 26.2 1.6-9.9.6-18.5 1.1-26.2 1.6-.1 8.1-1.8 15.9-4.9 23.3-3.3 7.4-7.7 14.2-13.5 19.9-5.7 5.8-12.3 10.4-19.9 13.5-7.1 2.9-14.7 4.6-22.5 4.9-1.4 18.1-1.7 36.7-1.8 46.1 0-9.4-.3-28-1.8-46.1-7.9-.2-15.5-1.9-22.7-4.9-7.4-3.3-14.2-7.7-19.9-13.5-5.8-5.7-10.4-12.3-13.5-19.9-3-7.3-4.8-15.2-4.9-23.3-7.7-.5-16.3-1-26.1-1.6zm-231 19.7c0-176.5 143.2-320 320-320s320 143.5 320 320c0 141.6-92.4 261.9-220.1 304-1.7-6.4-3.5-13.1-5.2-19.8 7.3-2.4 14.5-5.2 21.6-8.2 35.4-15 67.5-36.6 95.3-64.1 27.5-27.5 48.8-59.2 64.1-95.3 15.6-36.9 23.5-75.7 23.5-116.3s-7.9-79.4-23.5-116.3c-15-35.4-36.6-67.5-64.1-95.3-27.5-27.5-59.2-48.8-95.3-64.1-36.9-15.6-75.7-23.5-116.3-23.5s-79.4 7.9-116.3 23.5c-35.4 15-67.5 36.6-95.3 64.1-27.8 27.5-48.8 59.2-64.1 95.3-15.6 36.9-23.5 75.7-23.5 116.3s7.9 79.4 23.5 116.3c15 35.4 36.6 67.5 64.1 95.3 27.5 27.5 59.2 48.8 95.3 64.1 7 3 14.1 5.6 21.3 8-1.7 6.7-3.5 13.4-5.2 19.8-127.6-42.1-219.8-162.3-219.8-303.8z"/><path class="st0" d="M480.4 504c4.4.7 10.4 1.3 16.7 1.8-1.3-29.4-24.9-53.1-54.5-54.3.9 11.5 2.9 26.5 7.8 36.7 4.9 10.4 15 13.5 30 15.8zM447.1 536.7c-2.1 7.6-3.6 17.8-4.6 28.6 29.8-1.2 53.8-25.5 54.5-55.4-31.5 2.3-44 6-49.9 26.8zM318.5 962.7H342v70.5c0 7.6-.3 15.6.3 23.5 7.6 0 14.4.3 21.7-.3v-93.7h23.5v-14.4h-69v14.4zM433 1057.3h21.4V948.7H433v108.6zM167.4 949.3c-2.1-.6-4.6-.9-7-.9h-45.8c-7.6 0-12.8 2.1-12.8 12.8.3 24.4 0 48.8 0 73.9v13.1c.3 5.8 2.1 7.9 7.3 9.5 2.4.6 4.6.9 7 .9h41.5c2.4 0 5.5-.3 7.6-.9 5.5-1.2 7.3-3.7 7.3-9.5v-22.3c0-1.5-.3-3.4-.6-4.9-6.1-.6-12.5-.6-19.8-.6v22.3H125c-1.5-9.5-.9-75.4.6-80.3h26.6v21.1h21.4v-27.2c-.1-3.7-2.5-6.1-6.2-7zM238.2 1057.3h21.4V948.7h-21.4v108.6zM628.1 1042.4v-33.3h31.8v-14.4h-31.4c-1.2-7.3-1.2-26.6.3-31.4h36.6V949c-20.5-.3-40-.3-59.8-.3v108.7h60.1V1043h-19.2c-6.1-.3-12.6.9-18.4-.6zM757.9 1008.2c-.6 0-1.2.3-2.1.3-4.3-8.2-9.2-17.1-13.4-25.3-5.5-10.1-10.4-20.1-15.9-30.5-.9-2.1-2.7-4-4.3-4.3-5.8-.6-11-.3-17.1-.3v109h21.4v-62c.3 0 .9 0 1.2-.3 10.4 20.8 21.1 41.5 31.8 62.6 6.4 0 12.8.3 18.9-.3V948.3h-21.1c.6 20.5.6 40.3.6 59.9zM561 962.7c2.1-4.6 2.7-9.2 1.5-13.7-9.2-1.5-58.3-.9-62.6.3v14h36.6c-1.5 3.4-2.4 6.1-3.7 8.2-11.3 24.1-22.9 48.2-34.5 72.1-2.1 4.6-2.7 8.6-1.2 13.7H563v-15h-39.7c.9-2.1 1.5-3.4 2.1-4.9 11.8-24.6 24-50 35.6-74.7zM326.8 876.9c-4.6-3.7-9.5-3.1-14-2.7-14.7 1.5-28.4 6.4-41.5 13.4-11.6 6.1-22 14.4-30.2 24.7-1.2 2.7-2.1 5.5-4 7.6 7.9 2.1 14.7 2.1 23.8.3 20.8-4 38.8-13.7 54.7-27.2 3.1-2.4 5.8-5.8 7.9-8.9 1.4-2 2.4-4.8 3.3-7.2zM555.2 877.2c.6 6.1 4.3 9.8 7.9 13.1 16.8 15.6 36 26.6 58.6 30.5 7.3 1.2 14.7 2.1 23.5-.6-4-4.9-6.7-9.8-10.4-13.4-11.3-12.5-26.3-20.5-41.8-26.6-9.2-3.1-18-5.8-27.5-6.1-3.6.4-7.9.1-10.3 3.1zM680.6 883.3c-21.1-18-45.8-24.7-72.7-24.4-4-.6-8.6-.3-11.6 3.7 1.5 5.5 2.1 7 7.6 10.7 7.6 5.5 15.9 10.1 24.4 14 14.4 6.4 29.6 9.8 45.2 9.2 5.5-.3 10.4-.9 16.5-3.4-3.2-3.7-6-7.1-9.4-9.8zM283.4 867.7c2.7-4 2.1-6.1-2.7-7.6-.9-.3-2.1-.6-3.1-.6-6.7 0-14-.3-20.8.3-18.9 2.1-36.3 8.2-51.3 19.5-5.5 3.7-10.1 7.9-14 14 3.1.9 5.5 1.5 7.3 2.1 30.5 4.3 57.4-5.5 81.2-23.8 1.3-.8 2.5-2.3 3.4-3.9zM716.7 850.9c-19.2-11.6-40.3-15-62.3-14-4.6.3-9.8.9-14.4 2.1-3.1.6-6.4 1.5-7.6 4.9 11 20.5 71.4 30.8 96.5 16.2-4.3-3.3-7.9-6.4-12.2-9.2zM237.6 854.6c4.9-2.7 9.8-5.2 11.9-11-2.4-3.1-6.1-4.3-9.5-4.9-10.7-2.4-22-2.4-33.3-1.2-15.6 1.5-30.2 6.1-43.1 14.4-3.7 2.4-7.3 4.9-10.4 9.8 3.7 1.5 6.7 2.7 10.1 3.7 10.4 3.1 21.1 3.4 31.8 2.1 14.8-1.6 29.4-5.9 42.5-12.9zM667.5 820.4c2.4 4.3 6.1 6.4 10.1 7.6 8.9 2.4 17.7 5.5 26.6 6.4 16.5 2.4 33 1.5 48.2-4.6 4-1.5 7.3-3.7 12.5-6.1-4-2.4-6.4-4.3-9.5-6.1-10.7-6.1-22.3-8.2-34.5-9.5-14.4-1.2-28.4 0-42.1 4.3-3.9 1.9-8.5 3.4-11.3 8zM145.4 811.3c-10.1 1.8-19.2 5.5-28.4 12.8 4.9 2.4 8.9 4.6 12.8 6.1 15.6 6.1 31.4 6.7 47.6 4.6 9.5-1.2 18.3-4.3 27.2-6.7 4-1.2 7.3-3.4 9.8-7.6-3.4-4.9-8.9-6.4-14-7.9-18.3-5-36.6-5.9-55-1.3zM733.8 776.4c-7.6 2.1-15.6 4.6-22.9 7.6-4.3 2.4-7.9 4.6-10.4 10.7 3.4 1.5 6.1 3.7 9.2 4.3 5.8 1.5 11 2.7 16.8 3.1 19.8 2.1 39.4-.6 57.4-10.1 4.3-2.1 8.2-5.5 14-9.2-5.8-2.1-9.5-4.3-13.4-5.8-16.8-5.4-33.9-4.5-50.7-.6zM168.6 799.6c2.7-.6 5.8-1.5 7.9-2.7 4.9-2.4 5.5-4.9.9-8.2-2.1-2.1-4.6-3.4-7-4.6-20.1-9.2-41.2-12.5-63.2-9.2-7.6 1.8-14.7 4-21.7 8.2 6.1 6.1 13.1 10.1 20.5 12.5 20.5 7.4 41.3 8.9 62.6 4zM141.8 767.3c3.7-.3 7.6-.9 10.1-4.6-8.2-20.8-65-35.1-91.9-22.6 3.7 3.4 6.4 6.4 9.8 8.9 21.6 15.8 46.3 20.4 72 18.3zM784.8 735.2c-16.5 2.1-31.4 7.3-45.2 16.2-3.1 2.1-6.1 4.6-8.2 7-2.4 2.7-2.1 4.9 1.5 6.1 3.7 1.2 7.9 2.4 12.2 2.4 8.9 0 17.7-.3 26.3-1.5 16.8-2.7 32.7-9.2 45.5-20.5.9-1.2 2.4-3.1 4.9-5.8-3.7-1.2-5.8-2.1-7.6-2.4-9.9-2.4-19.7-2.7-29.4-1.5zM127.7 727.9c-1.2-6.1-5.5-9.5-9.5-12.8-15.9-12.8-33.9-21.1-54-23.5-7.6-.9-15.6-1.2-23.8 1.5 3.1 5.5 6.4 9.5 10.4 13.1 18.3 15.9 40.3 23.5 64.1 25 4.6.1 8.8.1 12.8-3.3zM830.6 690.7c-26.6-.6-48.5 9.5-68.4 26-2.4 2.1-4.6 4.6-6.1 7.3-2.1 3.1-.9 4.9 2.4 6.1 2.7.6 6.1 1.2 9.2.9 23.8-1.5 45.2-9.2 63.5-25 3.1-3.1 6.7-7.9 10.1-11.9-.3-.6-.6-1.2-.6-2.1-3.4-.4-6.8-1.3-10.1-1.3zM99.3 691c2.1 0 4.3-.9 6.4-1.2-.6-6.1-1.5-7.9-6.1-12.8-14.4-15.9-31.8-27.2-53.1-32.7-5.8-1.5-12.5-2.4-20.1-1.2 2.4 7 6.7 12.5 11.3 17.4 14.4 15 31.8 24.1 51.6 29.3 3.3.9 6.7 1.2 10 1.2zM841.2 643.3c-24.4 4-44 16.5-60.1 34.5-3.4 3.1-4.6 6.7-7.3 11.3 6.1 3.4 11 2.4 15.9 1.5 14-2.7 26.6-8.9 38.5-16.5 10.1-6.4 18.3-14.4 24.7-25 .9-2.1 2.1-3.7 2.7-6.1-3.1-.3-4.9-.3-6.7-.3-2.5 0-5.5.3-7.7.6zM78.3 649.7c3.1 1.2 6.4 1.2 9.8 1.5 2.7 0 4-1.5 3.4-4.3-.9-2.7-2.1-6.1-3.4-8.2-13.7-20.5-31.4-35.4-55-42.7-4.6-1.5-8.9-1.8-14-3.1 1.2 7 3.7 11.6 6.7 16.5 12.8 19.6 30.8 32.1 52.5 40.3zM804.9 624.4c-4.9 5.5-9.2 11.3-13.1 17.4-2.1 2.4-3.1 6.1-1.5 9.5 5.5 2.1 10.1 0 14.4-1.5 15-5.8 28.4-14.4 39.7-26.3 6.1-6.4 11.6-13.7 15-22 2.1-2.4 2.7-4.9 3.7-7.6-3.7.3-6.4.3-9.5.9-19.7 3.9-35.2 14.6-48.7 29.6zM70.6 608.8c1.5.9 3.4 1.2 4.9 1.5 2.1.3 3.7 0 5.8 0 .9-5.5.9-7.3-2.1-13.1-10.1-19.8-23.8-36-43.7-46.7-5.8-2.4-11.9-3.7-17.4-6.1-.3 2.1-.6 2.7-.3 3.4.6 2.4.9 4.6 2.1 6.7 9.5 25 27.2 42.1 50.7 54.3zM801.3 601.8c-.9 2.4-.6 5.5-.9 7.9 6.1.9 7.6.9 13.4-2.1 19.8-10.4 35.4-25.3 45.5-45.8 2.7-4.6 4.9-10.1 4.6-16.8-2.4.6-4 .6-5.8 1.2-27.5 9.8-45.2 29.6-56.8 55.6zM65.1 564.6c2.1 2.1 4.9 3.7 10.4 2.4-.3-3.7 0-7.3-.9-10.7-1.2-4.6-2.7-9.5-4.9-13.7-8.2-17.7-19.8-33-36.9-43.1-3.4-2.1-6.7-3.4-10.7-5.5 0 3.4-.3 6.1 0 7.9 5.5 26.9 20.7 47.1 43 62.7zM829 515.1c-10.7 12.8-18.9 26.6-22.6 43.1-.6 3.7-.9 6.4 2.1 9.8 2.4-.9 5.8-1.5 7.6-3.1 22.6-14.7 37.9-34.5 43.7-61.4.6-2.7.3-6.1.6-10.1-4 2.1-6.7 2.7-9.8 4-8.1 4.3-15.5 10.4-21.6 17.7zM62.1 519.4c2.4 2.4 6.1 3.7 9.8 6.1 3.7-5.5 3.1-10.4 2.1-15-3.7-19.8-12.2-37.6-26.3-51.9-4.9-6.1-10.4-10.4-17.7-13.4-.3 3.7-.9 6.4-.6 9.5 2.1 26.2 14 46.9 32.7 64.7zM807.4 514.8c-.6 3.1-.3 6.4 2.1 9.2 21.4-4.3 46.7-51.6 41.8-79.1-3.7 2.4-7 4-10.1 6.4-19.8 16.5-29.9 38.5-33.8 63.5zM62.7 466.2c2.7 3.4 5.5 7 11.6 8.2.9-3.1 2.1-5.8 2.1-8.2.6-26.6-7.3-50.7-26.6-69.6-2.1-2.1-4-3.4-6.4-5.5-.6 2.1-1.2 2.7-1.5 4-2.1 8.2-1.5 16.5 0 24.7 3.1 17.1 10.1 32.7 20.8 46.4zM808.3 474.5c4.9-.6 7.6-4.3 10.4-7.6 11-14.4 18.3-30.5 20.8-47.9 1.8-9.5 2.1-18.3-1.2-27.8-2.4 2.1-4.3 3.1-6.1 4.6-19.5 18.9-26.9 42.7-27.2 69.3-.1 3 .5 6.3 3.3 9.4zM74.3 420.1c1.8 4 4.3 7.9 9.2 9.2 3.7-2.7 4.3-6.4 4.9-10.4 1.5-8.9.9-17.4 0-26.3-2.1-14.7-6.4-29.3-15.6-41.2-2.1-2.7-4.6-4.9-7-7.9-.9 2.4-1.5 3.7-2.1 5.5-3.1 9.5-3.4 18.9-2.7 28.4 1.1 15 5.7 29.6 13.3 42.7zM793.9 422c.6 3.1 1.2 6.1 4.3 7.3 19.5-9.5 30.5-64.1 17.7-85.2-2.1 2.1-4.3 4.3-6.1 6.7-8.2 10.7-13.1 23.5-15.6 37.3-2.1 11-2.4 22.6-.3 33.9zM97.8 388.1c4.9-3.1 6.1-6.7 7-10.4 3.7-14.4 4.3-28.4 2.1-42.7-1.5-10.4-4.9-20.5-10.7-29.3-.9-1.2-2.1-2.4-3.7-4-1.5 3.4-3.1 5.8-4 8.2-8.9 24.4-6.1 47.9 4 71.1 1 2.5 3.8 4.3 5.3 7.1zM782.9 387.5c3.7-1.2 5.8-4.3 6.7-7.3 9.5-22.3 11.6-44.9 4.3-68.4-1.2-3.4-3.1-6.4-5.5-10.7-2.4 3.4-4.3 5.8-5.8 7.9-12.2 23.2-13.1 47-6.1 71.8 1.9 2.4 3.4 5.5 6.4 6.7zM735 305.3c4-4.3 4.6-5.8 5.8-10.7 2.4-18-.3-35.1-7.3-51.9-3.7-8.6-8.2-15.6-15.9-22.3-1.2 3.7-2.4 6.4-3.1 9.8-4.9 24.7.9 47.3 13.7 68.4 1.6 2.5 4.4 4.6 6.8 6.7zM147 305.3c2.4-2.4 5.5-4.6 6.7-7 12.8-21.1 18.3-44 13.4-68.4-.6-2.7-2.1-5.8-3.4-9.8-3.4 4-6.4 7-8.9 10.4-12.8 19.2-16.2 40.9-14 63.5.7 4 1.3 8 6.2 11.3zM762.5 345c4.3-2.7 5.8-7.3 6.4-12.2 3.4-13.7 3.7-27.8 1.2-41.5-2.1-11.6-5.5-22.3-14-32.4-2.1 3.7-3.4 6.1-4.3 9.5-7.9 23.8-6.1 46.7 4 69.6 1.2 2.7 3 6.1 6.7 7zM119.8 344.7c17.4-12.2 20.8-66.3 5.5-85.5-2.1 3.4-4.3 6.1-6.1 9.5-10.4 21.7-11 44.3-5.5 67.2.9 3.6 2.4 7.3 6.1 8.8zM178.1 270.5c20.1-7.9 37.6-56.5 28.7-80-2.1 1.5-3.7 2.7-5.5 4-18.9 18.3-26.3 41.2-26.6 67.2 0 3 .3 6.4 3.4 8.8zM693.5 262.9c2.4 3.1 5.5 6.4 9.8 7 11.3-15.9-7.6-68.1-28.7-78.8-2.7 9.5-3.1 14.4-1.2 26.9 2.7 16.8 9.7 31.5 20.1 44.9zM369.5 163.1c-.1 9.5-6.1 15.4-17.8 18.6-25.5 7.2-50.4 17.5-74 31V21.9h75.7c11.3 0 16.9 4.8 16.8 14.3-.2 13.4-.3 26.7-.5 40.1-.1 5.3-2.2 9.6-6.3 13-.6.5-5.6 3.5-15 9.7 9.6 3.6 14.7 5.6 15.3 6 4.4 2.6 6.5 6.6 6.5 12-.3 15.3-.5 30.7-.7 46.1zM341.1 82c.2-13.2.4-26.4.5-39.6-11.9.5-23.8 1.1-35.6 1.7-.1 17.3-.3 34.6-.4 51.9 7.2-1.3 14.4-2.6 21.7-3.7 4.6-3.5 9.2-7 13.8-10.3zm-.4 82.5.6-46.5c-4.6-1.8-9.2-3.5-13.8-5.3-7.4 1.5-14.8 3.1-22.1 4.9-.2 19.7-.3 39.4-.5 59 11.7-4.7 23.7-8.7 35.8-12.1zM491.9 173.4c-9.7-1.5-19.4-2.6-29.1-3.3-2-9.5-4-19-6-28.4-12.2-.5-24.5-.4-36.7.2-2 9.5-4 19-6 28.6-9.7.8-19.4 2-29 3.7v-.4c13.2-52.9 26.1-102.8 38.6-152.1h30c12.3 49.3 25.2 99.1 38.2 151.7zm-39.3-50.8c-4.8-22.3-9.5-44.5-14.2-66.7-4.7 22.2-9.5 44.4-14.4 66.9 9.6-.4 19.1-.4 28.6-.2zM604 212.7c-9.2-5.3-18.6-10-28.2-14.3-10.4-31.9-21-61.1-31.8-88.4-.1-4.9-.1-9.9-.2-14.8 9.3 1.4 18.6 3 27.8 4.7-.2-18.5-.4-37-.5-55.5-11.9-.7-23.9-1.2-35.9-1.7.6 47 1.3 94.1 1.9 141.1-9.5-2.9-19.1-5.4-28.8-7.4-.6-51.5-1.3-103-1.9-154.5h75.7c11.5 0 17.2 5.7 17.2 17.3 0 22.8.1 45.6.1 68.5 0 8-2.6 12.4-7.9 13.2-2.8.4-8.8-.7-18.1-2.9 10.5 29 20.8 60.3 30.6 94.7zM319.2 273.6zM562.4 273.6s-.1 0 0 0zM529.6 507.9s-.1 0 0 0z"/></g></svg>
  `;

  svgIconUrl = `data:image/svg+xml;utf8,${encodeURIComponent(this.svgIcon).replace(/'/g, "%27").replace(/"/g, "%22")}`;
  svgEventIconUrl = `data:image/svg+xml;utf8,${encodeURIComponent(this.eventIcon).replace(/'/g, "%27").replace(/"/g, "%22")}`;


  addMarker(item, type) {
    const position = { lat: parseFloat(item.latitude), lng: parseFloat(item.longitude) };
    const title = type === 'event' ? item.title : item.server_name;
    let icon = {
      url: '', // Default icon
      scaledSize: new google.maps.Size(40, 40) // Adjust size as needed
    };

    if (type === 'event') {
      icon.url = this.svgEventIconUrl;
    } else if (type === 'region') {
      icon.url = this.svgIconUrl;
    }
    const marker = new google.maps.Marker({
      position,
      map: this.map,
      icon: icon,
      title: title
    });


  
  
    if (type === 'event') {
      marker.addListener('click', () => {
        const content = `<div><h3>${item.title}</h3><p>${item.description}</p><p>${item.address}</p></div>`;
        this.showInfoWindow(marker, content);
      });
      this.eventMarkers.push(marker);      
    } else if (type === 'region') {
      this.regionMarkers.push(marker);
      marker.addListener('click', () => {
        const content = `<div><h3>${item.name}</h3><p>${item.description}</p></div>`;
        this.showInfoWindow(marker, content);
      });
    }
    // Additional marker setup, like adding click listeners for info windows
  }
  
  showInfoWindow(marker, content) {
    this.infoWindow.setContent(content);
    this.infoWindow.open(this.map, marker);
  }

  toggleRegions() {
    this.showRegionsValue = !this.showRegionsValue;
    this.updateMapMarkers();
    this.regionsToggleTarget.style.opacity = this.showRegionsValue ? "1" : "0.5";
  }

  toggleEvents() {
    this.showEventsValue = !this.showEventsValue;
    this.updateMapMarkers();
    this.eventsToggleTarget.style.opacity = this.showEventsValue ? "1" : "0.5";

  }

  updateMapMarkers() {
    if (this.eventMarkers) {
      this.eventMarkers.forEach(marker => {
        marker.setMap(this.showEventsValue ? this.map : null);
      });
    }
  
    if (this.regionMarkers) {
      this.regionMarkers.forEach(marker => {
        marker.setMap(this.showRegionsValue ? this.map : null);
      });
    }
  }




}



