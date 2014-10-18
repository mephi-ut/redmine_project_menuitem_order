module RedmineProjectMenuItemsOrder
	module Patches
		module ProjectsControllerPatch
			def self.included(base)
				base.class_eval do
					unloadable

					def overview
						show_without_redirect_to_issues_index
					end

					def show_with_redirect_to_issues_index
						unless User.current.allowed_to?(:view_issues, @project) && @project.module_enabled?("issue_tracking")
							show_without_redirect_to_issues_index
						else
							redirect_to :controller => 'issues', :action => 'index', :project_id => @project.identifier
						end
					end

					alias_method_chain :show, :redirect_to_issues_index
				end
			end
		end
	end
end
