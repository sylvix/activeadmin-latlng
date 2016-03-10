module ActiveAdmin
  module Views
    class ActiveAdminForm
      def latlng **args
        class_name = form_builder.object.class.model_name.element
        lang = args[:lang] || 'en'
        map  = args[:map]  || :yandex
        id_lat = args[:id_lat] || "#{class_name}_lat"
        id_lng = args[:id_lng] || "#{class_name}_lng"
        height = args[:height] || 400

        case map
        when :yandex
          insert_tag(YandexMapProxy, form_builder, lang, id_lat, id_lng, height)
        end
      end
    end

    class YandexMapProxy < FormtasticProxy
      def build(form_builder, *args, &block)
        @lang, @id_lat, @id_lng, @height = *args
      end

      def to_s
        "<li>" \
        "<script src=\"https://api-maps.yandex.ru/2.1/?lang=#{@lang}&load=Map,Placemark\" type=\"text/javascript\"></script>" \
        "<div id=\"yandex_map\" style=\"height: #{@height}px\"></div>" \
        "<script type=\"text/javascript\">
          var yandexMapObject = {
            coords: null,
            map: null,
            placemark: null,

            getCoordinates: function() {
              return [
                parseFloat($(\"##{@id_lat}\").val()) || 55.7522200,
                parseFloat($(\"##{@id_lng}\").val()) || 37.6155600,
              ];
            },

            saveCoordinates: function() {
              $(\"##{@id_lat}\").val( yandexMapObject.coords[0].toFixed(10) );
              $(\"##{@id_lng}\").val( yandexMapObject.coords[1].toFixed(10) );
            },

            init: function() {
              yandexMapObject.coords = yandexMapObject.getCoordinates();
              yandexMapObject.saveCoordinates();

              yandexMapObject.map = new ymaps.Map(\"yandex_map\", {
                  center: yandexMapObject.coords,
                  zoom: 12
              });

              yandexMapObject.placemark = new ymaps.Placemark( yandexMapObject.coords, {}, { preset: \"twirl#redIcon\", draggable: true } );
              yandexMapObject.map.geoObjects.add(yandexMapObject.placemark);

              yandexMapObject.placemark.events.add(\"dragend\", function (e) {      
                yandexMapObject.coords = this.geometry.getCoordinates();
                yandexMapObject.saveCoordinates();
              }, yandexMapObject.placemark);

              yandexMapObject.map.events.add(\"click\", function (e) {        
                yandexMapObject.coords = e.get(\"coords\");
                yandexMapObject.saveCoordinates();
                yandexMapObject.placemark.geometry.setCoordinates(yandexMapObject.coords);
              });
            }
          }

          ymaps.ready(yandexMapObject.init);
        </script>" \
        "</li>"
      end
    end
  end
end