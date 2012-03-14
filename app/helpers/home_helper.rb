module HomeHelper
  def handlebars_template(options = {})
    id = options[:id] || options[:partial]
    id = id.gsub(/_/, "-")
    html = <<HTML
<script id="#{id}-template" type="text/x-handlebars-template">#{render options[:partial]}</script>
HTML
    html.html_safe
  end
end
