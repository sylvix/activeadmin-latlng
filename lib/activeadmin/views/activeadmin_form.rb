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
        "<script src=\"https://api-maps.yandex.ru/2.1/?lang=#{@lang}&load=Map\" type=\"text/javascript\"></script>" \
        '<div id="yandex_map" style="height: 400px"></div>' \
        '<script type="text/javascript">
          ymaps.ready(init);
          var myMap;
          function init() {     
              myMap = new ymaps.Map("yandex_map", {
                  center: [55.76, 37.64],
                  zoom: 7
              });
          }
        </script>' \
        '</li>'
      end
    end
  end
end