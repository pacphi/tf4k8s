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

Last, and before executing the demo "for realz", you will need to `git clone` this repo from inside the `multipass shell`, change directories into the `bom` directory, then execute the `setup-linux.sh` script.  This will install all the required libraries and CLIs in advance so the demo isn't burdened each time by doing so.  Be sure to clean up your tracks by deleting cloned directory once completed.

## Execution

Make sure you're in the [bin/demo](https://github.com/pacphi/tf4k8s/tree/master/bin/demo) directory and execute

```
./launch-demo.sh --dry-run
```

This will put the script in dry-run mode and not execute any of the embedded commands.

If you really want to launch the script, execute

```
./launch-demo.sh --run
```

On occasion you'll have to press the Enter key to proceed, but this is largely a hands-off experience.

