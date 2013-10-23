#
# Cookbook Name:: curl
# Recipe:: default
#
# Copyright 2013, Copperegg
#
# All rights reserved - Do Not Redistribute
#

# use source_build for the standard functions
include_recipe "source_build"

# MAKE C-ARES
############
cares_attr = node['curl']['c-ares']
# only run compile if installed source mismatch compiled
if cares_attr['enable'] == true && ( compare_list(cares_attr) == false || cares_attr['force_rebuild'] == true )

   # pull source file
   pull_source(cares_attr)

   # cleanup source tree and extract source file
   cleanup_extract_source(cares_attr)

   # configure source
   config_source(cares_attr)

   # make
   make(cares_attr)

   # install
   make_install(cares_attr)

end

# MAKE CURL
############
curl_attr = node['curl']['source']
# only run compile if installed source mismatch compiled
if compare_list(curl_attr) == false || curl_attr['force_rebuild'] == true

   # pull source file
   pull_source(curl_attr)

   # cleanup source tree and extract source file
   cleanup_extract_source(curl_attr)

   # configure source
   config_source(curl_attr)

   # make
   make(curl_attr)

   # install
   make_install(curl_attr)

end

# add ldconfig info for libcurl and libc-ares
template "/etc/ld.so.conf.d/curl.conf" do
   source "ldconf.erb"
   owner "root"
   group "root"
   mode "0644"
end

# run ldconfig
ldconfig(curl_attr)
