module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path("user.png")
    end
  end

  def icon(icon_class)
    content_tag "span", "", class: "bi bi-#{icon_class}"
  end
end
