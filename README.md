# Splunk User Groups

Simple rails app to allow users to check in at Splunk User Groups.

![Splunk User Group Check-in](https://raw.githubusercontent.com/himynamesdave/splunkusergroups/master/app/assets/images/screenshot_checkin.jpeg)

![Splunk User Group Check-in Stats](https://raw.githubusercontent.com/himynamesdave/splunkusergroups/master/app/assets/images/screenshot_stats.jpeg)

## To install locally

**Dependencies**

[Requires the Splunk Ruby SDK to be installed](http://dev.splunk.com/ruby).

**Splunk Indexer config**

[Add indexer location here](https://github.com/himynamesdave/splunkusergroups/blob/master/config/application.yml).

[Add indexer credentials here](https://github.com/himynamesdave/splunkusergroups/blob/master/config/secrets.yml).

Make sure port 8089 is open to send / recieve data.

You will also need a Splunk instance running the [Splunk User Group Manager App](https://github.com/himynamesdave/usergroupmgr_splunk_app). The admin app creates the Splunk Key Value Collections required to populate variables in app (i.e job roles listed for check-in).

**Slack config**

There is also an option for automated Slack invites to be sent out to users who consent. 

To configure this, [provide your Slack API key here](https://github.com/himynamesdave/splunkusergroups/blob/master/config/secrets.yml), and then [Slack team and channels to include them in by default here](https://github.com/himynamesdave/splunkusergroups/blob/master/config/application.yml).

**Google Analytics config**

You should also [add your GA key here](https://github.com/himynamesdave/splunkusergroups/blob/master/views/layouts/application.haml). 