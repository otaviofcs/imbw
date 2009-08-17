module Admin::PostsHelper

  def post_preview(url)
    javascript_tag do
      <<-eof
        jQuery(document).ready(function() {
          $.postScript('#{url}');
        });
      eof
    end
  end

end
