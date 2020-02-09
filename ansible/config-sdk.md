# sdkman usage

## install sdk

curl -s "https://get.sdkman.io" | bash

## view pkgs

sdk list java
sdk current
sdk current java

## install pkgs

sdk install java 11.0.6.hs-adpt
sdk install java 8.0.242.hs-adpt

sdk install maven
sdk install ant
sdk install gradle

## manage status

sdk default java 11.0.6.hs-adpt

sdk offline disable
sdk offline enable
