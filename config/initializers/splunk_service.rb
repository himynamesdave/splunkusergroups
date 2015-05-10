# Check config/application.yml and config/secrets.yml files to set password/username/host etc.
SplunkService = Splunk::connect(
  :username => Rails.application.secrets.splunk_username, 
  :password => Rails.application.secrets.splunk_password, 
  host: Figaro.env.splunk_host, 
  namespace: Splunk::AppNamespace.new(Figaro.env.usergroup_app_name)
)

SplunkReceiverService = Splunk::connect(
  :username => Rails.application.secrets.splunk_username, 
  :password => Rails.application.secrets.splunk_password, 
  host: Figaro.env.splunk_host
) 