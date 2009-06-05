# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Retorna divs para o flash especificado, com a mensagem do flash como
  # conteúdo do div dentro de um parágrafo e classes no div de acordo com o tipo
  # do flash.
  #
  # Exemplo:
  #
  #   >> flash[:notice] = "Sucesso absoluto!"
  #   >> display_flashes
  #   => "<div class=\"flash\ id=\"flash_notice\"><p>Sucesso absoluto!</p></div>"
  #
  def display_flashes
    return nil if flash.empty?
    html = ''
    flash.each do |key, message|
      flash_message = content_tag(:p, message)
      close_link = content_tag(
        :span,
        link_to_function('fechar', "$(this).up('#flash_#{key}').remove()"),
        :class => 'close'
      )
      html << content_tag(:div, close_link + flash_message, :class => 'flash', :id => "flash_#{key}")
    end
    html
  end

end
