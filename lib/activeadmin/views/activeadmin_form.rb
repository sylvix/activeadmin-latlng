module ActiveAdmin
  module Views
    class ActiveAdminForm
      def latlng
        insert_tag(LatlngProxy, form_builder)
      end
    end

    class LatlngProxy < FormtasticProxy
      def to_s
        ""
      end
    end
  end
end