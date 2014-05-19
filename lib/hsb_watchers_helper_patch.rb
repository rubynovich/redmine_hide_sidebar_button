require_dependency 'watchers_helper'

module HideSidebarButtonPlugin
  module WatchersHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        alias_method_chain :watcher_link, :hide_button
      end
    end

    module InstanceMethods
      def watcher_link_with_hide_button(object, user)
        [watcher_link_without_hide_button(object, user),
        content_tag("span", :class => :hide_sidebar) do
          content_tag("a", :class => "icon icon-zoom-out", :href => "#", :onclick => "$('#sidebar').hide();$('#content').css({'width':'99%'});$('span.show_sidebar').show();$('span.hide_sidebar').hide();", :"data-no-turbolink" => "true") do
            t(:button_hide_sidebar)
          end
        end,
        content_tag("span", :class => :show_sidebar, :style => "display: none;") do
          content_tag("a", :class => "icon icon-zoom-in", :href => "#", :onclick => "$('#sidebar').show();$('#content').css({'width':'auto'});$('span.hide_sidebar').show();$('span.show_sidebar').hide();  if (window.splitter_sidebar){ $('#content').css({'width':  $(window).width() - parseInt($('#sidebar').width())+'px' });  $('#main').split({orientation:'vertical', limit:100, position:'75%', panel1: '#content', panel2: '#sidebar' });  window.splitter_sidebar.refresh();  window.splitter_sidebar.trigger('resize'); };", :"data-no-turbolink" => "true") do
            t(:button_show_sidebar)
          end
        end].join(" ").html_safe
      end
    end
  end
end
