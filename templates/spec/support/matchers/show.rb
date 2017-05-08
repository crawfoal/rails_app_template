RSpec::Matchers.define :show do |page_object_name|
  match do |page|
    page_object.on_page?
  end

  match_when_negated do |page|
    # on the page and hidden OR not on the page
    page_object.on_page?(visible: false) || !page_object.on_page?
  end

  define_method :page_object do
    send "_#{page_object_name}_"
  end
end
