# by Tris, 17jul96 (v2)
# action added by fantomas 22Dec1997

# Updated to v4 (17 November 1998) by slennox <slenny@ozemail.com.au>
# About time someone updated this nice little script that more
# people should be using Smile
# - Updated for 1.3 bots (channel specific +o user no longer kicked)
# - Added options to set number of kicks in how many seconds
# and kick msg
# - Added option to ban as well as kick
#
# Fixed version (1 December 1998)
# - repeatban set to 1 was generating 'invalid command name' error.
# I'd forgotten to add 'fixbanmask' proc (stolen from subop*.tcl by
# MHT & YaZZ) Smile
#
# Updated to v4.1 (8 December 1998)
# - Got rid of the fixbanmask crap and changed ban type to an IP ban Smile

# Updated (25 November 2002) @/+ exempt
# - Now this script won't kick opped/voiced users. I added an op/voice exempt to this script
# originally made by Tris and modified by users listed above. (|am|) @ DALnet amit@amit.mu

# In how many seconds
set repeattime 300  
# Kick msg
set repeatmsg "Por favor, evite las Repeticiones en el canal."
# Also ban?
# Messages (can NOT use variables as $nick or $chan)
set repeatwarnmsg "Por favor, evite las Repeticiones en el canal."
set repeatkickmsg "Por favor, evite las Repeticiones en el canal."
# How long the ban should last (in minutes)
set repeatbantime 1

set repeatkick 3
set repeatban 4
set repeatmaxwarn 2

# Channel
set repeatchans "#cornudos"

# Don't edit below unless you know what you're doing
bind pubm - * repeat_pubm
bind ctcp - ACTION repeat_action
bind nick - * repeat_nick

proc repeat_pubm {nick uhost hand chan text} {
   if {[matchattr $nick mo|mo $chan] || [isop $nick $chan] || [isvoice $nick $chan] || [matchattr $nick o|o $chan]} {
      return 0
   }
   global repeat_last repeat_num repeatkick repeatmsg
  global repeatkick repeatban repeatwarnmsg repeatkickmsg repeatwarn repeatmaxwarn repeattime repeatbantime repeatwarntime
  global repeat_last repeat_num repeatminchars repeatchans  
   if [info exists repeat_last([set n [string tolower $nick]])] {
   if {[lsearch -exact [split [string tolower $repeatchans]] [string tolower $chan]] == -1} {return 0}
      if {[string compare [string tolower $repeat_last($n)] [string tolower $text]] == 0} {
      if {[incr repeat_num($n)] < ${repeatkick}} {
        incr repeatwarn($uhost)
        if {[expr $repeatwarn($uhost)-1] >= $repeatmaxwarn} {
		set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          putquick "MODE $chan +b $banmask"		
          putquick "KICK $chan $nick :$repeatkickmsg! - [count:kicks] -"
          unset repeatwarn($uhost)
          timer $repeattime [list putquick "MODE $chan -b $nick"]
          return
        }
        putquick "PRIVMSG $chan :1$nick $repeatwarnmsg 1(Primer Aviso)"
      } elseif {$repeat_num($n) == ${repeatkick}} {
        putquick "PRIVMSG $chan :1$nick $repeatkickmsg 1(Segundo Aviso)"
      } elseif {$repeat_num($n) >= ${repeatban}} {
		set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
        putquick "MODE $chan +b $banmask"		
        putquick "KICK $chan $nick :$repeatkickmsg - [count:kicks] -"
        timer $repeattime [list putquick "MODE $chan -b $nick"]
      }
      if {$repeat_num($n) >= ${repeatban}} {
        unset repeat_last($n)
        unset repeat_num($n)
      }
      return
    }
  }
  set repeat_num($n) 1
  set repeat_last($n) $text
}  

proc repeat_nick {nick uhost hand chan newnick} {
   if {[matchattr $nick mo|mo $chan] || [isop $nick $chan] || [isvoice $nick $chan] || [matchattr $nick o|o $chan]} {return 0}
   global repeat_last repeat_num
   catch {set repeat_last([set nn [string tolower $newnick]]) $repeat_last([set on [string tolower $nick]])}
   catch {unset repeat_last($on)}
   catch {set repeat_num($nn) $repeat_num($on)}
   catch {unset repeat_num($on)}
}

proc repeat_timr {} {
   global repeat_last repeattime
   catch {unset repeat_last}
   catch {unset repeat_num}
   utimer $repeattime repeat_timr
}

if ![regexp repeat_timr [utimers]] { # thanks to jaym
   utimer $repeattime repeat_timr
}

proc count:kicks {} { 
    set increment_count "contadorkicks.db" 
    if { ![file exists $increment_count] } { putlog "contadorkicks.db No existe.";return } 

    set open_text [open $increment_count "r"] 
    set KICKCOUNT [read -nonewline $open_text] 
    close $open_text 
    incr KICKCOUNT 

    set re_open_text [open $increment_count "w"] 
    puts $re_open_text $KICKCOUNT 
    close $re_open_text 

    return $KICKCOUNT 
}
putlog "repeat.tcl (@/+ exempt) by |am| originally made by Tris loaded"