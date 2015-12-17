#duplicity /media/kisiel/Data/VirtualBox\ VMs s3+http://backup-virtualmachines-protonred
require 'optparse'
#CONFIG BEGIN
PATHS=[{:source =>"'/home/kisiel/NAS/wioletta/VMs/FirebirdUbuntuTest'", :destination =>"s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/FirebirdUbuntuTest", :unic_name =>"FirebirdUbuntuTest"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/oracle-linux-data'", :destination =>"s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/oracle-linux-data", :unic_name =>"oracle-linux-data"},
       {:source =>"'/media/kisiel/Data/VirtualBox\ VMs/Win8.1'", :destination =>"s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/Win8.1", :unic_name =>"Win8.1"},
       {:source =>"'/media/kisiel/Data/VirtualBox\ VMs/WindowsServer2012'", :destination =>"s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/WindowsServer2012", :unic_name =>"WindowsServer2012"},
       {:source =>"'/media/kisiel/Data/VirtualBox\ VMs/WinServer2008'", :destination =>"s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/WinServer2008", :unic_name =>"winServer"},
       {:source =>"'/media/kisiel/Data/virtual\ disc\ linux\ oracle'", :destination =>"s3+http://backup-virtualmachines-protonred/virtual-disc-linux-oracle", :unic_name =>"virtual-disc-linux-oracle"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Build'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Build", :unic_name =>"Build"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Oracle_Linux_32bit'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Oracle_Linux_32bit", :unic_name =>"Oracle_Linux_32bit"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Ubuntu32bit_Test_Installers'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Ubuntu32bit_Test_Installers", :unic_name =>"Ubuntu32bit_Test_Installers"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/win8.1_oracle_test'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/win8.1_oracle_test", :unic_name =>"win8.1_oracle_test"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Win8.1_12c_oracle'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Win8.1_12c_oracle", :unic_name =>"Win8.1_12c_oracle"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Win8.1_automate'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Win8.1_automate", :unic_name =>"Win8.1_automate"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Win8.1_server'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Win8.1_server", :unic_name =>"Win8.1_server"},
       {:source =>"'/home/kisiel/NAS/wioletta/VMs/Win8.1_Test_Firendly_name'", :destination =>"s3+http://backup-virtualmachines-protonred/VMs/Win8.1_Test_Firendly_name", :unic_name =>"Win8.1_Test_Firendly_name"}]

# SET ENVIROMENT PASSHRASE export PASSPHRASE='password'

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
    puts "      backup-managerS3.rb name my_copy_name"
    puts "      backup-managerS3.rb all --time 10"

end
