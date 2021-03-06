#!/bin/bash
[[ $EUID -ne 0 ]] && echo "You must be running as user root." && exit 1

mkdir -p "/usr/share/piv"
cat <<'EOF' > /usr/share/piv/piv.sh
#!/bin/bash

# https://elinux.org/RPi_HardwareHistory
VERSION_CSV="
Revision,Release Date,Model,PCB Revision,Memory,Notes
Beta,Q1 2012,B (Beta),?,256MB,Beta Board
0002,Q1 2012,B,1.0,256MB
0003,Q3 2012,B (ECN0001),1.0,256MB,Fuses mod and D14 removed
0004,Q3 2012,B,2.0,256MB,(Mfg by Sony)
0005,Q4 2012,B,2.0,256MB,(Mfg by Qisda)
0006,Q4 2012,B,2.0,256MB,(Mfg by Egoman)
0007,Q1 2013,A,2.0,256MB,(Mfg by Egoman)
0008,Q1 2013,A,2.0,256MB,(Mfg by Sony)
0009,Q1 2013,A,2.0,256MB,(Mfg by Qisda)
000d,Q4 2012,B,2.0,512MB,(Mfg by Egoman)
000e,Q4 2012,B,2.0,512MB,(Mfg by Sony)
000f,Q4 2012,B,2.0,512MB,(Mfg by Qisda)
0010,Q3 2014,B+,1.0,512MB,(Mfg by Sony)
0011,Q2 2014,Compute Module 1,1.0,512MB,(Mfg by Sony)
0012,Q4 2014,A+,1.1,256MB,(Mfg by Sony)
0013,Q1 2015,B+,1.2,512MB,(Mfg by Embest)
0014,Q2 2014,Compute Module 1,1.0,512MB,(Mfg by Embest)
0015,?,A+,1.1,256MB/512MB,(Mfg by Embest)
a01040,Unknown,2B,1.0,1GB,(Mfg by Sony)
a01041,Q1 2015,2B,1.1,1GB,(Mfg by Sony)
a21041,Q1 2015,2B,1.1,1GB,(Mfg by Embest)
a22042,Q3 2016,2B (with BCM2837),1.2,1GB,(Mfg by Embest)
900021,Q3 2016,A+,1.1,512MB,(Mfg by Sony)
900032,Q2 2016?,B+,1.2,512MB,(Mfg by Sony)
900092,Q4 2015,Zero,1.2,512MB,(Mfg by Sony)
900093,Q2 2016,Zero,1.3,512MB,(Mfg by Sony)
920093,Q4 2016?,Zero,1.3,512MB,(Mfg by Embest)
9000c1,Q1 2017,Zero W,1.1,512MB,(Mfg by Sony)
a02082,Q1 2016,3B,1.2,1GB,(Mfg by Sony)
a020a0,Q1 2017,Compute Module 3 (and CM3 Lite),1.0,1GB,(Mfg by Sony)
a22082,Q1 2016,3B,1.2,1GB,(Mfg by Embest)
a32082,Q4 2016,3B,1.2,1GB,(Mfg by Sony Japan)
a020d3,Q1 2018,3B+,1.3,1GB,(Mfg by Sony)
9020e0,Q4 2018,3A+,1.0,512MB,(Mfg by Sony)
"

THIS_VER=$(cat "/proc/cpuinfo" | grep "Revision" | cut -d" " -f2)
THIS_INFOLINE=$(echo "$VERSION_CSV" | grep "$THIS_VER")

THIS_DATE=$(echo "$THIS_INFOLINE" | cut -d"," -f2 )
THIS_MODEL=$(echo "$THIS_INFOLINE" | cut -d"," -f3 )
THIS_PCBREV=$(echo "$THIS_INFOLINE" | cut -d"," -f4 )
THIS_MEMORY=$(echo "$THIS_INFOLINE" | cut -d"," -f5 )
THIS_NOTES=$(echo "$THIS_INFOLINE" | cut -d"," -f6 )

echo -n "$THIS_MODEL $THIS_PCBREV"
[ "$1" == "-e" ] && echo -n " $THIS_MEMORY $THIS_NOTES $THIS_DATE"
echo
EOF
chmod a+x "/usr/share/piv/piv.sh"
[ ! -L "/usr/bin/piv" ] && ln -s "/usr/share/piv/piv.sh" "/usr/bin/piv"

# uninstall
# rm -r "/usr/share/piv"
# rm "/usr/bin/piv"
