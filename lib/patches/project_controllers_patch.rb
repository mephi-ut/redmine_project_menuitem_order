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
						redirect_to :controller => 'issues', :action => 'index', :project_id => @project.identifier
					end

					alias_method_chain :show, :redirect_to_issues_index
				end
			end
		end
	end
end
