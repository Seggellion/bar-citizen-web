import { Controller } from "@hotwired/stimulus"

const darkModeStyles = [
  { elementType: 'geometry', stylers: [{ color: '#242f3e' }] },
  { elementType: 'labels.text.stroke', stylers: [{ color: '#242f3e' }] },
  { elementType: 'labels.text.fill', stylers: [{ color: '#746855' }] },
  {
    featureType: 'administrative.locality',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#d59563' }]
  },
  {
    featureType: 'poi',
    elementType: 'labels.text.fill',
    stylers: [{ color: '#d59563' }]
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
    stylers: [{ color: '#746855' }]
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
    stylers: [{ color: '#d59563' }]
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
  static targets = ["map"]
  static values = { showDiscords: Boolean, showEvents: Boolean, key: String }

  connect() {

    this.loadGoogleMapsScript();

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

  }

  loadMarkers() {
    // Example: Fetching events and discords data passed from Rails
   // const events = JSON.parse(this.data.get("maps-events-value"))
   // let elem = document.querySelector('[data-controller="maps"]');
   // const events = document.querySelector('[data-controller="maps"]').dataset.mapsEventsValue;
    const eventsJson = document.querySelector('[data-controller="maps"]').dataset.mapsEventsValue;
    const events = JSON.parse(eventsJson);

    const discordsJson = document.querySelector('[data-controller="maps"]').dataset.mapsDiscordsValue;
    const discords = JSON.parse(discordsJson);
    //const discords = JSON.parse(this.data.get("maps-discords-value"))
    
    // Add markers for events
    events.forEach(event => this.addMarker(event, 'event'));

    // Add markers for discords
    discords.forEach(discord => this.addMarker(discord, 'discord'));
  }
  
  addMarker(item, type) {
    const position = { lat: parseFloat(item.latitude), lng: parseFloat(item.longitude) };
    const title = type === 'event' ? item.title : item.server_name;
    console.log('position:', position);
    const marker = new google.maps.Marker({
      position,
      map: this.map,
      title: title
    });
  
    // Additional marker setup, like adding click listeners for info windows
  }
  

  toggleDiscords() {
    this.showDiscordsValue = !this.showDiscordsValue
    this.updateMapMarkers()
  }

  toggleEvents() {
    this.showEventsValue = !this.showEventsValue
    this.updateMapMarkers()
  }

  updateMapMarkers() {
    // Update the map based on the current states of showDiscordsValue and showEventsValue
    // Add or remove markers accordingly
  }




}



