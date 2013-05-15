module RedmineHideSidebar
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_sidebar_planning_bottom,
              :partial => 'gantts/hide_button'
  end
end 
