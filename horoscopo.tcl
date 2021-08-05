#######################################################################################################
## Blackhoroscope 1.0  (09/02/2019) 		          Copyright 2008 - 2021 @ WwW.TCLScripts.NET         ##
## - spanish version -    _   _   _   _   _   _   _   _   _   _   _   _   _   _                      ##
##                       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \                     ##
##                      ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )                    ##
##                       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/                     ##
##                                                                                                   ##
##                                      ® BLaCkShaDoW Production ®                                   ##
##                                                                                                   ##
##                                              PRESENTS                                             ##
##									                          																										 ® ##
########################################  BLACK HOROSCOPE TCL   #######################################
##									                             																										 ##
##  DESCRIPTION: 							                             																					 ##
##  Gives detailed horoscopo predictions about all astrology signs, commonly known as zodiac signs.  ##
##									                             																										 ##
##  Tested on Eggdrop v1.8.3 (Debian Linux 3.16.0-4-amd64) Tcl version: 8.6.6                        ##
##									                             																										 ##
#######################################################################################################
##									                             ##
##                                 /===============================\                                 ##
##                                 |      This Space For Rent      |                                 ##
##                                 \===============================/                                 ##
##									                             ##
#######################################################################################################
##									                             ##
##  INSTALLATION: 							                             ##
##     ++ http & tls packages are REQUIRED for this script to work.                                  ##
##     ++ Edit the BlackhoroscopeES.tcl script and place it into your /scripts directory,            ##
##     ++ add "source scripts/BlackhoroscopeES.tcl" to your eggdrop config and rehash the bot.       ##
##									                             																										 ##
#######################################################################################################
##									                             																										 ##
##  OFFICIAL LINKS:                                                                                  ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                                                     ##
##   Bugs report : http://www.tclscripts.net                                                         ##
##   GitHub page : https://github.com/tclscripts/ 			                             								 ##
##   Online help : irc://irc.undernet.org/tcl-help                                                   ##
##                 #TCL-HELP / UnderNet        	                                                     ##
##                 You can ask in english or romanian                                                ##
##									                             																										 ##
##     paypal.me/DanielVoipan = Please consider a donation. Thanks!                                  ##
##									                             																										 ##
#######################################################################################################
##									                             																										 ##
##                           You want a customised TCL Script for your eggdrop?                      ##
##                                Easy-peasy, just tell me what you need!                            ##
##                I can create almost anything in TCL based on your ideas and donations.             ##
##                  Email blackshadow@tclscripts.net or info@tclscripts.net with your                ##
##                    request informations and I'll contact you as soon as possible.                 ##
##									                             																										 ##
#######################################################################################################
##									                            																										 ##
##  COMMANDS:                                                                                        ##
##									                             																										 ##
##  To activate: .chanset +horoscopo | from BlackTools: .set #channel +horoscopo                     ##
##                                                                                                   ##
##  !horoscopo [?|help] - shows all available commands.                                              ##
##                                                                                                   ##
##  !signo [?|help] - shows all available commands.                                                  ##
##                                                                                                   ##
##  !signo [set|reset] [sign] - links a default user horoscopo 'sign'.                               ##
##                                                                                                   ##
##  !signo [nick] - returns horoscopo predictions for the current day.                               ##
##                                                                                                   ##
##                                                                                                   ##
##  !horoscopo version - shows the actual Blackhoroscopo script version.                             ##
##                                                                                                   ##
#######################################################################################################
##									                             																									   ##
##  LICENSE:                                                                                         ##
##   This code comes with ABSOLUTELY NO WARRANTY.                                                    ##
##                                                                                                   ##
##   This program is free software; you can redistribute it and/or modify it under the terms of      ##
##   the GNU General Public License version 3 as published by the Free Software Foundation.          ##
##                                                                                                   ##
##   This program is distributed WITHOUT ANY WARRANTY; without even the implied warranty of          ##
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                                            ##
##   USE AT YOUR OWN RISK.                                                                           ##
##                                                                                                   ##
##   See the GNU General Public License for more details.                                            ##
##        (http://www.gnu.org/copyleft/library.txt)                                                  ##
##                                                                                                   ##
##  			          Copyright 2008 - 2021 @ WwW.TCLScripts.NET                         					     ##
##                                                                                                   ##
#######################################################################################################

#######################################################################################################
###                            CONFIGURATION FOR BlackHoroscope ES TCL                           		###
#######################################################################################################

###
# Cmdchar trigger
# - set here the trigger you want to use.
###
set horoscopo(cmd_char) "!"

###
# User db file
# - specifies the file where all users horoscopo signs are stored.
###
set horoscopo(user_file) "scripts/Blackhoroscopo.ES.users.txt"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders, 0 to disable flood protection
###
set horoscopo(ignore_prot) "1"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 3:10, which allows for upto 3 queries in 10 seconds. 3 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set horoscopo(flood_prot) "3:10"

###
# Channel flags
# - to activate the script:
# .set +horoscopo or .chanset #channel +horoscopo

###
# Output type
# 1 - NOTICE ; 0 - CHANNEL
###
set horoscopo(output_type) "0"

setudef flag horoscopo

#######################################################################################################
###                       DO NOT MODIFY HERE UNLESS YOU KNOW WHAT YOU'RE DOING                      ###
#######################################################################################################

package require http
package require tls

###
# Bindings
bind pub - $horoscopo(cmd_char)horoscopo horoscopo:sign:cmd
bind pub - $horoscopo(cmd_char)signo horoscopo:sign:cmd
bind pubm - * horoscopo:get:cmd

#OBF
# Zodiac signs
set horoscopo(signs) "Aries Tauro Geminis Géminis Cancer Cáncer Leo Virgo Libra Escorpio Sagitario Capricornio Acuario Piscis"
set horoscopo(english_signs) "Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces"
#/OBF

#OBF
if {![file exists $horoscopo(user_file)]} {
	set file [open $horoscopo(user_file) w]
	close $file
}
#/OBF

#OBF
proc horoscopo:sign:cmd {nick host hand chan arg} {
	global horoscopo
if {![channel get $chan horoscopo]} {
	return
}
	set flood_protect [horoscopo:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [horoscopo:get:flood_time $host $chan]
	horoscopo:say $nick $chan [list $nick $get_seconds] 13
	return
}
	set cmd [lindex [split $arg] 0]
	set setup_sign [lindex [split $arg] 1]
switch $cmd {
	set {
if {[lsearch -nocase $horoscopo(signs) $setup_sign] < 0} {
	horoscopo:say $nick $chan [list $nick $setup_sign] 5
	return
			}
	horoscopo:setsign $nick $host $chan $setup_sign 0
	horoscopo:say $nick $chan [list $nick $setup_sign] 2
	return
		}
	reset {
	set check_sign [horoscopo:getsign $nick $host $chan]
if {$check_sign == "0"} {
	horoscopo:say $nick $chan [list $nick $horoscopo(cmd_char)] 3
	return
			} else {
	horoscopo:setsign $nick $host $chan $setup_sign 1
	horoscopo:say $nick $chan [list $nick] 4
	return
			}
		}
	help {
	horoscopo:say $nick $chan [list $horoscopo(cmd_char)] help
	return
		}
	\? {
	horoscopo:say $nick $chan [list $horoscopo(cmd_char)] help
	return
		}
	version {
	horoscopo:say "" $chan [list $horoscopo(cmd_char)] version
	return
		}
	}
if {[onchan $cmd $chan]} {
	set get_host [getchanhost $cmd $chan]
	set check_sign [horoscopo:getsign $cmd $get_host $chan]
if {$check_sign == "0"} {
	horoscopo:say $nick $chan [list $cmd] 11
	return
	}
} elseif {$cmd == ""} {
	set check_sign [horoscopo:getsign $nick $host $chan]
if {$check_sign == "0"} {
horoscopo:say $nick $chan [list $nick $horoscopo(cmd_char)] 3
	return
	}
} else {
if {[lsearch -nocase $horoscopo(signs) $cmd] < 0} {
		horoscopo:say $nick $chan [list $nick $cmd] 5
		return
	} else {
		set check_sign [lindex $horoscopo(signs) [lsearch -nocase $horoscopo(signs) $cmd]]
	}
}
	set stars [horoscopo:get $check_sign]
	set hr [horoscopo:get_data $check_sign]
	set date [lindex $hr 0]
	set hr [lindex $hr 1]
if {$horoscopo(output_type) == "0"} {
	putserv "PRIVMSG $chan :[horoscopo:format "Predicci&#243;n"] para hoy $date"
foreach w [horoscopo:wrap $hr 440] {
	putserv "PRIVMSG $chan :\002$check_sign\002 - $w"
	}
	putserv "PRIVMSG $chan :\002$check_sign\002 - $stars"
} else {
	putserv "NOTICE $nick :[horoscopo:format Predicci&#243;n] para hoy $date"
foreach w [horoscopo:wrap $hr 440] {
	putserv "NOTICE $nick :\002$check_sign\002 - $w"
	}
	putserv "NOTICE $nick :\002$check_sign\002 - $stars"
		}
}
#/OBF

#OBF
proc horoscopo:getsign {nick host chan} {
	global horoscopo
	set file [open $horoscopo(user_file) "r"]
	set read_sign ""
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set enc_chan [encoding convertfrom utf-8 $read_chan]
	set read_host [lindex [split $line] 2]
if {[string equal -nocase $enc_chan $chan] && [string match -nocase $host $read_host]} {
	set read_sign [lindex [split $line] 3]
	break
	}
}
	close $file
if {$read_sign == ""} {
	return 0
	} else {
	return $read_sign
	}
}
#/OBF

#OBF
proc horoscopo:setsign {nick host chan sign reset} {
	global horoscopo
	set file [open $horoscopo(user_file) "r"]
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set temp "sign_temp.$timestamp"
	set tempwrite [open $temp w]
while {[gets $file line] != -1} {
	set read_chan [lindex [split $line] 0]
	set enc_chan [encoding convertfrom utf-8 $read_chan]
	set read_host [lindex [split $line] 2]
if {[string equal -nocase $enc_chan $chan] && [string match -nocase $host $read_host]} {
	continue
	} else {
	puts $tempwrite $line
	}
}
	close $tempwrite
	close $file
    file rename -force $temp $horoscopo(user_file)
if {$reset == "0"} {
	set file [open $horoscopo(user_file) a]
	puts $file "$chan $nick $host $sign"
	close $file
	}
}
#/OBF

#OBF
proc horoscopo:get:cmd {nick host hand chan arg} {
	global horoscopo
if {![channel get $chan horoscopo]} {
	return
}
	set zodiac_type 0
	set cmd [lindex [split $arg] 0]
	set cmd_map [lindex [split $cmd $horoscopo(cmd_char)] 1]
if {[lsearch -nocase $horoscopo(signs) $cmd_map] > -1} {
	set sign [lindex $horoscopo(signs) [lsearch -nocase $horoscopo(signs) $cmd_map]]
	set flood_protect [horoscopo:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [horoscopo:get:flood_time $host $chan]
	horoscopo:say $nick $chan [list $nick $get_seconds] 13
	return
}
	set stars [horoscopo:get $cmd_map]
	set hr [horoscopo:get_data $cmd_map]
	set date [lindex $hr 0]
	set hr [lindex $hr 1]
if {$horoscopo(output_type) == "0"} {
	putserv "PRIVMSG $chan :[horoscopo:format "Predicci&#243;n"] para hoy $date"
foreach w [horoscopo:wrap $hr 440] {
	putserv "PRIVMSG $chan :\002$sign\002 - $w"
		}
	putserv "PRIVMSG $chan :\002$sign\002 - $stars"
	} else {
	putserv "NOTICE $nick :[horoscopo:format Predicci&#243;n] para hoy $date"
foreach w [horoscopo:wrap $hr 440] {
	putserv "NOTICE $nick :\002$sign\002 - $w"
		}
	putserv "NOTICE $nick :\002$sign\002 - $stars"
				}
		}
}
#/OBF

#OBF
proc horoscopo:say {nick chan arg type} {
	global black horoscopo
	set inc 0
foreach s $arg {
	set inc [expr $inc + 1]
	set replace(%msg.$inc%) $s
}
	set reply [string map [array get replace] $black(horoscopo.en.$type)]
if {$nick == ""} {
	putserv "PRIVMSG $chan :$reply"
	} else {
	putserv "NOTICE $nick :$reply"
	}
}
#/OBF

#OBF
proc horoscopo:get {sign} {
	global horoscopo
	set data [horoscopo:get_stars $sign]
	set pos [expr [horoscopo:position $sign] - 1]
	set sign [lindex $horoscopo(english_signs) $pos]
	set output [split $data "\n"]
	set stars_line ""
	set counter 0
	set i 0
	array set stars [list]
foreach line $output {
if {[string match -nocase "*/star-ratings/today/$sign\">*" $line]} {
	set star_line [lindex $output $counter]
	incr i
	set star [horoscop:check:star $star_line]
	set stars($i) $star
	}
if {$i == "4"} {
	break
	}
	set counter [expr $counter + 1]
}
for {set j 1} { $j <= 4 } {incr j} {
	set get_unformated_stars [horoscopo:set:star $stars($j)]
	set stars($j) [horoscopo:text:format_stars $get_unformated_stars]
	}
	lappend stars_line "\002Sexo\002: $stars(1) ; \002Ajetreo\002: $stars(2) ; \002Ambiente\002: $stars(3) ; \002el triunfo\002: $stars(4)"

	return [join $stars_line]
}
#/OBF

#OBF
proc horoscopo:text:format_stars {string} {
    set map {}
    foreach {entity number} [regexp -all -inline {&#(\d+)} $string] {
        lappend map $entity [format \\u%04x [scan $number %d]]
    }
    set string [string map [subst -nocomm -novar $map] $string]
	return $string
 }
#/OBF

#OBF
# Credits
set horoscopo(projectName) "BlackHoroscope ES"
set horoscopo(author) "BLaCkShaDoW"
set horoscopo(website) "wWw.TCLScriptS.NeT"
set horoscopo(email) "blackshadow\[at\]tclscripts.net"
set horoscopo(version) "v1.0"
#/OBF

#OBF
proc horoscopo:set:star {nr} {
	global horoscopo
	set stars ""
for {set i 1} { $i <= $nr} { incr i} {
	lappend stars [join &#9733]
	}
	set dif [expr 5 - $nr]
for {set j 1} { $j <= $dif} { incr j} {
	lappend stars [join &#9734]
	}
	return [join $stars]
}
#/OBF

#OBF
proc horoscop:check:star {text} {
	global horoscopo
	set a [regexp -all {(highlight)} $text]
	return $a
}
#/OBF

#OBF

proc horoscopo:position {sign} {
	global horoscopo
switch [string tolower $sign] {
	aries {
	return 1
	}
	tauro {
	return 2
	}
	geminis {
	return 3
	}
	géminis {
	return 3
	}
	cancer {
	return 4
	}
	cáncer {
	return 4
	}
	leo {
	return 5
	}
	virgo {
	return 6
	}
	libra {
	return 7
	}
	escorpio {
	return 8
	}
	sagitario {
	return 9
	}
	capricornio {
	return 10
	}
	acuario {
	return 11
	}
	piscis {
	return 12
		}
	}
}
#/OBF

#OBF
proc horoscopo:get_stars {sign} {
	global horoscopo
	set pos [horoscopo:position $sign]
	set link "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=$pos"
	http::register https 443 [list ::tls::socket -tls1 1]
	set ipq [http::config -useragent "lynx"]
	set ipq [::http::geturl "$link" -timeout 10000]
	set data [http::data $ipq]
	::http::cleanup $ipq
	return $data
}
#/OBF

#OBF
proc horoscopo:get_data {sign} {
	global horoscopo
	set sign [string tolower $sign]
if {[string equal -nocase $sign "géminis"]} {set sign "geminis"}
if {[string equal -nocase $sign "cáncer"]} {set sign "cancer"}
	set link "https://www.hola.com/horoscopo/$sign/"
	http::register https 443 [list ::tls::socket -tls1 1]
	set ipq [http::config -useragent "lynx"]
	set ipq [::http::geturl "$link" -timeout 10000]
	set data [http::data $ipq]
	::http::cleanup $ipq
	set split_data [split $data "\n"]
	set hr ""
	regexp {<h2 class="title">(.*?)</h2>} $data time
	regexp {<strong>(.*?)</strong>} $time -> date
	regexp {<p><p>(.*?)</p>} $split_data -> hr
if {$hr != ""} {
	set hr [horoscopo:special_chars $hr]
	set hr [horoscopo:format $hr]
	return [list $date $hr]
	} else {return 0}
}
#/OBF

###
proc horoscopo:format {string} {
    set map {}
    foreach {entity number} [regexp -all -inline {&#(\d+);} $string] {
        lappend map $entity [format \\u%04x [scan $number %d]]
    }
    set string [string map [subst -nocomm -novar $map] $string]
	return $string
 }

###
proc horoscopo:special_chars {text} {
	global horoscopo
set hr_replace [list "Agrave 192" "Egrave 200" "Igrave 204" "Ograve 210" "Ugrave 217" "agrave 224" "egrave 232" "igrave 236" "ograve 242" "ugrave 249" "Aacute 193" "Eacute 201" "Iacute 205" "Oacute 211" "Uacute 218" "Yacute 221" "aacute 225" "eacute 233" "uacute 250" "iacute 237" "oacute 243" "yacute 253" "Acirc 194" "Ecirc 202" "Icirc 206" "Ocirc 212" "Ucirc 219" "ecirc 234" "acirc 226" "icirc 238" "ocirc 244" "ucirc 251" "Atilde 195" "Ntilde 209" "Otilde 213" "atilde 227" "ntilde 241" "otilde 245" "Auml 196" "Euml 203" "Iuml 207" "Uuml 220" "Yuml 259" "Ouml 214" "auml 228" "euml 235" "iuml 239" "ouml 245" "uuml 252" "yuml 255" "iquest 191"]
	set map {}
	foreach {entity number} [regexp -all -inline {&([A-z]+);} $text] {
		set search [lsearch $hr_replace "$number *"]
if {$search > -1} {
		set entry [lindex $hr_replace $search]
		set nn [lindex $entry 1]
		lappend map $entity "&#$nn;"
		}
	}
	set text [string map [subst -nocomm -novar $map] $text]
	return $text
}

#OBF
proc horoscopo:wrap {str {len 100} {splitChr { }}} {
   set out [set cur {}]; set i 0
   foreach word [split [set str][unset str] $splitChr] {
     if {[incr i [string len $word]]>$len} {
         lappend out [join $cur $splitChr]
         set cur [list $word]
         set i [string len $word]
      } {
         lappend cur $word
      }
      incr i
   }
   lappend out [join $cur $splitChr]
}
#/OBF

#OBF
proc horoscopo:flood:prot {chan host} {
	global horoscopo
	set number [scan $horoscopo(flood_prot) %\[^:\]]
	set timer [scan $horoscopo(flood_prot) %*\[^:\]:%s]
if {[info exists horoscopo(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*horoscopo:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists horoscopo(flood:$host:$chan)]} {
	set horoscopo(flood:$host:$chan) 0
}
	incr horoscopo(flood:$host:$chan)
	utimer $timer [list horoscopo:remove:flood $host $chan]
if {$horoscopo(flood:$host:$chan) > $number} {
	set horoscopo(flood:$host:$chan:act) 1
	utimer [expr $horoscopo(ignore_prot) * 60] [list horoscopo:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}
#/OBF

#OBF
proc horoscopo:remove:flood {host chan} {
	global horoscopo
if {[info exists horoscopo(flood:$host:$chan)]} {
	unset horoscopo(flood:$host:$chan)
	}
}
#/OBF

#OBF
proc horoscopo:expire:flood {host chan} {
	global horoscopo
if {[info exists horoscopo(flood:$host:$chan:act)]} {
	unset horoscopo(flood:$host:$chan:act)
	}
}
#/OBF

#OBF
proc horoscopo:get:flood_time {host chan} {
	global horoscopo
		foreach tmr [utimers] {
if {[string match "*horoscopo:expire:flood $host $chan*" [join [lindex $tmr 1]]]} {
	return [lindex $tmr 0]
		}
	}
}
#/OBF

###
#Language
set black(horoscopo.en.help) "Comandos: \002%msg.1%signo\002 \[?|help\] ; \002%msg.1%signo set\002 <signo> ; \002%msg.1%signo reset\002 ; \002%msg.1%signo\002 \[signo|nick\]; \002%msg.1%horoscopo\002 version"
set black(horoscopo.en.2) "\002%msg.1%\002, tu signo del zodíaco predeterminado se estableció en:\002 %msg.2%\002."
set black(horoscopo.en.3) "\002%msg.1%\002, no tienes un signo del zodíaco establecido. Utilizar:\002 \[%msg.2%signo\] set <signo>\002 para establecer uno."
set black(horoscopo.en.4) "\002%msg.1%\002, tu signo del zodíaco predeterminado ha sido eliminado."
set black(horoscopo.en.5) "\002%msg.1%\002, no se ha encontrado ningún signo del zodíaco para\002 %msg.2%\002. Utilice un signo zodiacal específico."
set black(horoscopo.en.11) "\002%msg.1%\002 aún no tiene un signo del zodíaco establecido.."
set black(horoscopo.en.13) "\002%msg.1%\002: Envías solicitudes demasiado rápido. Cálmate y vuelve a intentarlo después \002%msg.2% secundos\002. Gracias!"
set black(horoscopo.en.version) "\002$horoscopo(projectName) $horoscopo(version)\002 codificado por\002 $horoscopo(author)\002 ($horoscopo(email)) --\002 $horoscopo(website)\002."

putlog "\002$horoscopo(projectName) $horoscopo(version)\002 codificado por\002 $horoscopo(author)\002 ($horoscopo(website)): Cargado e inicializado.."

##################
#######################################################################################################
###                  *** END OF Blackhoroscope ES TCL ***                                           ###
#######################################################################################################
