#duplicity /media/kisiel/Data/VirtualBox\ VMs s3+http://backup-virtualmachines-protonred
require 'optparse'
#CONFIG BEGIN
PATHS=[#{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Build_'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Build_",  :unic_name =>"Build"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/FirebirdUbuntuTest'", :destination => "file://#{ENV['HOME']}/NAS/backups/FirebirdUbuntuTest", :unic_name =>"FirebirdUbuntuTest"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/oracle-linux-data'", :destination =>"file://#{ENV['HOME']}/NAS/backups/oracle-linux-data", :unic_name =>"oracle-linux-data"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Vista'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Vista", :unic_name =>"Vista"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Win7'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Win7", :unic_name =>"Win7"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Win8'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Win8", :unic_name =>"Win8"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Win8.1'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Win8.1", :unic_name =>"Win8.1"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/WindowsServer2003'", :destination =>"file://#{ENV['HOME']}/NAS/backups/WinServer2003", :unic_name =>"WindowsServer2003"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/WindowsServer2012'", :destination =>"file://#{ENV['HOME']}/NAS/backups/WindowsServer2012", :unic_name =>"WindowsServer2012"},
       #{:source =>"'/media/kisiel/Data/VirtualBox\ VMs/WinServer2008'", :destination =>"file://#{ENV['HOME']}/NAS/backups/WinServer2008", :unic_name =>"winServer2008"},
       #{:source =>"'/media/kisiel/Data/virtual\ disc\ linux\ oracle'", :destination =>"file://#{ENV['HOME']}/NAS/backups/oracle", :unic_name =>"virtual-disc-linux-oracle"},
       #{:source =>"'/home/kisiel/VirtualBox\ VMs/oracle-linux'", :destination =>"file://#{ENV['HOME']}/NAS/backups/oracle-linux", :unic_name =>"oracle-linux"},
       {:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Win8.1_Build'", :destination =>"file://#{ENV['HOME']}/NAS/backups/Win8.1_Build", :unic_name =>"Win8.1_Build"},
]

#SET ENVIROMENT PASSHRASE export PASSPHRASE="password"

#END CONFIG



def backup_all
  PATHS.map{|x|  system("duplicity #{x[:source]} #{x[:destination]}  --progress ")} #system("duplicity #{x[:source]} #{x[:destination]}  --progress ")
  true
end

def backup_specific(name)
  data = PATHS.map.select{|x|  x[:unic_name]==name ? true : false}
  system("duplicity #{data[0][:source]} #{data[0][:destination]}  --progress ")
  true
end

def start_time(seconds)
  sleep seconds
end

options = {}
options[:time] = 0
opt_parser = OptionParser.new do |opt|
  opt.on("--time TIME") do |time|
    options[:time] = time
  end

end
opt_parser.parse!

case ARGV[0]
  when "all"
    start_time(options[:time].to_i)
    backup_all
  when "name"
    start_time(options[:time].to_i)
    backup_specific(ARGV[1])
  else
    puts "     Usage:"
    puts "      <Command> [option]"
    puts "      Commands: all/name"
    puts "     Options"
    puts "      --time [seconds]"
    puts "     EXAMPLES:"
    puts "      backup-manager.rb name my_copy_name"
    puts "      backup-manager.rb all --time 10"

end
