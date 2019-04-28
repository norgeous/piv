# piv

piv tells you the hardware version of your pi.

## Install
```sh
git clone https://github.com/norgeous/piv.git
bash ./piv/install.sh
rm -r piv/
```

## Usage
* Basic
```sh
piv
```
example output: `3B 1.2`

* Extended
```sh
piv -e
```
example output: `3B 1.2 1GB (Mfg by Sony) Q1 2016`

## How
piv reads the hardware revision from `/proc/cpuinfo` and checks it against a local cached copy of the table in https://elinux.org/RPi_HardwareHistory
