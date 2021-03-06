require 'optparse'
require './lib/azassu'
require 'zabbix_send'

option = {}
OptionParser.new do |opt|
  opt.on('-a', '--application_id=VALUE')     { |v| option[:application_id] = v }
  opt.on('-c', '--client_secret=VALUE')      { |v| option[:client_secret] = v }
  opt.on('-m', '--resource_name=VALUE')      { |v| option[:resource_name] = v }
  opt.on('-y', '--resource_type=VALUE')      { |v| option[:resource_type] = v }
  opt.on('-s', '--subscription_id=VALUE')    { |v| option[:subscription_id] = v }
  opt.on('-t', '--tenant_id=VALUE')          { |v| option[:tenant_id] = v }
  opt.on('-l', '--filter_type=VALUE')        { |v| option[:filter_type] = v }
  opt.on('-g', '--aggregation_type=VALUE')   { |v| option[:aggregation_type] = v }
  opt.on('-z', '--zabbix_host=VALUE')        { |v| option[:zabbix_host] = v }
  opt.on('-k', '--trapper_key=VALUE')        { |v| option[:trapper_key] = v }
  opt.parse!(ARGV)
end

[:application_id, :client_secret, :subscription_id, :resource_type, :resource_name, :zabbix_host].each do |k|
  if option[k].nil? || option[k].empty?
    puts 'Option must be specified... Type ruby main.rb -h'
    exit
  end
end

# Get API Token
token = Azassu::Token.get(option[:application_id], option[:client_secret], option[:tenant_id])

option[:filter_type] = 'Percentage CPU' unless option[:filter_type]

option[:aggregation_type] = 'Average' unless option[:aggregation_type]

unless option[:filter]
  option[:filter] = Azassu::Metrics.generate_5mins_filter(option[:filter_type], option[:aggregation_type])
end

# Get Metrics (Easiest Way)
value = 0
metrics = Azassu::Metrics.get_by_name(token, option[:subscription_id], option[:resource_name], option[:resource_type], option[:filter])
metrics.each do |v|
  next if v.keys.count < 2
  value = v[v.keys.last]
  break
end

option[:trapper_key] = option[:filter_type].gsub(' ', '_').gsub('/', '_') unless option[:trapper_key]

# Send data to Zabbix
sender = ZabbixSend::Sender.new
sender.send(option[:zabbix_host], option[:resource_name].gsub('/', '_'), option[:trapper_key], value)
