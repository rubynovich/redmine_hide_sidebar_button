require 'redmine'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  [:watchers_helper].each do |cl|
    require "hsb_#{cl}_patch"
  end

  [ 
    [WatchersHelper, HideSidebarButtonPlugin::WatchersHelperPatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end

Redmine::Plugin.register :redmine_hide_sidebar_button do
  name 'Кнопка "Скрыть сайдбар"'
  author 'Roman Shipiev'
  description 'Во время правки задачи и в Wiki возникают ситуации, когда сайдбар (серая область справа) мешает. Например, когда таблицы в Wiki слишком широкие. Модуль добавляет кнопку "Скрыть сайдбар", которая постредством Javascript расширяет основную область за счет удаления сайдбара. Сайдбар можно вернуть кнопкой "Показать сайдбар".'
  version '0.0.3'
  url 'https://github.com/rubynovich/redmine_hide_sidebar_button'
  author_url 'http://roman.shipiev.me'
end
