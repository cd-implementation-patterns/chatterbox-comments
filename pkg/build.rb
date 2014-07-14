require 'rubygems'
require 'bundler'

Bundler.require(:packaging)

# FPM::Package::Puppet

# bundle install --deployment

require 'pry'; binding.pry
source = FPM::Package::Dir.new

source.attributes[:prefix] = "/chatterbox/srv/comments/"

#IDEA: Get inputs from a file
#source.inputs = File.expand_path(File.join('.', 'package.sources'), __FILE__)
source.input('./app')
source.input('./app.rb')
source.input('./config.ru')
source.input('./Rakefile')

#source.input('./pkg/default')

package = source.convert(FPM::Package::Deb)
package.name = "chatterbox-comments"
package.version = "0.0"

package.url = "https://github.com/cd-implementation-patterns"
package.vendor = "Reinaldo Jr"
package.maintainer = "Reinaldo Jr"
package.architecture = "ruby"

package.attributes[:deb_default_list] = ['./pkg/default/chatterbox-comments']

#package.provides = ""
#package.config_files << 
#package.dependencies << 

#package.attributes[:deb_init_list] FILEPATH     Add FILEPATH as an init script
#package.attributes[:deb_default_list] FILEPATH  Add FILEPATH as /etc/default configuration
#package.attributes[:deb_upstart_list] FILEPATH  Add FILEPATH as an upstart script

begin
  output = "pkg/NAME-VERSION.ARCH.deb"
  package.output(package.to_s(output))
ensure
  package.cleanup
end