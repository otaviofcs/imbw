# Methods added to this helper will be available to all templates in the application.
module FaceboxViewHelper

  def facebox_image_tag(source, destination, image_options = {}, html_options = {})
    html_options.merge!(:rel => "facebox") unless html_options[:rel]
    html_options.merge!(:title => "") unless html_options[:title]
    link_to(image_tag(source, image_options), destination, html_options)
  end

  def facebox_link_to(name, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options.merge!(:rel => "facebox") unless html_options[:rel]
    html_options.merge!(:title => "") unless html_options[:title]
    link_to(name, options, html_options, *parameters_for_method_reference)
  end

  # Coloca um script para carregar o Facebox na view
  def load_facebox
    javascript_tag do
      <<-eof
        jQuery(document).ready(function() {
          jQuery('a[rel*=facebox]').facebox({
            loadingImage: '/images/facebox/loading.gif',
            closeImage: '/images/facebox/closelabel.gif'
          });
        });
      eof
    end
  end


end

# Se quiser que o facebox seja carregado direto nos defaults de javascript
# adicione as linhas abaixo a uma lib (não pode ficar nesse helper porque senão
# vai ser adicionado várias vezes e dá pau na aplicação
# ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'builder'
# ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'facebox'