module Admin::PostsHelper

  def post_preview(url)
    javascript_tag do
      <<-eof
        jQuery(document).ready(function() {
          $("#preview_button").bind("click", function() {
            $.post('#{url}', $('#post').find('form').serialize().replace('_method=put', '_method=post'), null, 'script');
          });
        });
      eof
    end
  end

  def save_and_continue(url)
    javascript_tag do
      <<-eof
        jQuery(document).ready(function() {
          $("#save_and_continue").bind("click", function() {
            $.post('#{url}', $('#post').find('form').serialize(), null, 'script');
          });
        });
      eof
    end
  end

end
