document.addEventListener("turbo:load", function () {
    ymaps.ready(init);

    function init() {
        if (document.getElementById("map")) {
            var address = document.getElementById("map").getAttribute("data-address");

            var myMap = new ymaps.Map("map", {
                center: [55.753994, 37.622093],
                zoom: 7
            });

            ymaps.geocode(address, {
                results: 1
            }).then(function (res) {

                var firstGeoObject = res.geoObjects.get(0),
                    coords = firstGeoObject.geometry.getCoordinates(),
                    bounds = firstGeoObject.properties.get("boundedBy");

                firstGeoObject.options.set("preset", "islands#darkBlueDotIconWithCaption");

                firstGeoObject.properties.set("iconCaption", firstGeoObject.getAddressLine());

                myMap.geoObjects.add(firstGeoObject);

                myMap.setBounds(bounds, {
                    checkZoomRange: true
                });
            });
        }
    }

})
