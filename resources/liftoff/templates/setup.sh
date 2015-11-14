#!/usr/bin/env bash

bundle install
<% if enable_settings && dependency_manager_enabled?("cocoapods") %>
pod install
<% end %>
<% if dependency_manager_enabled?("carthage") %>
carthage update
<% end %>
