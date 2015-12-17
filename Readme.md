### Backups for virtual machines

***What do you need***

* duplicity
   
         http://duplicity.nongnu.org/
      
* Ruby 2.0.0 or higher

 Dependencies:
      
        sudo apt-get install build-essential git-core curl sqlite3 libsqlite3-dev libxml2-dev libxslt1-dev 
        libreadline-dev libyaml-dev libcurl4-openssl-dev libncurses5-dev libgdbm-dev libffi-dev
      
 And:
 
        wget http://ftp.ruby-lang.org/pub/ruby/ruby-2.0.0-p247.tar.gz
        tar xvzf ruby-2.0.0-p247.tar.gz
        cd ruby-2.0.0-p247
        ./configure
        make
        make install
        
Important:  Make sure that you have a well set path for the source path and destination path!      
     

***Performing a backup to S3***

1. Run: ruby backup-managerS3.rb
2. Backup all files: ruby backup-managerS3.rb all --time 10
3. Backup specific virtual machine: ruby backup-managerS3.rb name unic_name for example: ruby backup-managerS3.rb name Win8.1

***Restoring a backup from S3***

1. Run: ruby restoreS3.rb
2. Restore all files: ruby restoreS3.rb all --time 10
3. Restore specific virtual machine: machine: ruby restoreS3.rb name unic_name for example: ruby restoreS3.rb name Win8.1
 
***Performing a backup to NAS***

1. Run: ruby backup-managerS3.rb
2. Backup all files: ruby backup-managerNAS.rb all --time 10
3. Backup specific virtual machine: ruby backup-managerNAS.rb name unic_name for example: ruby backup-managerNAS.rb name Win8.1

***Restoring a backup from NAS***

1. Run: ruby restoreNAS.rb
2. Restore all files: ruby restoreNAS.rb all --time 10
3. Restore specific virtual machine: machine: ruby restoreNAS.rb name unic_name for example: ruby restoreNAS.rb name Win8.1



