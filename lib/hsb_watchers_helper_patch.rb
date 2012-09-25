module HideSidebarButtonPlugin
  module WatchersHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        alias_method_chain :watcher_tag, :hide_button
      end
    end
      
    module InstanceMethods
      def watcher_tag_with_hide_button(object, user, options={})
        [watcher_tag_without_hide_button(object, user, options),
        content_tag("span", :id => :hide_sidebar) do
          content_tag("a", :class => "icon icon-zoom-out", :href => "javascript:$('sidebar').hide();$('content').setStyle('width:auto');$('show_sidebar').show();$('hide_sidebar').hide();") do
            t(:button_hide_sidebar)
          end
        end,
        content_tag("span", :id => :show_sidebar, :style => "display: none;") do
          content_tag("a", :class => "icon icon-zoom-in", :href => "javascript:$('sidebar').show();$('content').setStyle('width:75%');$('hide_sidebar').show();$('show_sidebar').hide();") do
            t(:button_show_sidebar)
          end
        end].join(" ")       
      end
    end
  end
end
