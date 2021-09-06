RYKit is the internal framework for iOS client.
Written by Swift 

Note: 
# install 


`
source 'http://192.168.1.111:8082/gitlab/marc/RYKit'
platform :ios,"10.0"
use_frameworks!
target "YouthBomb" do 
	pod 'RYKit'
	

end
`


If occured the error like that "the directory issue"
Please enter the file folder to delete "Support " and "Sources" folders directly and then run 'pod install'
All will be okay.

Sometimes when you pod push, it always appeared the error like that " [iOS] unknown: Encountered an unknown error (783: unexpected token at '') during validation.

Analyzed 1 podspec."

#Solutions as below

1 ,Step 1: run the command order like that 
'sudo rm -rf ~/.cocoapods/repos'

2, add your repo to pod
'pod repo add RYKit 'http://192.168.1.111:8082/gitlab/marc/RYKit'


3, step 3:
'pod repo push RYKit RYKit.podspec --allow-warnings'