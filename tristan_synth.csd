<CsoundSynthesizer>
<CsOptions>
-odac

</CsOptions>


<CsInstruments>

sr = 44100
;kr = 4410
ksmps = 32
nchnls = 1

;accumulators for future reverb or something
gaout init 0
gaout1 init 0
;******************************************
instr 1
kndx line 0,p3,4
     ftmorf kndx,25,26
     
asig     oscil     2000, p4, p5
aEnv     adsr      1,1,1,.75
out     asig*aEnv
gaout = gaout + asig*aEnv
endin
;******************************************

;******************************************
instr 3
kp = p5
if (kp == 0) then 	
  kamp expon 1600, p3, 1 
elseif (kp == 1) then
  kamp line 500, p3, 1600
elseif (kp == 2) then
  kamp line 1600,p3,500
elseif (kp == 3) then
  kamp = 1600
elseif (kp == 4) then
  kamp line 1, p3, 1600
endif

kamp = kamp *.7

asig     oscil     kamp, p4, 1
aEnv     adsr      1,.5,.5,.75
out     asig*aEnv
gaout1 = gaout1 + asig*aEnv
endin
;******************************************

;******************************************
instr 4   ;chews up and drones cello sample files from http://www.philharmonia.co.uk/

iolaps  = 10
igrsize = 0.4
ifreq   = 6
ips     = .1
SFile = p6

istr = p4  /* timescale */
ipitch = p5 /* pitchscale */

a1 diskgrain SFile, 2700, ifreq, ipitch, igrsize, ips*istr, 7, iolaps
aEnv adsr 1,2,1,1   
;a1 comb a1, 3, .5   
   outs   a1*aEnv, a1*aEnv

endin

;******************************************

;******************************************
instr 5
endin 

;******************************************

;******************************************
instr 99 


a2	nreverb	gaout, 3, .3
	out	a2*1.3		;volume of reverb		
	 
gaout = 0
 
endin
;******************************************

;******************************************
instr 98 


a2	nreverb	gaout1, 10, 1
	out	a2*1.3		;volume of reverb		
	 
gaout1 = 0
 
endin
;******************************************

</CsInstruments>
<CsScore>
#include "morph_pit.inc"
#include "sample_bank.inc"

f1  0 1024   10 1           0   1   0
f15 0 1024   10 1           0   0   0.1
f16 0 1024   10 1            .2  .2 0 
f7  0 8192   20 2           1
f2  0 1024   9  0.5         1   0

;a 0 0 77


m 1
;              freq
i1    0      2  110    1
i1    1      3  175    1
i1    3      2  175    1
i1    4      3  165    1

;                      gliss/pitch      stretch  note   
;*************************************************************0
i1    6      5  156    1
i1    9      5  156    1

i3    06     2  415    1
i3    07     3  416    3 
i3    09     2  440    3 

i4    5      6               1           1     "gc.wav"  
i4    5      6               1           1     "fc.wav"
;*************************************************************1
i1    9      5  147    1
i1    13     2  145    1
i1    13     2  146    1

i3    10     2  466    3 
i3    11     4  494    0 

i4    10     6               1           1     "fc.wav"
i4    10     6               0.9         1     "fc.wav"
;*************************************************************2
;i99   0 20
;i98   0 20

;*************************************************************3

i1    19     2  124    1
;*************************************************************4
i1    20     4  207    26
i1    23     3  196    1
;*************************************************************5
i1    25     3  185    1
i3    27     3  184    3

i3    25     2  466    1 
i3    26     3  465    3 
i3    28     2  523    3 

i4    25     4                1           1    "fshc.wav"
i4    25     4                1           1    "dc.wav"
;*************************************************************6
i3    29     4  175    3
i3    32     2  174    3

i3    29     2  554    3 
i3    30     2  587    0

i4    28     4               1           1     "gc.wav"
i4    28     4               1           1     "bc.wav"
;************************************************************7





;************************************************************8
i1    36     2  147    1
i1    37     4  247    26
i1    40     3  247    1
;************************************************************9
i1    42     3  233    1
i1    44     2  231    1
i1    45     3  220    1
;                      gliss/pitch      stretch  note  
;***********************************************************10
i1    46     3  208    1
i1    48     4  208    26

i3    46     2  587    4
i3    48     2  587    4
i3    49     2  622    4
i3    50     3  659    0

i4    46     3               1           1    "fhc.wav" ;treble (high) f, cello
i4    48     2               1           1    "fhc.wav"
i4    49     2               1           1    "ehc.wav"
i4    46     6               1           1    "chc.wav"
;***********************************************************11
i1    50     3  220    1
i1    52     3  220    1

i3    50     2  698    4
i3    51     3  740    4
i3    53     3  740    0

i4    50     3               1           1    "dcshh.wav"
i4    52     2               1           1    .
i4    50     3               1           1    "bch.wav"
i4    52     2               1           1    .
;**********************************************************12
i4    53     7               1           1    "cchh.wav"
i4    53     4               1           1    "fchh.wav"
i4    53     2               1           1    "dcshhh.wav"
;**********************************************************13
i3    54     7  831    1 ;high g#
i3    54     3  1175   1 ;high d
i3    56     2  1175   4
i3    57     2  1245   4
i3    58     2  1319   0

i4    54     7               1           3    "cchh.wav"
i4    54     4               1           3    "fchh.wav"
i4    57     2               1           3    "echh.wav"
;**********************************************************14
i1    58     6  880    26

i1    58     2  1397   1
i1    59     6  1480   26


;i5    58     3               1         1     "dcshhh.wav"   4
;i5    60     2               1         1     "dcshhh.wav"   3
;i5    58     3               1         1     "bchh.wav"     3
;i5    60     2               1         1     "bchh.wav"     1

;**********************************************************15
i1    63     2  170    15
i1    64     3  185    15
i1    66     3  185    16

i3    64     2  340    1
i3    65     3  370    4
i3    67     2  370    0
i3    64     2  680    1
i3    65     3  740    4
i3    68     3  740    0
;**********************************************************16
i1    70     2  340    15
i1    72     3  370    16
i1    74     2  370    16

i3    70     2  680    1
i3    72     3  740    4
i3    74     2  740    0
i3    70.5   2  1352   1
i3    72.5   3  1480   4
i3    74.5   4  1480   0
;***********************************************************17
i1    77     2  175    1
i1    78     3  185    1
i1    80     2  185    1
i1    81     2  196    1
i1    82     2  208    1

i3    77     4  104    4
i3    80     4  147    0

i4    77     3               1       1     "dc3.wav"
i4    77     3               1       1     "ec2.wav"

i4    79     4               1       1     "bc3.wav"
i4    79     4               1       1     "ec3.wav"
;**********************************************************18
i1    82     4 247     1
i1    83     2 220     1

i3    82     4 131     4

i4    82     4               1       1     "fshc3.wav"
i4    82     3               1       1     "ac3.wav"
i4    85     4               1       1     "fshc3.wav"
i4    84     2               1       1     "ac3.wav"
i4    85     3               1       1     "bc3.wav"
i4    87     1               1       1     "cc3.wav"
;*********************************************************19


  



s




e
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>1520</x>
 <y>565</y>
 <width>400</width>
 <height>236</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
