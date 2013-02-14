require_dependency 'watchers_helper'

module HideSidebarButtonPlugin
  module WatchersHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        alias_method_chain :watcher_tag, :hide_button
      end
    end

    module InstanceMethods
      if Rails::VERSION::MAJOR < 3
        def watcher_tag_with_hide_button(object, user, options={})
          [watcher_tag_without_hide_button(object, user, options),
          content_tag("span", :class => :hide_sidebar) do
            content_tag("a", :class => "icon icon-zoom-out", :href => "#", :onclick => "$('sidebar').hide();$('content').setStyle('width:auto');$$('span.show_sidebar').each(function(e){ e.show() });$$('span.hide_sidebar').each(function(e){ e.hide() });") do
              t(:button_hide_sidebar)
            end
          end,
          content_tag("span", :class => :show_sidebar, :style => "display: none;") do
            content_tag("a", :class => "icon icon-zoom-in", :href => "#", :onclick => "$('sidebar').show();$('content').setStyle('width:75%');$$('span.hide_sidebar').each(function(e){ e.show() });$$('span.show_sidebar').each(function(e){ e.hide() });") do
              t(:button_show_sidebar)
            end
          end].join(" ").html_safe
        end
      else
        def watcher_tag_with_hide_button(object, user, options={})
          [watcher_tag_without_hide_button(object, user, options),
          content_tag("span", :class => :hide_sidebar) do
            content_tag("a", :class => "icon icon-zoom-out", :href => "#", :onclick => "$('#sidebar').hide();$('#content').css({'width':'auto'});$('span.show_sidebar').show();$('span.hide_sidebar').hide();") do
              t(:button_hide_sidebar)
            end
          end,
          content_tag("span", :class => :show_sidebar, :style => "display: none;") do
            content_tag("a", :class => "icon icon-zoom-in", :href => "#", :onclick => "$('#sidebar').show();$('#content').css({'width':'75%'});$('span.hide_sidebar').show();$('span.show_sidebar').hide();") do
              t(:button_show_sidebar)
            end
          end].join(" ").html_safe
        end
      end
    end
  end
end
