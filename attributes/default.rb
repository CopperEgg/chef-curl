default['curl']['source']['version']                 = "7.32.0"
default['curl']['source']['prefix']                  = "/usr"
default['curl']['source']['default_configure_flags'] = "--prefix=#{node['curl']['source']['prefix']} --libdir=/usr/lib/x86_64-linux-gnu --with-gnutls"
default['curl']['source']['make_flags']              = ""
default['curl']['source']['file']                    = "curl-#{node['curl']['source']['version']}.tar.gz"
default['curl']['source']['url']                     = "https://s3.amazonaws.com/cuegg_src/#{node['curl']['source']['file']}"
default['curl']['source']['checksum']                = "c979fe2200fdef4219c75087b08b34aa580606a3bf7fc512b2e6b1f79e6a4e7c"

default['curl']['c-ares']['enable']                  = true
default['curl']['c-ares']['version']                 = "1.10.0"
default['curl']['c-ares']['prefix']                  = "/usr"
default['curl']['c-ares']['default_configure_flags'] = ""
default['curl']['c-ares']['make_flags']              = ""
default['curl']['c-ares']['file']                    = "c-ares-#{node['curl']['c-ares']['version']}.tar.gz"
default['curl']['c-ares']['url']                     = "https://s3.amazonaws.com/cuegg_src/#{node['curl']['c-ares']['file']}"
default['curl']['source']['checksum']                = "3d701674615d1158e56a59aaede7891f2dde3da0f46a6d3c684e0ae70f52d3db"

if node['platform'] == 'ubuntu'
   default['curl']['pkg_dependencies']          = [
   ]
elsif node['platform_family'] == 'rhel'
   default['curl']['pkg_dependencies']          = [
   ]
end