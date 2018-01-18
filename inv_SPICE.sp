$example HSPICE setup file

$transistor model
.include "/home/cad/kits/IBM_CMRF8SF-LM013/IBM_PDK/cmrf8sf/V1.2.0.0LM/HSPICE/models/model013.lib_inc"
.include invlvs.sp

.global vdd! gnd!
.option post runlvl=5

xi in out inv2

vdd vdd! gnd! 1.2v
vin in gnd! pwl(0ns 1.2v 1ns 1.2v 1.01ns 1.08v 1.068ns 0.12v 1.09ns 0v 6ns 0v 6.01ns 0.12v 6.09ns 1.2v 12ns 1.2v)
$ 1.01ns 1.08v 1.07ns 0.12v 6.085ns 1.08v
cout out gnd! 120f

.tr 10ps 12ns
$example of parameter sweep, replace numeric value W of pfet with WP in invlvs.sp
.tr 3ps 12ns sweep WP 3.06u 10.06u .5u

$.measure a
.measure tran trise trig v(in) val=0.6v fall=1 targ v(out) val=0.6v rise=1 $measure tlh at 0.6v
.measure tran tfall trig v(in) val=0.6v rise=1 targ v(out) val=0.6v fall=1 $measure tpl at 0.6v
.measure tavg param = '(trise+tfall)/2' $calculate average delay
.measure tdiff param='abs(trise-tfall)' $calculate delay difference
.measure delay param='max(trise,tfall)' $calculate worst case delay

.measure tran iavg avg i(vdd) from=0 to=10n $average current in one clock cycle
.measure energy param='abs(1.2*iavg*10n)' $calculate energy in one clock cycle
.measure edp1 param='abs(delay*energy)'

.end