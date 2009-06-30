module ActionView
  module Helpers

    module FormHelper

      # precisa?
      def label_t(object_name, method, text = nil, options = {})
        unless text
          text = I18n.t("activerecord.attributes.#{object_name.to_s}.#{method.to_s}").humanize
        end
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_label_tag(text, options)
      end

    end
    
    class FormBuilder

      # como o label normal, porém pega o nome do atributo já traduzido automagicamente, se text for nil
      def label_t(method, text = nil, options = {})
        unless text
          text = I18n.t("activerecord.attributes.#{@object_name.to_s}.#{method.to_s}").humanize
        end
        @template.label(@object_name, method, text, objectify_options(options))
      end
      
    end

  end
end
