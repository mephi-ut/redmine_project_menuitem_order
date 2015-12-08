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
							case params[:format]
								when 'xml', 'json'
									return show_without_redirect_to_issues_index
							end

							query_id_str = ''
							@project.custom_field_values.each do |cf|
								if cf.custom_field.name == "Запрос по умолчанию (id)"
									query_id_str = cf.value
									break
								end
							end
							if /\A\d+\z/.match(query_id_str)
								# Is a positive number
								query_id = query_id_str.to_i
								redirect_to :controller => 'issues', :action => 'index', :project_id => @project.identifier , :query_id => query_id
							else
								redirect_to :controller => 'issues', :action => 'index', :project_id => @project.identifier
							end
						end
					end

					alias_method_chain :show, :redirect_to_issues_index
				end
			end
		end
	end
end
