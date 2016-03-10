module ActiveAdmin
  module Views
    class ActiveAdminForm
      def latlng **args
        lang = args[:lang] || 'en'
        map  = args[:map]  || :yandex
        case map
        when :yandex
          insert_tag(YandexMapProxy, form_builder, lang)
        end
      end
    end

    class YandexMapProxy < FormtasticProxy
      def build(form_builder, *args, &block)
        @lang = args.first
      end

      def to_s
        '<li>' \
        "<script src=\"https://api-maps.yandex.ru/2.1/?lang=#{@lang}&load=Map,Placemark\" type=\"text/javascript\"></script>" \
        '<div id="yandex_map" style="height: 400px"></div>' \
        '<script type="text/javascript">
          var yandexMapObject = {
            coords: null,
            map: null,
            placemark: null,

            getCoordinates: function() {
              return [
                parseFloat($("#point_lat").val()) || 43.1200,
                parseFloat($("#point_lng").val()) || 131.8900,
              ];
            },

            saveCoordinates: function() {
              $("#point_lat").val( yandexMapObject.coords[0].toFixed(10) );
              $("#point_lng").val( yandexMapObject.coords[1].toFixed(10) );
            },

            init: function() {
              yandexMapObject.coords = yandexMapObject.getCoordinates();
              yandexMapObject.saveCoordinates();

              yandexMapObject.map = new ymaps.Map("yandex_map", {
                  center: yandexMapObject.coords,
                  zoom: 12
              });

              yandexMapObject.placemark = new ymaps.Placemark( yandexMapObject.coords, {}, { preset: "twirl#redIcon", draggable: true } );
              yandexMapObject.map.geoObjects.add(yandexMapObject.placemark);

              yandexMapObject.placemark.events.add("dragend", function (e) {      
                yandexMapObject.coords = this.geometry.getCoordinates();
                yandexMapObject.saveCoordinates();
              }, yandexMapObject.placemark);

              yandexMapObject.map.events.add("click", function (e) {        
                yandexMapObject.coords = e.get("coords");
                yandexMapObject.saveCoordinates();
                yandexMapObject.placemark.geometry.setCoordinates(yandexMapObject.coords);
              });
            }
          }

          ymaps.ready(yandexMapObject.init);
        </script>' \
        '</li>'
      end
    end
  end
end