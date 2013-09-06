name             'curl'
maintainer       'Copperegg'
maintainer_email 'jahrens@copperegg.com'
license          'Apache v2.0'
description      'Installs/Configures curl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "curl", "Installs curl package and sets up configuration with Debian apache style with sites-enabled/sites-available"
recipe "curl::source", "Installs curl from source and sets up configuration with Debian apache style with sites-enabled/sites-available"

%w{ ubuntu debian centos redhat amazon fedora }.each do |os|
 supports os
end

depends          'build-essential'
