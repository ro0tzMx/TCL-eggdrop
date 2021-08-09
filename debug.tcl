# exec tclsh "$0" ${1+"$@"}
# debug.1.0.1.tcl
# arfer <arfer.minute@gmail.com>
# dalnet #BogOff

# ***************************************************************************************************************************** #
# ********** OPERATION ******************************************************************************************************** #

# debug.tcl uses changes to the existing global namespace tcl variable errorInfo to output, to a preconfigured irc bot ..
# .. channel, a full trace on any errors as and when they occur, emanating from any tcl script loaded on the bot

# this script is expected to profer some improvement on simply using .set errorInfo in the partyline in that it should ..
# .. output a trace on consecutive errors and not just the last one to have occured

# each tcl error will generally write to the variable errorInfo several times as the error is unwound. this script ..
# .. intelligently isolates the last such variable change per any single error which then contains the full trace

# it provides more information than the minimal tcl error that is displayed in the partyline by default and, as such, is ..
# .. primarily intended as a tool to aid script authors in determining the root cause of errors

# this script may also prove useful in allowing users to more completely report errors to their respective script authors

# *************** #
# *** WARNING *** #
# *************** #

# this script will output to the preconfigured irc channel every error from every tcl script loaded on your bot and hence, ..
# .. though unlikely, could potentialy flood channel services if many such errors occur. no attempt has been made within this ..
# .. script to negate such a flood

# ***************************************************************************************************************************** #
# ********** LICENCE ********************************************************************************************************** #

# this program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License ..
# .. as published by the Free Software Foundation; either version 2 of the license, or (at your option) any later version

# this program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty ..
# .. of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details

# if you did not receive a copy of the GNU General Public License along with this program write to the Free Software ..
# .. Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

# ***************************************************************************************************************************** #
# ********** DEPENDENCIES ***************************************************************************************************** #

# this script requires eggdrop/windrop version 1.6.17 or later
# this script requires tcl version 8.4 or later

# this script was specifically designed for Eggdrop/Windrop on DalNet IRC network, it has not been tested and may or may not ..
# .. work on other networks

# ***************************************************************************************************************************** #
# ********** INSTALLATION ***************************************************************************************************** #

# 1. configure debug.1.0.1.tcl in a suitable text editor - see configuration section below
# 2. create the directory scripts/debug if it doesn't already exist
# 3. place the configured debug.1.0.1.tcl in the bot's scripts/debug subdirectory
# 4. add a line to the end of the bot's .conf file 'source scripts/debug/debug.1.0.1.tcl'
# 5. RESTART the bot (NOT rehash)

# once the bot is back online you might consider testing the script by deliberately creating an error, for example, if tcl and ..
# .. set commands are enabled in the .conf, try using .set varName in the patyline where the variable varName does not exist

# editpad lite is recommended as a suitable text editor for configuring this script and is freely available via download from ..
# .. http://www.editpadpro.com/editpadlite.html

# ***************************************************************************************************************************** #
# ********** CHANGELOG ******************************************************************************************************** #

# 1.0.0 [12/11/07] [413 lines]
# beta code

# 1.0.1 [29/11/07] [425 lines]
# fixed error (no output) if trace requires multiple irc lines
# used 400 chars per line (OK for Dalnet, no idea for other networks)

# ***************************************************************************************************************************** #
# ********** SYNTAX *********************************************************************************************************** #

# assuming the default trigger "." - see configuration section below

# arguments inside <here> are required
# arguments inside ?here? are optional

# .debug ?boolean? --> displays current status of debugging or, if the boolean argument is supplied, switches debugging on/off

# ***************************************************************************************************************************** #
# ********** CONFIGURATION **************************************************************************************************** #

# set here the single character command trigger
# ensure that it is set such that it does not interfere with similar commands on this or other bots in the same channel(s)
# allowed values are as follows (the existing settings are recommended)
# , = comma
# . = period
# ! = exclamation mark
# $ = dollar sign
# & = ampersand
# - = hyphen
# ? = question mark
# ~ = tilde
# ; = semi-colon
# : = colon
# ' = apostrophe
# % = percent
# ^ = caret
# * = asterisk
set vDebugTrigger "."

# set here the user status required to use the command(s) in this script based on global and channel bot flags
# note that a setting of 9 means that the user's handle must exist in the configuration file's 'set owner' variable
# allowed values are as follows (the existing settings are recommended)
# 1 = public (no bot access required)
# 2 = partyline (p|)
# 3 = channel or global operator (o|o)
# 4 = global operator (o|)
# 5 = channel or global master (m|m)
# 6 = global master (m|)
# 7 = channel or global owner (n|n)
# 8 = global owner (n|)
# 9 = permanent owner (handle must be listed in .conf 'set owner' variable)
set vDebugStatus(debug) 8

# set here the text colours used in the bot's responses
# settings are only valid where channel mode permits colour
# allowed values are as follows (the existing settings are recommended)
# 00 = white
# 01 = black
# 02 = blue
# 03 = green
# 04 = light red
# 05 = brown
# 06 = purple
# 07 = orange
# 08 = yellow
# 09 = light green
# 10 = cyan
# 11 = light cyan
# 12 = light blue
# 13 = pink
# 14 = grey
# 15 = light grey
set vDebugColor(arrow) 03
set vDebugColor(compliance) 10
set vDebugColor(dimmed) 14
set vDebugColor(errors) 04
set vDebugColor(debug) 12

# set here the single irc bot channel that this script will output error traces to, and the only channel in which public ..
# .. command(s) in this script can be used in
# you may consider registering a channel solely for the use of bot and owner such that any output from this script does not ..
# .. interupt normal irc chat, at least until you have determined that existing tcl errors are minimal
set vDebugChannel "#bt"

# set here if you wish to have debugging active by default when the bot first comes online, it can otherwise be switched ..
# .. on/off using a public command
# for 'debugging active' the setting can be any of the accepted boolean values 1, yes, true, on
# for 'debugging inactive' the setting can be any of the accepted boolean values 0, no, false, off
# no other values are permitted
set vDebugActive 1

# ***************************************************************************************************************************** #
# ********** CODE ************************************************************************************************************* #

# *********************************** #
# *** DO NOT EDIT BELOW THIS LINE *** #
# *********************************** #

# ---------- FAILSAFES --------------------------------------------------------------------------------------------------- #

if {![regexp {^[-,.!$&?~;:'%^*]{1}$} $vDebugTrigger]} {
  die "configuration error in debug.tcl - illegal command trigger character"
}

foreach status [array names vDebugStatus] {
  if {![string is integer -strict $vDebugStatus($status)]} {
    die "configuration error in debug.tcl - illegal user status value (not an integer)"
  } else {
    if {($vDebugStatus($status) < 1) || ($vDebugStatus($status) > 9)} {
      die "configuration error in debug.tcl - illegal user status value (out of permitted range)"
    }
  }
}

foreach color [array names vDebugColor] {
  if {![string is integer -strict $vDebugColor($color)]} {
    die "configuration error in debug.tcl - illegal text color value (not an integer)"
  } else {
    if {($vDebugColor($color) < 0) || ($vDebugColor($color) > 15)} {
      die "configuration error in debug.tcl - illegal text colour value (out of permitted range)"
    }
  }
}

if {![regexp {^#.+$} $vDebugChannel]} {
  die "configuration error in debug.tcl - illegal output channel name"
}

if {![string is boolean -strict $vDebugActive]} {
  die "configuration error in debug.tcl - illegal debug active variable (not boolean)"
}

# ---------- INITIALISE -------------------------------------------------------------------------------------------------- #

set vDebugVersion 1.0.1

proc pDebugTrigger {} {
  global vDebugTrigger
  return $vDebugTrigger
}

array set vDebugFlag {
  2 p|
  3 o|o
  4 o|
  5 m|m
  6 m|
  7 n|n
  8 n|
}

array set vDebugName {
  2 "partyline"
  3 "channel operator"
  4 "global operator"
  5 "channel master"
  6 "global master"
  7 "channel owner"
  8 "global owner"
}

set vDebugCount 0

# ---------- BINDS ------------------------------------------------------------------------------------------------------- #

bind PUB - [pDebugTrigger]home pDebugPubDebug

# ---------- PROCS ------------------------------------------------------------------------------------------------------- #

proc pDebugCatch args {
  global errorInfo
  global vDebugActive
  global vDebugChannel
  global vDebugCount
  global vDebugPrior
  set current [regsub -all -- {\n|\s+} $errorInfo { }]
  if {[info exists vDebugPrior]} {
    if {[string first $vDebugPrior $current] != -1} {
      incr vDebugCount
      foreach item [utimers] {
        if {[string first pDebugDebug [join [lindex $item 1]]] != -1} {
          killutimer [join [lindex $item 2]]
        }
      }
    } else {
      if {$vDebugCount != 0} {
        set vDebugCount 0
        pDebugDebug 001 0 0 0 0 $vDebugChannel $vDebugPrior 0 0 0 0 0
      }
    }
  }
  set vDebugPrior $current
  utimer 2 [list pDebugDebug 001 0 0 0 0 $vDebugChannel $current 0 0 0 0 0]
  return 0
}

proc pDebugColor {chan type number} {
  global vDebugColor
  if {[regexp -- {^\+[a-zA-Z]*c} [getchanmode $chan]]} {
    return ""
  } else {
    switch -- $number {
      1 {
        switch -- $type {
          0 {if {[info exists vDebugColor(errors)]} {return "\003$vDebugColor(errors)"} else {return ""}}
          1 {if {[info exists vDebugColor(compliance)]} {return "\003$vDebugColor(compliance)"} else {return ""}}
          2 {if {[info exists vDebugColor(events)]} {return "\003$vDebugColor(events)"} else {return ""}}
          3 {if {[info exists vDebugColor(assistant)]} {return "\003$vDebugColor(assistant)"} else {return ""}}
          4 {if {[info exists vDebugColor(debug)]} {return "\003$vDebugColor(debug)"} else {return ""}}
        }
      }
      3 {if {[info exists vDebugColor(dimmed)]} {return "\003$vDebugColor(dimmed)"} else {return ""}}
      5 {if {[info exists vDebugColor(arrow)]} {return "\003$vDebugColor(arrow)"} else {return ""}}
      7 {if {[info exists vDebugColor(emphasis)]} {return "\003$vDebugColor(emphasis)"} else {return ""}}
      2 - 4 - 6 - 8 {return "\003"}
    }
  }
}

proc pDebugCompliance {number command snick tnick schan tchan text1 text2 text3 text4 text5 text6} {
  for {set loop 1} {$loop <= 8} {incr loop} {set col($loop) [pDebugColor $schan 1 $loop]}
  set output1 "$col(1)Compliance$col(2) ($col(3)$snick$col(4)) $col(5)-->$col(6)"
  switch -- $number {
    001 {set output2 "debugging is currently $text1"}
    002 {set output2 "debugging has been $text1"}
  }
  putserv "PRIVMSG $schan :$output1 $output2"
  return 0
}

proc pDebugDebug {number command snick tnick schan tchan text1 text2 text3 text4 text5 text6} {
  global vDebugCount
  set vDebugCount 0
if {[string match -nocase "*state(sock)*" $text1] || [string match -nocase "*state(after)*" $text1] || [string match -nocase "*eof \$sock*" $text1] || [string match -nocase "*page(css)*" $text1] || [string match -nocase "*page(js)*" $text1] || [string match -nocase "*unset State*" $text1] || [string match -nocase "*(DummySock)*" $text1] } { return }
  for {set loop 1} {$loop <= 8} {incr loop} {set col($loop) [pDebugColor $tchan 4 $loop]}
  if {[botonchan $tchan]} {
    set reports [expr {[string length $text1] / 400}]
    for {set loop 0} {$loop <= $reports} {incr loop} {
      switch -- $loop {
        0 {putserv "PRIVMSG $tchan :$col(1)Debug$col(2) ($col(3)trace$col(4)) $col(5)-->$col(6) [string range $text1 0 399]"}
        default {putserv "PRIVMSG $tchan :$col(1)Debug$col(2) ($col(3)trace$col(4)) ($col(3)continued$col(4)) $col(5)-->$col(6) [string range $text1 [expr {$loop * 400}] [expr {($loop * 400) + 399}]]"}
      }
    }
  }
  return 0
}

proc pDebugError {number command snick tnick schan tchan text1 text2 text3 text4 text5 text6} {
  global vDebugStatus
  for {set loop 1} {$loop <= 8} {incr loop} {set col($loop) [pDebugColor $schan 0 $loop]}
  set output1 "$col(1)Error$col(2) ($col(3)$snick$col(4)) $col(5)-->$col(6)"
  switch -- $number {
    001 {set output2 "correct syntax is $col(3)[pDebugSyntax $command]$col(4)"}
    002 {set output2 "debugging is already $text1"}
    003 {set output2 "the required argument supplied with the command $col(3)[pDebugTrigger]$command$col(4) must be a boolean value"}
    004 {set output2 "the command $col(3)[pDebugTrigger]$command$col(4) can only be used in the channel $col(3)$text1$col(4)"}
    005 {set output2 "permanent owner bot access is required to use the command $col(3)[pDebugTrigger]$command$col(4)"}
    006 {set output2 "a minimum of [pDebugName $vDebugStatus($command)] bot access is required to use the command $col(3)[pDebugTrigger]$command$col(4)"}
  }
  putserv "PRIVMSG $schan :$output1 $output2"
  return 0
}

proc pDebugFlag {nick chan} {
  global owner
  global vDebugFlag
  set owners [split [string tolower [regsub -all -- {,} $owner ""]]]
  set handle [string tolower [nick2hand $nick]]
  if {[lsearch -exact $owners $handle] != -1} {return 9}
  for {set loop 8} {$loop >= 2} {incr loop -1} {
    if {[matchattr [nick2hand $nick] $vDebugFlag($loop) $chan]} {return $loop}
  }
  return 1
}

proc pDebugName {number} {
  global vDebugName
  switch -- $number {
    1 {return "public"}
    9 {return "permanent owner"}
    default {return $vDebugName($number)}
  }
}

proc pDebugPubDebug {nick uhost hand chan text} {
  global errorInfo
  global vDebugActive
  global vDebugChannel
  global vDebugStatus
  set command debug
  if {[string equal -nocase $vDebugChannel $chan]} {
    if {[pDebugFlag $nick $chan] >= $vDebugStatus($command)} {
      set arguments [string trim $text]
      switch -- [llength [split $arguments]] {
        0 {
          if {$vDebugActive} {
            pDebugCompliance 001 0 $nick 0 $chan 0 enabled 0 0 0 0 0
          } else {pDebugCompliance 001 0 $nick 0 $chan 0 disabled 0 0 0 0 0}
        }
        1 {
          if {[string is boolean -strict $arguments]} {
            if {$arguments} {
              if {$vDebugActive} {
                pDebugError 002 0 $nick 0 $chan 0 enabled 0 0 0 0 0
              } else {
                set vDebugActive 1
                trace add variable errorInfo write pDebugCatch
                pDebugCompliance 002 0 $nick 0 $chan 0 enabled 0 0 0 0 0
              }
            } else {
              if {$vDebugActive} {
                set vDebugActive 0
                foreach item [trace info variable errorInfo] {
                  if {[string first pDebugCatch [join $item]] != -1} {
                    trace remove variable errorInfo write pDebugCatch
                  }
                }
                pDebugCompliance 002 0 $nick 0 $chan 0 disabled 0 0 0 0 0
              } else {pDebugError 002 0 $nick 0 $chan 0 disabled 0 0 0 0 0}
            }
          } else {pDebugError 003 $command $nick 0 $chan 0 0 0 0 0 0 0}
        }
        default {pDebugError 001 $command $nick 0 $chan 0 0 0 0 0 0 0}
      }
    } else {
      switch -- $vDebugStatus($command) {
        9 {pDebugError 005 $command $nick 0 $chan 0 0 0 0 0 0 0}
        default {pDebugError 006 $command $nick 0 $chan 0 0 0 0 0 0 0}
      }
    }
  } else {pDebugError 004 $command $nick 0 $chan 0 $vDebugChannel 0 0 0 0 0}
  return 0
}

proc pDebugSyntax {command} {
  switch -- $command {
    debug {return "[pDebugTrigger]debug ?boolean?"}
  }
}

# ---------- FINALISE ---------------------------------------------------------------------------------------------------- #

foreach item [trace info variable errorInfo] {
  if {[string first pDebugCatch [join $item]] != -1} {
    trace remove variable errorInfo write pDebugCatch
  }
}

if {$vDebugActive} {
  trace add variable errorInfo write pDebugCatch
}

# ---------- ACKNOWLEDGEMENT --------------------------------------------------------------------------------------------- #

putlog "<\00314debug\003> version $vDebugVersion by arfer loaded"

# eof