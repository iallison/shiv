# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

$old_shiv = "/Users/jd/work/oldshiv/bin/shiv"
$limit = 0;

## Create a new user account in the database first with a temporary password
User.create([email: 'jd@sdsc.edu', password: 'changeme', password_confirmation: 'changeme'])
User.create([email: 'smeier@sdsc.edu', password: 'changeme', password_confirmation: 'changeme'])
User.create([email: 'kcoakley@sdsc.edu', password: 'changeme', password_confirmation: 'changeme'])
User.create([email: 'brianb@sdsc.edu', password: 'k923jhvz0pVSap', password_confirmation: 'k923jhvz0pVSap'])
User.create([email: 'dougw@sdsc.edu', password: 'iqpsz-2135128xz', password_confirmation: 'iqpsz-2135128xz'])
User.create([email: 'silvaf@sdsc.edu', password: '90134alasdila2w', password_confirmation: '90134alasdila2w'])
User.create([email: 'daaudish@sdsc.edu', password: '9sjwuvng81js3', password_confirmation: '9sjwuvng81js3'])
User.create([email: 'jeff@sdsc.edu', password: 'qpznJ782Ssar', password_confirmation: 'qpznJ782Ssar'])
User.create([email: 'dferbert@sdsc.edu', password: 'lajjsu@842szS', password_confirmation: 'lajjsu@842szS'])
User.create([email: 'colby@sdsc.edu', password: '8zluwSQpklsdur', password_confirmation: '8zluwSQpklsdur'])
User.create([email: 'tmcnew@sdsc.edu', password: '91jsuvmSw002ls', password_confirmation: '91jsuvmSw002ls'])
User.create([email: 'jfilliez@sdsc.edu', password: '12aRInmsWplr3', password_confirmation: '12aRInmsWplr3'])
User.create([email: 'twalkerb@sdsc.edu', password: '1U9IXJGHes012v', password_confirmation: '1U9IXJGHes012v'])
User.create([email: 'ssps@sdsc.edu', password: '81UWMVawA$32', password_confirmation: '81UWMVawA$32'])

# import Boxes next..
def importBoxes
  boxes = YAML.load(%x(#{$old_shiv} lsbox))

  count = 1
  boxesStartAt = 0
  boxes.each do |b|
    break if count > $limit && $limit > 0
    next if b.gsub(/[^0-9]/,'').to_i < boxesStartAt

    yml = YAML.load(%x(#{$old_shiv} showbox #{b}))
    box = Box.new
    yml.each_key do |boxName|

      if yml[boxName].has_key?("traits")
        yml[boxName]['traits'].each do |name, value|
          #puts "#{name} = #{value}"
          box.name = boxName
          case name
          when 'type'
            #noop
          when 'serialnumber', 'serial'
            name = 'serial'
            box.serial = value unless value == "null"
          when 'model'
            box.model = value
          when 'vendor'
            box.vendor = value
          when 'location', 'locations'
            box.location = value
          when 'purchasedate'
            box.purchase_date = value
          when 'console_ip', 'consoleip', 'console', 'consoloe_ip'
            box.console_ip = value
          when 'mac_nic1'
            box.mac_nic1 = value
          else
            puts "Not sure what to do with #{name} = #{value}"
            exit
          end
        end

      end
    end
    puts "Saving: #{box.inspect}"
    box.save

    notes = %x(#{$old_shiv} note #{b})
    @note_arr = []

    notes.each_line do |line|
      if /^([0-9]){4}\-([0-9]){2}\-([0-9]){2}/ =~ line
        @note_arr << OpenStruct.new
        @note_arr.last.created_at = line[/^(\d){4}.*UTC/]
        @note_arr.last.user = replace_user(line.split('UTC')[1].strip)
        @note_arr.last.comment = ''
      else
        @note_arr.last.comment = line.strip
      end

    end

    @note_arr.each do |note|
      user = User.find_by_email(note.user)
      user_id = user.id unless user.nil?
      box.comments.create(:comment => note.comment, :created_at => note.created_at, :user_id => user_id)
      box.save
    end

    #puts @note_arr
    count += 1

  end
end


# now hosts...
def importHosts
  skip = 0
  hosts = YAML.load(%x(#{$old_shiv} listhost))
  count = 0
  hosts.each do |h|
    count += 1
    break if count > $limit && $limit > 0
    next if h.nil? || count < skip
    next if /^cloud:storage:invoice|^cloud:storage:|^project:storage|@/ =~ h

    yml = YAML.load(%x(#{$old_shiv} show "^#{h}$"))
    host = Host.new
    host.typer = 'host'
    yml.inspect
    yml.each_key do |hostName|

      host.name = hostName

      if !hostName.empty? && yml[hostName].has_key?("traits")
        yml[hostName]['traits'].each do |name, value|
          #puts "#{name} = #{value}"
          case name
          when 'type'
            host.typer = value
            break if value != 'host'
          when 'os', 'operatingsystem'
            host.operating_system = value
          when 'kernel'
            host.kernel = value
          when 'operatingsystemrelease', 'osrelease'
            host.os_release = value unless value == "null"
          when 'ip'
            host.ip = value
          when 'nagios_host_template'
            host.nagios_host_template = value
          when 'nagios_host_group', 'nagios_hostgroup'
            host.nagios_hostgroup = value
          when 'admingroup'
            host.admingroup = value
          when 'ip:eth0'
            host.ip_eth0 = value
          when 'mac:eth0'
            host.mac_eth0 = value
          when 'location'
            host.location = value
          when 'is_virtual'
            host.is_virtual = value
          when 'test', 'service:cloud:storage:zone', 'id'
            #noop
          else
            puts "Not sure what to do with #{hostName} -> #{name} = #{value}"
            exit
          end
        end
      end

      if !hostName.empty? && yml[hostName].has_key?("hostings")
        yml[hostName]['hostings'].each do |boxName|
          puts "Searching for box: #{boxName}"
          box = Box.find_by_name("#{boxName}")
          host.box_id = box.id unless box.nil?
        end
      end

      if !hostName.empty? && yml[hostName].has_key?('tags')
        tags = []
        yml[hostName]['tags'].each do |tag|
          tags << tag
        end
        host.tag_list = tags.join(',')
      end


    end

    if !host.name.nil? && host.typer == 'host'
      puts "[#{count}] Saving : #{host.inspect}"
      host.save
      host.typer = nil
      host.save
    else
      puts "[#{count}] Skipping #{host.name}"
    end

    notes = %x(#{$old_shiv} note "#{h}")
    @note_arr = []

    notes.each_line do |line|
      if /^([0-9]){4}\-([0-9]){2}\-([0-9]){2}/ =~ line
        @note_arr << OpenStruct.new
        @note_arr.last.created_at = line[/^(\d){4}.*UTC/]
        @note_arr.last.user = replace_user(line.split('UTC')[1].strip)
        @note_arr.last.comment = ''
      else
        @note_arr.last.comment = line.strip unless line.strip == 'Nothing noted.'
      end

    end

    @note_arr.each do |note|
      user = User.find_by_email(note.user)
      user_id = user.id unless user.nil?
      host.save
      host.comments.create(:comment => note.comment, :created_at => note.created_at, :user_id => user_id)
      host.save
    end
  end
end


def replace_user(user)
  case user
  when 'Test Dude', 'Test User', 'smeier'
    'smeier@sdsc.edu'
  when 'jd'
    'jd@sdsc.edu'
  when 'brianb'
    'brianb@sdsc.edu'
  when 'silvaf'
    'silvaf@sdsc.edu'
  when 'dougw', 'dweimer'
    'dougw@sdsc.edu'
  when 'daaudish'
    'daaudish@sdsc.edu'
  when 'kcoakley'
    'kcoakley@sdsc.edu'
  when 'jeff'
    'jeff@sdsc.edu'
  when 'dferbert'
    'dferbert@sdsc.edu'
  when 'colby'
    'colby@sdsc.edu'
  when 'tmcnew'
    'tmcnew@sdsc.edu'
  when 'jfilliez'
    'jfilliez@sdsc.edu'
  when 'twalkerb'
    'twalkerb@sdsc.edu'
  when 'cloud-explorer', 'cloud-contacts'
    'ssps@sdsc.edu'
  else
    puts "Don't know how to handle user: #{user}"
    exit
  end
end

def lock_users(users)
  users.each do |email|
    u = User.find_by_email(email)
    u.lock_access!
  end
end

def importCloudAccounts
  skip = 4305
  hosts = YAML.load(%x(#{$old_shiv} listhost))
  count = 0
  hosts.each do |h|
    count += 1
    break if count > $limit && $limit > 0
    next if h.nil? || count < skip
    next unless /^cloud:storage:account/ =~ h

    yml = YAML.load(%x(#{$old_shiv} show "^#{h}$"))
    account = CloudAccount.new
    account.typer = 'cloud_account'
    yml.inspect
    yml.each_key do |accountName|

      if !accountName.empty? && yml[accountName].has_key?("traits")
        yml[accountName]['traits'].each do |name, value|
          #puts "#{name} = #{value}"
          case name
          when 'start_date'
            account.created_at = value
          when 'account_name'
            account.name = value
          when 'lapse_level'
            account.lapse_level = value
          when 'lapse_date'
            account.lapse_date = value
          when 'customer_type'
            account.customer_type = value
          when 'charge_index'
            account.charge_index = value
          when 'purge_date'
            account.purge_date = value
          when 'retired_date'
            account.retired_date = value
          when 'organization'
            account.organization = value
          when 'billing_account'
            account.billing_account = value
          when 'billing_fund'
            account.billing_fund = value
          when 'billing_object_code'
            account.billing_object_code = value
          when 'billing_sub'
            account.billing_sub = value
          when /^cloud:storage:account:*/, 'type', 'id', 'billing_exempt'
            #noop
          else
            puts "Not sure what to do with #{accountName} -> #{name} = #{value}"
            exit
          end
        end
      end

      if !accountName.empty? && yml[accountName].has_key?('tags')
        tags = []
        yml[accountName]['tags'].each do |tag|
          tags << tag
        end
        account.tag_list = tags.join(',')
      end


    end

    if !account.name.nil? && account.typer == 'cloud_account'
      puts "[#{count}] Saving : #{account.inspect}"
      account.save
      account.typer = nil
      account.save
    else
      puts "[#{count}] Skipping #{account.name}"
    end

    notes = %x(#{$old_shiv} note "#{h}")
    @note_arr = []

    notes.each_line do |line|
      if /^([0-9]){4}\-([0-9]){2}\-([0-9]){2}/ =~ line
        @note_arr << OpenStruct.new
        @note_arr.last.created_at = line[/^(\d){4}.*UTC/]
        @note_arr.last.user = replace_user(line.split('UTC')[1].strip)
        @note_arr.last.comment = ''
      else
        @note_arr.last.comment = line.strip unless line.strip == 'Nothing noted.'
      end

    end

    @note_arr.each do |note|
      user = User.find_by_email(note.user)
      user_id = user.id unless user.nil?
      account.save
      account.comments.create(:comment => note.comment, :created_at => note.created_at, :user_id => user_id)
      account.save
    end
  end

end

def importContacts
  skip = 0
  contacts = YAML.load(%x(#{$old_shiv} listhost))
  count = 0
  contacts.each do |c|
    count += 1
    break if count > $limit && $limit > 0
    next if c.nil? || count < skip
    next unless /^[a-zA-Z0-9_\-]+@[a-zA-Z0-9_\-]+.[a-zA-Z]{3}/ =~ c

    yml = YAML.load(%x(#{$old_shiv} show "^#{c}$"))
    contact = Contact.new
    contact.typer = 'contact'
    yml.inspect
    yml.each_key do |contactName|

      if !contactName.empty? && yml[contactName].has_key?("traits")
        yml[contactName]['traits'].each do |name, value|
          #puts "#{name} = #{value}"
          case name
          when 'first_name'
            contact.first_name = value
          when 'last_name'
            contact.last_name = value
          when 'phone'
            contact.phone = value
          when 'email'
            contact.email = value.downcase
          when 'external_email'
            contact.external_email = value.downcase
          when 'notification_email'
            contact.notification_email = value.downcase
          when 'type', 'id'
            #noop
          else
            puts "Not sure what to do with #{contactName} -> #{name} = #{value}"
            exit
          end
        end
      end

      if !contactName.empty? && yml[contactName].has_key?('tags')
        tags = []
        yml[contactName]['tags'].each do |tag|
          tags << tag
        end
        contact.tag_list = tags.join(',')
      end


    end

    if !contact.email.nil? && contact.typer == 'contact'
      puts "[#{count}] Saving : #{contact.inspect}"
      contact.save
      contact.typer = nil
      contact.save
    else
      puts "[#{count}] Skipping #{contact.inspect}"
      puts c.inspect
    end

    notes = %x(#{$old_shiv} note "#{c}")
    @note_arr = []

    notes.each_line do |line|
      if /^([0-9]){4}\-([0-9]){2}\-([0-9]){2}/ =~ line
        @note_arr << OpenStruct.new
        @note_arr.last.created_at = line[/^(\d){4}.*UTC/]
        @note_arr.last.user = replace_user(line.split('UTC')[1].strip)
        @note_arr.last.comment = ''
      else
        @note_arr.last.comment = line.strip unless line.strip == 'Nothing noted.'
      end

    end

    @note_arr.each do |note|
      user = User.find_by_email(note.user)
      user_id = user.id unless user.nil?
      contact.save
      contact.comments.create(:comment => note.comment, :created_at => note.created_at, :user_id => user_id)
      contact.save
    end
  end

end

def importCloudUsers
  skip = 0
  users = YAML.load(%x(#{$old_shiv} listhost))
  count = 0
  users.each do |u|
    count += 1
    break if count > $limit && $limit > 0
    next if u.nil? || count < skip
    next unless /^cloud:storage:user/ =~ u

    yml = YAML.load(%x(#{$old_shiv} show "^#{u}$"))
    user = CloudUser.new

    # by default, pull the username from #{u}
    user.name = u.gsub('cloud:storage:user:','').split(':')[1]

    user.typer = 'cloud_user'
    yml.inspect
    yml.each_key do |username|

      if !username.empty? && yml[username].has_key?("traits")
        yml[username]['traits'].each do |name, value|
          #puts "#{name} = #{value}"
          case name
          when 'username'
            user.name = value
          when 'account_admin'
            user.admin = true
          when 'start_date'
            user.created_at = value
          when 'sla_accepted'
            user.sla_accept_date = value
          when 'request_ticket'
            user.request_ticket = value
          when 'type', 'id'
            #noop
          else
            puts "Not sure what to do with #{username} -> #{name} = #{value}"
            exit
          end
        end
      end

      if !username.empty? && yml[username].has_key?('tags')
        tags = []
        yml[username]['tags'].each do |tag|
          tags << tag
        end
        user.tag_list = tags.join(',')
      end


      if !username.empty? && yml[username].has_key?('links')
        yml[username]['links'].each do |link|
          if link[0] == 'contact'
            link[1].each do |email|
              puts "Searching for contact by email: #{email}"
              contact = Contact.find_by_email(email)
              puts contact.inspect
              user.contact_id = contact.id unless contact.nil?
            end
          end
        end
      end

    end

    if !user.name.nil? && user.typer == 'cloud_user'
      acc = CloudAccount.find_by_name(u.gsub('cloud:storage:user:','').split(':')[0])
      user.cloud_account_id = acc.id unless acc.nil?

      puts "[#{count}] Saving : #{user.inspect}"
      user.save
      user.typer = nil
      user.save
    else
      puts "[#{count}] Skipping #{user.inspect}"
      puts u.inspect
    end

    notes = %x(#{$old_shiv} note "#{u}")
    @note_arr = []

    notes.each_line do |line|
      if /^([0-9]){4}\-([0-9]){2}\-([0-9]){2}/ =~ line
        @note_arr << OpenStruct.new
        @note_arr.last.created_at = line[/^(\d){4}.*UTC/]
        @note_arr.last.user = replace_user(line.split('UTC')[1].strip)
        @note_arr.last.comment = ''
      else
        @note_arr.last.comment = line.strip unless line.strip == 'Nothing noted.'
      end

    end

    @note_arr.each do |note|
      us = User.find_by_email(note.user)
      user_id = us.id unless us.nil?
      user.save
      user.comments.create(:comment => note.comment, :created_at => note.created_at, :user_id => user_id)
      user.save
    end
  end

end


lock_users(['brianb@sdsc.edu', 'dougw@sdsc.edu'])

importBoxes
importHosts
importContacts
importCloudAccounts
importCloudUsers
