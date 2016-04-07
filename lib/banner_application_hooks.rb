class BannerMessageHooks < Redmine::Hook::ViewListener
  render_on :view_layouts_base_body_bottom, :partial => 'banners/top_banner'
end
