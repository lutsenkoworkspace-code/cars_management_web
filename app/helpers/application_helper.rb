module ApplicationHelper
  def back_to_home_button
    link_to root_path, class: "inline-flex items-center px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm font-medium rounded transition shadow-sm" do
      content_tag(:span, "←", class: "mr-2") + t("nav.back_to_home")
    end
  end

  def nav_link_class(path)
    is_active = request.path == url_for(path).split("?").first

    base_classes = "transition font-medium"
    is_active ? "#{base_classes} text-blue-600" : "#{base_classes} text-gray-500 hover:text-gray-900"
  end
end
