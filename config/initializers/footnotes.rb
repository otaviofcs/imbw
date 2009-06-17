# 
# Arquivo de configuração das opções do plugin "rails-footnotes"
# 
# Mais informações:
# 
#  http://github.com/drnic/rails-footnotes/tree/master
# 
if (ENV['RAILS_ENV'] == 'development')
  # Setar como true se quiser abrir mais de uma nota ao mesmo tempo
  Footnotes::Filter.multiple_notes = false

  # Setar o protocolo preferido para habilitar a abertura dos arquivos via
  # navegador. Importante ter o protocolo especificado corretamente no navegador.
  # Mais informações:
  #
  #   http://josevalim.blogspot.com/2008/06/textmate-protocol-behavior-on-any.html
  #   http://kb.mozillazine.org/Register_protocol
  #
  #Footnotes::Filter.prefix = 'gedit://open?url=file://'
  Footnotes::Filter.prefix = 'netbeans://open?url=file://'
end
