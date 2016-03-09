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
          getCoordinates = function() {
            return [
              parseFloat($("#point_lat").val()) || 43.1200,
              parseFloat($("#point_lng").val()) || 131.8900,
            ];
          }

          saveCoordinates = function() {
            $("#point_lat").val( coords[0].toFixed(10) );
            $("#point_lng").val( coords[1].toFixed(10) );
          }

          function init() {     
            myMap = new ymaps.Map("yandex_map", {
                center: coords,
                zoom: 12
            });
            myPlacemark = new ymaps.Placemark( coords, {}, { preset: "twirl#redIcon", draggable: true } );
            myMap.geoObjects.add(myPlacemark);
            myPlacemark.events.add("dragend", function (e) {      
              coords = this.geometry.getCoordinates();
              saveCoordinates();
            }, myPlacemark);
            myMap.events.add("click", function (e) {        
              coords = e.get("coordPosition");
              saveCoordinates();
            });
          }

          var myMap;
          var coords = getCoordinates();

          ymaps.ready(init);
          saveCoordinates();
        </script>' \
        '</li>'
      end
    end
  end
end