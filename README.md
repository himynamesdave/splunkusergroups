# Splunk User Groups

Simple rails app to allow users to check in at Splunk User Groups.

![Splunk User Group Check-in Index](https://raw.githubusercontent.com/himynamesdave/splunkusergroups/master/app/assets/images/screenshot_index.jpeg)

![Splunk User Group Check-in](https://raw.githubusercontent.com/himynamesdave/splunkusergroups/master/app/assets/images/screenshot_checkin.jpeg)

![Splunk User Group Check-in Success](https://raw.githubusercontent.com/himynamesdave/splunkusergroups/master/app/assets/images/screenshot_success.jpeg)

## To install locally

[Requires the Splunk Ruby SDK to be installed](http://dev.splunk.com/ruby).

[Add indexer location here](https://github.com/himynamesdave/splunkusergroups/blob/master/app/models/concerns/splunk_service.rb).

[Add indexer credentials here](https://github.com/himynamesdave/splunkusergroups/blob/master/config/secrets.yml).

Make sure port 8089 is open to send / recieve data.

You will also need a Splunk instance running the [Splunk User Group Admin App](https://github.com/himynamesdave/usergroup_splunk_app). The admin app creates the Splunk Key Value Collections required to populate variables in app (i.e job roles listed for check-in).
