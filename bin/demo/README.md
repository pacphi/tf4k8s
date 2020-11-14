# tf4k8s Demo

This script will serve as a guided tour through tf4k8s capabilities. 

## Preparation

Make a copy of the config sample and fill it out for your own purposes with your own credentials.

```
cp demo-config.sh.sample demo-config.sh
```

Next, we'll launch an Ubuntu virtual machine so we can simulate what the experience might be like to go from "zero-to-hero".

### Download and install Multipass

* [Windows](https://multipass.run/download/windows)
* [MacOS](https://multipass.run/download/macos)
* [Linux](https://snapcraft.io/multipass)

### Launch a virtual machine

```
multipass launch --name tf4k8s --cpus 4 --mem 8G --disk 30G 20.04
```

### Shell into the VM

```
multipass shell tf4k8s
```

## Execution

Make sure you're in the bin/demo directory and execute

```
./launch-demo.sh
```

On occasion you'll have to press the Enter key to proceed, but this is largely a hands-off experience.
