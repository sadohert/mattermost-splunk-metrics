plugin_name = mattermost-splunk-metrics

build_dir:
	mkdir -p dist

package: build_dir
	COPY_EXTENDED_ATTRIBUTES_DISABLE=true COPYFILE_DISABLE=true  tar czf ./dist/$(plugin_name).tar.gz --exclude '\.*' --exclude "$(plugin_name)/local" --exclude '$(plugin_name)/metadata/local.meta'  $(plugin_name)	

# To use the validate target, install a Python venv in this directory, and install splunk-appinspect within it
# http://dev.splunk.com/view/appinspect/SP-CAAAFAW#installinvirtualenv
validate: package
	make package
	bash -c 'source venv/bin/activate && splunk-appinspect inspect ./dist/$(plugin_name).tar.gz'