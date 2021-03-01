import mapboxgl from 'mapbox-gl';

(() => {
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'style.json',
        attributionControl: true,
        hash: true
    });

    map.addControl(new mapboxgl.NavigationControl(), 'top-right');
    map.addControl(new mapboxgl.ScaleControl({ maxWidth: 200, unit: 'metric' }), 'bottom-left');
})();