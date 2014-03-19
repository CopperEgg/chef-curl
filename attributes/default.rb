default['curl']['c-ares']['name']                    = "c-ares"
default['curl']['c-ares']['enable']                  = true
default['curl']['c-ares']['force_rebuild']           = true
default['curl']['c-ares']['version']                 = "1.10.0"
default['curl']['c-ares']['prefix']                  = "/usr"
default['curl']['c-ares']['default_configure_flags'] = ""
default['curl']['c-ares']['opt_flags']               = ""
default['curl']['c-ares']['make_flags']              = ""
default['curl']['c-ares']['make_flags']              = "CFLAGS=\"#{node['curl']['c-ares']['make_flags']}\" CPPFLAGS=\"#{node['curl']['c-ares']['make_flags']}\"" if node['curl']['c-ares']['opt_flags'] =~ /\w+/
default['curl']['c-ares']['src_dir']                 = "#{node['curl']['c-ares']['name']}-#{node['curl']['c-ares']['version']}"
default['curl']['c-ares']['src_file']                = "#{node['curl']['c-ares']['src_dir']}.tar.gz"
default['curl']['c-ares']['url']                     = "https://s3.amazonaws.com/cuegg_src/#{node['curl']['c-ares']['src_file']}"
default['curl']['c-ares']['checksum']                = "3d701674615d1158e56a59aaede7891f2dde3da0f46a6d3c684e0ae70f52d3db"
default['curl']['c-ares']['compare_list']            = {
   ".libs/libcares.so.2.1.0"     => "local/lib/libcares.so.2.1.0",
   ".libs/libcares.lai"          => "local/lib/libcares.la",
   ".libs/libcares.a"            => "local/lib/libcares.a",
   "ares.h"                      => "local/include/ares.h",
   "ares_version.h"              => "local/include/ares_version.h",
   "ares_dns.h"                  => "local/include/ares_dns.h",
   "ares_build.h"                => "local/include/ares_build.h",
   "ares_rules.h"                => "local/include/ares_rules.h"
}

default['curl']['source']['name']                    = "curl"
default['curl']['source']['force_rebuild']           = true
default['curl']['source']['version']                 = "7.33.0"
default['curl']['source']['prefix']                  = "/usr"
default['curl']['source']['enable_c-ares']           = "--enable-ares" if node['curl']['c-ares']['enable'] == true
default['curl']['source']['cfg_flags']               = "--enable-ares" if node['curl']['c-ares']['enable'] == true
default['curl']['source']['default_configure_flags'] = "--prefix=#{node['curl']['source']['prefix']} --libdir=/usr/lib/x86_64-linux-gnu --with-gnutls #{node['curl']['source']['enable_c-ares']}"
default['curl']['source']['opt_flags']               = ""
default['curl']['source']['make_flags']              = ""
default['curl']['source']['make_flags']              = "CFLAGS=\"#{node['curl']['source']['make_flags']}\" CPPFLAGS=\"#{node['curl']['source']['make_flags']}\"" if node['curl']['source']['opt_flags'] =~ /\w+/
default['curl']['source']['src_dir']                 = "#{node['curl']['source']['name']}-#{node['curl']['source']['version']}"
default['curl']['source']['src_file']                = "#{node['curl']['source']['src_dir']}.tar.gz"
default['curl']['source']['url']                     = "https://s3.amazonaws.com/cuegg_src/#{node['curl']['source']['src_file']}"
default['curl']['source']['checksum']                = "7450a9c72bd27dd89dc6996aeadaf354fa49bc3c05998d8507e4ab29d4a95172"
default['curl']['source']['compare_list']            = {
   "src/.libs/curl"                  => "local/bin/curl",
   "include/curl/curl.h"             => "local/include/curl/curl.h",
   "include/curl/curlver.h"          => "local/include/curl/curlver.h",
   "include/curl/easy.h"             => "local/include/curl/easy.h",
   "include/curl/mprintf.h"          => "local/include/curl/mprintf.h",
   "include/curl/stdcheaders.h"      => "local/include/curl/stdcheaders.h",
   "include/curl/multi.h"            => "local/include/curl/multi.h",
   "include/curl/typecheck-gcc.h"    => "local/include/curl/typecheck-gcc.h",
   "include/curl/curlbuild.h"        => "local/include/curl/curlbuild.h",
   "include/curl/curlrules.h"        => "local/include/curl/curlrules.h"
}
if node['platform'] == 'ubuntu'
   default['curl']['pkg_dependencies']          = [
   ]
elsif node['platform_family'] == 'rhel'
   default['curl']['pkg_dependencies']          = [
   ]
end
