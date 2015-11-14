source 'https://rubygems.org'

<% if enable_settings && dependency_manager_enabled?("cocoapods") %>
gem 'cocoapods'
<% end %>
gem 'xcpretty'
