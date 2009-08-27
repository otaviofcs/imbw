# Methods added to this helper will be available to all templates in the application.
module LightboxViewHelper

  def lightbox_image_tag(source, destination, image_options = {}, html_options = {})
    html_options.merge!(:rel => "lightbox") unless html_options[:rel]
    html_options.merge!(:title => "") unless html_options[:title]
    link_to(image_tag(source, image_options), destination, html_options)
  end

  def lightbox_link_to(name, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options.merge!(:rel => "lightbox") unless html_options[:rel]
    html_options.merge!(:title => "") unless html_options[:title]
    link_to(name, options, html_options, *parameters_for_method_reference)
  end

  # inicializa lightbox. Por padrão inicia o lightbox para todas as imagens
  # que contenham em parte da tag rel o nome lightbox. Se você quiser fazer
  # uma galeria específica, passe o nome da mesma. Assim o lightbox vai agrupar
  # todos os links cujo rel seja exatamente lightboxNOME_GALERIA
  def lightbox_init(gallery_name = nil)
    javascript_tag do
      html = ""
      html <<	"$(document).ready(function(){\n"
      unless gallery_name
        html <<	"$('a[rel*=lightbox]').lightbox();\n"
      else
        html <<	"$('a[rel=lightbox#{gallery_name}]').lightbox();\n"
      end
      html <<	"});"
      html
    end
  end
end

# Se quiser que o lightbox seja carregado direto nos defaults de javascript
# adicione as linhas abaixo a uma lib (não pode ficar nesse helper porque senão
# vai ser adicionado várias vezes e dá pau na aplicação
# ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'builder'
# ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'lightbox'