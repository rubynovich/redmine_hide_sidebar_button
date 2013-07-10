require 'redmine'
require 'redmine_hide_sidebar/hooks'

Redmine::Plugin.register :redmine_hide_sidebar_button do
  name '"Hide sidebar" button'
  author 'Roman Shipiev'
  description 'Adds a button that hides the sidebar'
  version '0.0.3'
  url 'https://bitbucket.org/rubynovich/redmine_hide_sidebar_button'
  author_url 'http://roman.shipiev.me'

  requires_redmine :version_or_higher => '2.3.0'
end

Rails.configuration.to_prepare do
  [:watchers_helper].each do |cl|
    require "hsb_#{cl}_patch"
  end

  [
    [WatchersHelper, HideSidebarButtonPlugin::WatchersHelperPatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end
