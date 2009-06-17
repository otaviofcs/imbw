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

  # inicializa lightbox
  def lightbox_setup
    html = ""
    html << "<script type=\"text/javascript\">\n"
    html << "LightboxOptions.fileLoadingImage = '#{ image_path('lightbox/loading.gif') }';\n"
    html << "LightboxOptions.fileBottomNavCloseImage = '#{ image_path('lightbox/closelabel.gif') }';\n"
    html << "LightboxOptions.labelImage = 'Imagem';\n"
    html << "LightboxOptions.labelOf = 'de';\n"
    html << "</script>\n"
    html
  end

end

ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'builder'
ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'lightbox'