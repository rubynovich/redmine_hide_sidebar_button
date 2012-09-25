require 'redmine'

require 'dispatcher'
require_dependency 'watchers_helper'
require 'hsb_watchers_helper_patch'

Dispatcher.to_prepare do
  WatchersHelper.send(:include, HideSidebarButtonPlugin::WatchersHelperPatch) unless WatchersHelper.included_modules.include? HideSidebarButtonPlugin::WatchersHelperPatch
end

Redmine::Plugin.register :redmine_hide_sidebar_button do
  name 'Redmine Hide Sidebar Button plugin'
  author 'Roman Shipiev'
  description 'Adds a button that hides the sidebar'
  version '0.0.1'
  url 'https://github.com/rubynovich/redmine_hide_sidebar_button'
  author_url 'http://roman.shipiev.me'
end
