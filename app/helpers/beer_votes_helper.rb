module BeerVotesHelper

  def star_rating(value)
    link = ""
    link << "<div class='star-rating'>"
    link << "<ul>"
    link << "<li style=\"width=#{(value/5)*100}%;\">"
    link << value.to_s
    link << "</li>"
    link << "</ul>"
    link << "<div class='clear'></div>"
    link << "</div>"
    link
  end
end
