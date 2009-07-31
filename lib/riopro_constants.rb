# defines common Regular Expressions used by our apps
module RioproConstants

  # só letras, números, pontos e hívens
  # retirado de http://www.shauninman.com/archive/2006/05/08/validating_domain_names
  CUSTOM_DOMAIN_OK_REGEX = /^([a-z0-9]([-a-z0-9]*[a-z0-9])?\.)+((a[cdefgilmnoqrstuwxz]|aero|arpa)|(b[abdefghijmnorstvwyz]|biz)|(c[acdfghiklmnorsuvxyz]|cat|com|coop)|d[ejkmoz]|(e[ceghrstu]|edu)|f[ijkmor]|(g[abdefghilmnpqrstuwy]|gov)|h[kmnrtu]|(i[delmnoqrst]|info|int)|(j[emop]|jobs)|k[eghimnprwyz]|l[abcikrstuvy]|(m[acdghklmnopqrstuvwxyz]|mil|mobi|museum)|(n[acefgilopruz]|name|net)|(om|org)|(p[aefghklmnrstwy]|pro)|qa|r[eouw]|s[abcdeghijklmnortvyz]|(t[cdfghjklmnoprtvwz]|travel)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])$/i

  # Só letras minúsculas simples e números
  #
  # Exemplo de uso:
  #
  # validates_format_of :subdomain,
  #   :with => SUBDOMAIN_OK_REGEX,
  #   :allow_blank => true
  #
  # Exemplo de teste (com Remarkable):
  #
  # it { should allow_values_for(:subdomain, 'abc', '123', '2131231231231', 'dasdjlksadha', '123fdasd213', 'fasda12dfa') }
  # it { should_not allow_values_for(:subdomain, 'áéíóú', "tab\t", "newline\n", 'ab', '45', "Iñtërnâtiônàlizætiøn hasn't happened to ruby 1.8 yet", 'semicolon;', 'quote"', 'tick\'', 'backtick`', 'percent%', 'plus+', 'space ', 'underline_', 'hyphen-', 'MAIÚSCULAS', 'çedilha', 'maisdequarentacaracteresnaopodeblablablabl') }
  SUBDOMAIN_OK_REGEX = /\A[a-z0-9]+\z/

  # regex para email
  EMAIL_NAME_REGEX  = '[\w\.%\+\-]+'
  DOMAIN_HEAD_REGEX = '(?:[A-Z0-9\-]+\.)+'
  DOMAIN_TLD_REGEX  = '(?:[A-Z]{2}|com|edu|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'

  WEB_SITE_REGEX = /(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(([0-9]{1,5})?\/.*)?$)/ix
  
  # formatação para Email
  #
  # Exemplo de uso:
  #
  # validates_format_of :email,
  #   :with => EMAIL_REGEX,
  #   :allow_blank => true
  #
  # Exemplo de teste (com Remarkable):
  #
  # it { should allow_values_for(:contact_email, 'otavio@eu.com', 'otavio@eu.com.br', 'otavio@my.company.com', 'otavio@eu.company.com.br', 'otavio.sampaio@eu.company.com.br') }
  # it { should_not allow_values_for(:contact_email, 'ds!dsa', 'dsa@com', 'da@.com', "á@br.com", "ter@eroer.com\n") }
  EMAIL_REGEX       = /\A#{EMAIL_NAME_REGEX}@#{DOMAIN_HEAD_REGEX}#{DOMAIN_TLD_REGEX}\z/i

  # formatação para Login (only (ascii) letters, numbers and .-_)
  #
  # Exemplo de uso:
  #
  # validates_format_of :login,
  #   :with => LOGIN_REGEX,
  #   :allow_blank => true
  #
  # Exemplo de teste (com Remarkable):
  #
  # it { should allow_values_for(:login, 'lala', '3213', 'das.das-aDS_dsa', 'áçãoü32') }
  # it { should_not allow_values_for(:login, nil, '', 'ds!dsa', 'dsa d sad', '#dasd', "ádsa\n") }
  LOGIN_REGEX = /\A\w[\w\.\-_]+\z/

  # regex para formato de telefone. (00)0000-0000
  #
  # Exemplo de uso:
  #
  # validates_format_of :phone,
  #   :with => PHONE_REGEX,
  #   :allow_blank => true
  #
  # Exemplo de teste (com Remarkable):
  #
  # it { should allow_values_for(:phone, nil, '(21)9999-9999', '(31)2234-2390') }
  # it { should_not allow_values_for(:phone, '2100', '9999 9999', '9999-9999', '(21) 9999-9999', '55-21-9999-9999') }
  PHONE_REGEX = /\([0-9]{2,3}\)[0-9]{3,4}\-[0-9]{4,}/

  # formatação para CPF
  # Exemplo de uso:
  #
  # validates_format_of :cpf,
  #   :with => FORMAT_CPF_REGEX,
  #   :allow_blank => true,
  #
  # Exemplo de teste (com Remarkable):
  #
  # it { should allow_values_for(:cpf, '556.224.047-54', '364.224.331-23', :allow_blank => true) }
  # it { should_not allow_values_for(:cpf, '556 224 047-54', '36422433123', :allow_blank => true) }
  FORMAT_CPF_REGEX  = /^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$/

  # formatação para CNPJ
  #
  # Exemplo de uso:
  #
  # validates_format_of :cnpj,
  #   :with => FORMAT_CNPJ_REGEX,
  #   :allow_blank => true
  #
  # Exemplo de teste (usando Remarkable):
  #
  # it { should allow_values_for(:cnpj, '87.264.207/0001-51', '10.161.587/0001-74', '37.815.011/0001-30', :allow_blank => true) }
  # it { should_not allow_values_for(:cnpj, '87 264 207 0001 51', '10161587000174', '037815011/0001-30', :allow_blank => true) }
  FORMAT_CNPJ_REGEX = /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}-[0-9]{2}$/

end