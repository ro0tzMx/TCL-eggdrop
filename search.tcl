#################################################################################################### 
putlog "TextSearcher v0.2 - 1st Offcial Release by IsP (q_lander@hotmail.com)" 
# 
# This script simply searches a txt file (or text files) for search criteria specified via pub 
# or msg commands. It Lets you search within a text file for key words using case insensitive 
# trigger commands. 
# 
# Test on eggdrop v1.6.X.....use at own risk ;) 
# 
# This script was originally made from another script for 1Real by y0manda, 
#    rewritten from ground up by IsP@Underent.org 
# 
# TODO: 
# - You tell me? 
# 
# v0.1 - 1st scripted 
# v0.2 - Fixed the counter to display the correct count! 
#      - Minor bug fix with proc $args - opps, was a mistake, honest ;P 
# 
#################################################################################################### 

#Where are the data files? (Use "{file location1} {file location2} {file location 3} {etc...}") 
set cd_release "/home/protect/cornudos/scripts/BlackTools/FILES/Eggdrop.extra.txt" 

#Which channels do I check for the command? 
set rlschans "#cornudos" 

#Max number of outputs? 
set rlsmaxsearch 10 

#What's the public trigger? 
set cmdsearch "!search" 

#What Users are allowed to use this trigger/command? (Leave blank for anyone) 
set rlsflag "nh" 

#Set your inital tag info here 
set rlsinfo "12\[BT\]1" 

########## DO NOT EDIT BELOW ########## 
if {$rlsflag == ""} {set rlsflag "-"} 
bind msg $rlsflag $cmdsearch rlssearchpub 
proc rlssearchpub {nick uhost handle arg} { 
   global rlschans 
   set valch 0 
   foreach ch [split $rlschans] {if {$chan == $ch} {set valch 1}} 
   if {$valch == 0} {return} 
   rlslocate $nick $uhost $handle "PRIVMSG" "$arg" 
} 

bind msg $rlsflag $cmdsearch rlssearchmsg 
proc rlssearchmsg {nick uhost handle arg} { 
   global rlschans 
   set valch 0 
   foreach ch [split $rlschans] {if {[botonchan $ch]} {if {[onchan $nick $ch]} {set valch 1}}} 
   if {$valch == 0} {return} 
   rlslocate $nick $uhost $handle "PRIVMSG" "$arg" 
} 

proc rlslocate {nick uhost handle type arg} { 
    global rlsmaxsearch cd_release rlsinfo 
    if {$arg == ""} {putquick "$type $nick :Syntax: $cmdsearch <search string>" ;return 0} 
    regsub -all -- " " ${arg} "*" rlsarg 
    putquick "$type $nick : $rlsinfo 1Buscando12..." 
    set totrlsfound 0 
    set alltext "" 
    foreach database $cd_release { 

        set line 0 

        set rlsfile [open $database r] 
        while {![eof $rlsfile]} { 

         incr line 

         set rlsline [gets $rlsfile] 

         if {[string match -nocase "*$rlsarg*" $rlsline]} { 
            incr totrlsfound 1 
  
            lappend alltext "\[$line\] $rlsline" 

         } 
        } 
        close $rlsfile 
    } 
    if {$alltext != ""} { 

      set cnt 0 
      foreach allline [lreverse $alltext] { 

         incr cnt 
         if {$cnt > $rlsmaxsearch} {  break  } 

         putquick "$type $nick : $rlsinfo \002Resultado:\002 $allline" 
      } 
    } 
    if {$totrlsfound > $rlsmaxsearch} {putquick "$type $nick :$rlsinfo Hay más de12 $rlsmaxsearch 1coincidencias. Por favor sé más específico."} 
    putquick "$type $nick : $rlsinfo Hubo un Total de12 $totrlsfound 1Coincidencias." 
} 
