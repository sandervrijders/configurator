#!/bin/bash

PROJECT="distcloud.pristine.wall2.ilabt.iminds.be"

enroll () {
    CMD="enroll-to-dif $2 $3 $4 $5 1"
    ssh $1.$PROJECT "echo $CMD | sudo socat - UNIX:/usr/local/irati/var/run/ipcm-console.sock"
}

# r1n1 r1n2 r1n3 r1n4 r1b1 r2n1 r2n2 r2b1 r3n1 r3n2 r3n3 r3b1 br1 br2 br3 br4

#enroll name ipcp_id dif_name n_1_dif neighbor

#backbone
enroll br4 4 backbone 16 br2 1
enroll br2 4 backbone 17 br3 1
enroll br3 4 backbone 18 br1 1
enroll r3b1 3 backbone 15 br3 1
enroll r1b1 4 backbone 13 br4 1
enroll r2b1 4 backbone 14 br2 1

#cloud
enroll r3n2 3 cloud 9 r3n1 1
enroll r3n2 3 cloud 10 r3n3 1
enroll r3n3 3 cloud 11 r3n1 1
enroll r3n1 4 cloud 12 r3b1.cloud 1

enroll r2b1 5 cloud 8 r2n2 1
enroll r2b1 5 cloud 7 r2n1 1
enroll r2b1 5 cloud backbone r3b1.cloud 1

enroll r1n1 3 cloud 2 r1n2 1
enroll r1n1 3 cloud 3 r1n4 1
enroll r1n4 3 cloud 4 r1n3 1
enroll r1n2 3 cloud 6 r1b1.cloud 1
enroll r1n3 3 cloud 5 r1b1.cloud 1
enroll r1b1 5 cloud backbone r2b1.cloud 1
