require 'rubygems'
require 'optparse'

#CONFIG BEGIN
PATHS=[{:source =>"'s3+http://backup-virtualmachines-protonred/VMs/FirebirdUbuntuTest'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/FirebirdUbuntuTest", :unic_name =>"FirebirdUbuntuTest"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/oracle-linux-data'", :destination =>"'/home/kisiel/NAS/restore_backups/VMs/oracle-linux-data'", :unic_name =>"oracle-linux-data"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/Win8.1'", :destination =>"/media/kisiel/Data/restore_backups/VirtualBox\ VMs/Win8.1", :unic_name =>"Win8.1"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/WindowsServer2012'", :destination =>"/media/kisiel/Data/restore_backups/VirtualBox\ VMs/WindowsServer2012", :unic_name =>"WindowsServer2012"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VirtualBoxVMs/WinServer2008/media'", :destination =>"/kisiel/Data/restore_backups/VirtualBox\ VMs/WinServer2008", :unic_name =>"winServer2008"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/virtual-disc-linux-oracle'", :destination =>"/media/kisiel/Data/restore_backups/virtual\ disc\ linux\ oracle", :unic_name =>"virtual-disc-linux-oracle"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Build'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Build", :unic_name =>"Build"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Oracle_Linux_32bit'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Oracle_Linux_32bit", :unic_name =>"Oracle_Linux_32bit"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Ubuntu32bit_Test_Installers'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Ubuntu32bit_Test_Installers", :unic_name =>"Ubuntu32bit_Test_Installers"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/win8.1_oracle_test'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/win8.1_oracle_test", :unic_name =>"win8.1_oracle_test"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Win8.1_12c_oracle'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Win8.1_12c_oracle", :unic_name =>"Win8.1_12c_oracle"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Win8.1_automate'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Win8.1_automate", :unic_name =>"Win8.1_automate"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Win8.1_server'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Win8.1_server", :unic_name =>"Win8.1_server"},
       {:source =>"'s3+http://backup-virtualmachines-protonred/VMs/Win8.1_Test_Firendly_name'", :destination =>"/home/kisiel/NAS/restore_backups/VMs/Win8.1_Test_Firendly_name", :unic_name =>"Win8.1_Test_Firendly_name"}]


# system("duplicity restore s3+http://backup-virtualmachines-protonred/VMs/Win8.1_automate /home/kisiel/NAS/restore_backups/Win8.1_automate")
def restore_all
  PATHS.map{|x|  system("duplicity restore #{x[:source]} #{x[:destination]}  --progress ")}
  true
end

def restore_specific(name)
  data = PATHS.map.select{|x|  x[:unic_name]==name ? true : false}
  system("duplicity restore #{data[0][:source]} #{data[0][:destination]}  --progress ")
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
    restore_all
  when "name"
    start_time(options[:time].to_i)
    restore_specific(ARGV[1])
  else
    puts "     Usage:"
    puts "      <Command> [option]"
    puts "      Commands: all/name"
    puts "     Options"
    puts "      --time [seconds]"
    puts "     EXAMPLES:"
    puts "      restoreS3.rb name my_copy_name"
    puts "      restoreS3.rb all --time 10"

end
