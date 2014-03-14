# Description

Project demo for Take-two interactive 

## VM description
 
 - OS: CentOS 6
 - virtualbox vm: 4.1

## Howto

-- Setup --
-  clone this repository: git clone git@github.com:AndrewSimon/take2-vagrant
-  cd to the repo directory: cd take2-vagrant
-  set vagrant home to current directory: export VAGRANT_HOME=`pwd`

-- Create CentOS box --
    vagrant up

-- Check apache is up on your desired ports
	ssh -X root@localhost 
	wget http://localhost -O -
	wget http://localhost:81 -O -

-- Shut it down
    vagrant destroy

## Copyright and license

Copyright 2014, Andrew Simon (asimon@asimon.net)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
