#
# Cookbook Name:: curl
# Recipe:: default
#
# Copyright 2013, Copperegg
#
# All rights reserved - Do Not Redistribute
#

# make c-ares dependency if set
if node['curl']['c-ares']['enable'] == true
   unless File.exists?("#{Chef::Config[:file_cache_path]}/#{node['curl']['c-ares']['file']}")
      remote_file "#{Chef::Config[:file_cache_path]}/#{node['curl']['c-ares']['file']}" do
         source "#{node['curl']['c-ares']['url']}"
         checksum node['curl']['c-ares']['checksum']
         action :create_if_missing
      end
   end

   execute "cleanup_c-ares_source" do
      cwd Chef::Config[:file_cache_path]
      command "rm -rf curl-#{node['curl']['c-ares']['version']}"
      not_if do ! FileTest.directory?("curl-#{node['curl']['c-ares']['version']}") end
      action :run
   end

   execute "extract_c-ares_source" do
      cwd Chef::Config[:file_cache_path]
      command "tar zxf #{node['curl']['c-ares']['file']}"
      action :run
   end

   cares_flags = ""
   cares_flags = "CFLAGS=\"#{node['curl']['source']['make_flags']}\" CPPFLAGS=\"#{node['curl']['c-ares']['make_flags']}\"" if node['curl']['source']['make_flags'] =~ /\w/

   execute "config_c-ares_source" do
      cwd "#{Chef::Config[:file_cache_path]}/c-ares-#{node['curl']['c-ares']['version']}"
      command "#{cares_flags} ./configure #{node['curl']['c-ares']['default_configure_flags']}"
      action :run
   end

   execute "make_c-ares_source" do
      cwd "#{Chef::Config[:file_cache_path]}/c-ares-#{node['curl']['c-ares']['version']}"
      command "make -j #{node['cpu']['total']}"
      action :run
   end

   execute "install_c-ares_source" do
      cwd "#{Chef::Config[:file_cache_path]}/c-ares-#{node['curl']['c-ares']['version']}"
      command "make install"
      action :run
   end
end

# make curl
unless File.exists?("#{Chef::Config[:file_cache_path]}/#{node['curl']['source']['file']}")
   remote_file "#{Chef::Config[:file_cache_path]}/#{node['curl']['source']['file']}" do
     source "#{node['curl']['source']['url']}"
     checksum node['curl']['source']['checksum']
     action :create_if_missing
   end
end

execute "cleanup_curl_source" do
   cwd Chef::Config[:file_cache_path]
   command "rm -rf curl-#{node['curl']['source']['version']}"
   not_if do ! FileTest.directory?("curl-#{node['curl']['source']['version']}") end
   action :run
end

execute "extract_curl_source" do
   cwd Chef::Config[:file_cache_path]
   command "tar zxf #{node['curl']['source']['file']}"
   action :run
end

curl_flags = ""
curl_flags = "CFLAGS=\"#{node['curl']['source']['make_flags']}\" CPPFLAGS=\"#{node['curl']['c-ares']['make_flags']}\"" if node['curl']['source']['make_flags'] =~ /\w/
curl_cfg_flags = "#{node['curl']['source']['default_configure_flags']}"
curl_cfg_flags = "#{node['curl']['source']['default_configure_flags']} --enable-ares" if node['curl']['c-ares']['enable'] == true

execute "config_curl_source" do
   cwd "#{Chef::Config[:file_cache_path]}/curl-#{node['curl']['source']['version']}"
   command "#{curl_flags} ./configure #{curl_cfg_flags}"
   action :run
end

execute "make_curl_source" do
   cwd "#{Chef::Config[:file_cache_path]}/curl-#{node['curl']['source']['version']}"
   command "make -j #{node['cpu']['total']}"
   action :run
end

execute "install_curl_source" do
   cwd "#{Chef::Config[:file_cache_path]}/curl-#{node['curl']['source']['version']}"
   command "make install"
   action :run
end


# add ldconfig info for libcurl and libc-ares
template "/etc/ld.so.conf.d/curl.conf" do
   source "ldconf.erb"
   owner "root"
   group "root"
   mode "0644"
end

execute "run_ldconfig" do
   command "ldconfig"
   action :run
end


