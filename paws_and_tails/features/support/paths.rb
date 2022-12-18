# # TL;DR: YOU SHOULD DELETE THIS FILE
# #
# # This file is used by web_steps.rb, which you should also delete
# #
# # You have been warned
# module NavigationHelpers
#   # Maps a name to a path. Used by the
#   #
#   #   When /^I go to (.+)$/ do |page_name|
#   #
#   # step definition in web_steps.rb
#   #
#   def path_to(page_name)
#     case page_name
#
#     when /^the (PawsAndTails )?home\s?page$/ then '/animals'
#     when /^the animals page$/ then '/animals'
#     when /^the breeders page$/ then '/breeders'
#
#     when /the edit breeder page for "(.*)"$/
#     then edit_breeder_path(Breeder.where("name=?",$1).first)
#     when /the breeder details page for "(.*)"$/
#     then breeder_path(Breeder.where("name=?",$1).first)
#
#     when /the edit animal page for "(.*)"$/
#     then edit_animal_path(Animal.where("name=?",$1).first)
#     when /the animal details page for "(.*)"$/
#     then animal_path(Animal.where("name=?",$1).first)
#
#
#     # Add more mappings here.
#     # Here is an example that pulls values out of the Regexp:
#     #
#     #   when /^(.*)'s profile page$/i
#     #     user_profile_path(User.find_by_login($1))
#
#     else
#       begin
#         page_name =~ /^the (.*) page$/
#         path_components = $1.split(/\s+/)
#         self.send(path_components.push('path').join('_').to_sym)
#       rescue NoMethodError, ArgumentError
#         raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
#                 "Now, go and add a mapping in #{__FILE__}"
#       end
#     end
#   end
# end
#
# World(NavigationHelpers)
