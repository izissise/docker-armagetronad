#!/bin/bash

loc="/home/armagetronad"
tron="${loc}/bin/armagetronad-dedicated"
userdatadir="${loc}"
vardir="${userdatadir}/var"
configdir="${userdatadir}/settings"
userconfigdir="${userdatadir}/settings/settings"
resourcedir="${userdatadir}/resource"

while true;
do
        $tron --resourcedir $resourcedir --autoresourcedir $resourcedir --userconfigdir $userconfigdir --configdir $configdir --vardir $vardir --datadir $userdatadir"/" --userdatadir $userdatadir"/"
done
