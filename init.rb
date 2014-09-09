require 'redmine'

Redmine::Plugin.register :redmine_project_menuitem_order do
	name 'Redmine remove Homepage'
	description 'A plugin to change order of project menu items.'
	url 'https://github.com/mephi-ut/redmine_project_menuitem_order'
	author 'Dmitry Yu Okunev'
	author_url 'https://github.com/xaionaro'
	version '0.0.1'
	delete_menu_item :project_menu, :issues
	delete_menu_item :project_menu, :new_issue
	delete_menu_item :project_menu, :calendar
	delete_menu_item :project_menu, :activity
	delete_menu_item :project_menu, :gantt
	delete_menu_item :project_menu, :settings
	delete_menu_item :project_menu, :overview
	menu :project_menu, :issues,	{ :controller => 'issues', :action => 'index' }, :param => :project_id, :caption => :label_issue_plural, :first => true
	menu :project_menu, :new_issue, { :controller => 'issues', :action => 'new', :copy_from => nil }, :param => :project_id, :caption => :label_issue_new,
		:html => { :accesskey => Redmine::AccessKeys.key_for(:new_issue) }, :after => :issues
	menu :project_menu, :activity,	{ :controller => 'activities', :action => 'index' }, :after => :new_issue
	menu :project_menu, :calendar,	{ :controller => 'calendars', :action => 'show' }, :param => :project_id, :caption => :label_calendar, :after => :activity
	menu :project_menu, :gantt,	{ :controller => 'gantts', :action => 'show' }, :param => :project_id, :caption => :label_gantt, :after => :calendar
	menu :project_menu, :overview,	{ :controller => 'projects', :action => 'show' },	:last	=> true
	menu :project_menu, :settings,	{ :controller => 'projects', :action => 'settings' },	:before	=> :overview

end

