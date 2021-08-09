#######################################################################################################
## BlackWiki 1.0  (02/09/2019)  			  Copyright 2008 - 2019 @ WwW.TCLScripts.NET			 ##
##                        _   _   _   _   _   _   _   _   _   _   _   _   _   _                      ##
##                       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \                     ##
##                      ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )                    ##
##                       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/                     ##
##                                                                                                   ##
##                                      ® BLaCkShaDoW Production ®                                   ##
##                                                                                                   ##
##                                              PRESENTS                                             ##
##									                           ® ##
#########################################   BLACK WIKI TCL  ###########################################
##									                             									 ##
##  DESCRIPTION: 							                            							 ##
##  Gets info from wikipedia about everything, available in all wikipedia languages.			     ##
##  wikipedia.org - if you want to know stuff that no one knows :-)								     ##
##									                             									 ##
##  Tested on Eggdrop v1.8.3 (Debian Linux 3.16.0-4-amd64) Tcl version: 8.6.6                        ##
##									                             									 ##
#######################################################################################################
##									                             ##
##                                 /===============================\                                 ##
##                                 |      This Space For Rent      |                                 ##
##                                 \===============================/                                 ##
##									                             ##
#######################################################################################################
##									                             ##
##  INSTALLATION: 							                             ##
##     ++ http,tls,json packages are REQUIRED for this script to work.                               ##
##     ++ Edit the BlackWiki.tcl script and place it into your /scripts directory,                   ##
##     ++ add "source scripts/BlackWiki.tcl" to your eggdrop config and rehash the bot.              ##
##									                             ##
#######################################################################################################
##									                             ##
##  CHANGELOG:                                                                                       ##
##  - 1.0 version                                                                                    ##
##    + flood protection settings against those who abuse the use of commands.                       ##
##    + utf-8 format supported.                                                                      ##
##									                             ##
#######################################################################################################
##									                         									     ##
##  OFFICIAL LINKS:                                                                                  ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                                                     ##
##   Bugs report : http://www.tclscripts.net                                                         ##
##   GitHub page : https://github.com/tclscripts/ 			                           			     ##
##   Online help : irc://irc.undernet.org/tcl-help                                                   ##
##                 #TCL-HELP / UnderNet        	                                                     ##
##                 You can ask in english or romanian                                                ##
##									                             									 ##
##     paypal.me/DanielVoipan = Please consider a donation. Thanks!                                  ##
##									                             									 ##
#######################################################################################################
##									                             ##
##                           You want a customised TCL Script for your eggdrop?                      ##
##                                Easy-peasy, just tell me what you need!                            ##
##                I can create almost anything in TCL based on your ideas and donations.             ##
##                  Email blackshadow@tclscripts.net or info@tclscripts.net with your                ##
##                    request informations and I'll contact you as soon as possible.                 ##
##									                             ##
#######################################################################################################
##									                             									 ##
##  To activate: .chanset +wiki | from BlackTools: .set #channel +wiki                               ##
##                                                                                                   ##
##  !wiki <text to search> - prints wikipedia stuff about <text> using the default language.         ##
##                                                                                                   ##
##  !wiki-?? <text to search> prints wikipedia stuff about <text> by using another language          ##
##                                                                                                   ##
##  Languages available on https://en.wikipedia.org/wiki/List_of_Wikipedias                          ##
##                                                                                                   ##
#######################################################################################################
##                                                                                                   ##
##  EXAMPLES:                                                                                        ##
##									                          									     ##
##  <user> !wiki-fr zidane                                                                           ##
##  <bot> [Wiki-fr] Title: Zidane ; Link: https://fr.wikipedia.org/wiki/Zidane    					 ##
##  <bot> [Wiki-fr] Extract >> 																		 ##
##  <bot> [Wiki-fr] Zidane ou Zidan (en arabe : زيدان, zīdān) est un nom de famille d'origine arabe  ##
##			notamment porté par :  en 1981), footballeur égyptien.                  				 ##
##                                                                                                   ##
##  <user> !wiki-ro zidane                                                                           ##
##  <bot> [Wiki-ro] Titlu: Zinedine Zidane ; Legatura: https://ro.wikipedia.org/wiki/Zinedine_Zidane ##
##  <bot> [Wiki-ro] Extract >>     																	 ##  
##  <bot> [Wiki-ro] Zinedine Yazid Zidane (în franceză Zinédine Yazid Zidane, în limba berberă 		 ##
##        Ezzin-ed-Din Yazid Zidan; n. 23 iunie 1972), popular poreclit "Zizou", este un fost        ##
##		  fotbalist și actual antrenor de fotbal al echipei Real Madrid CF..francez de origine       ## 
##	      algeriană kabâlă. 																		 ##	
##        A antrenat echipa Real Madrid Castilla între anii 2014-2015; pe 4 ianuarie 2016 a fost numit## 
##		  antrenorprincipal al echipei de fotbal Real Madrid CF, înlocuindu-l pe Rafael Benítez.	 ##
##		  Zidane a jucat ca mijlocaș ofensiv, fiind cunoscut pentru evoluția sa la națională de 	 ##	
##	      fotbal a Franței, Juventus Torino și Real Madrid. Este considerat unul din cei mai buni 	 ##
##		  fotbaliști ai tuturor timpurilor. A[...]                            						 ##
##																									 ##
##	<user> !wiki zidane 																			 ##
##	<bot> [Wiki-en] Title: Zinedine Zidane ; Link: https://en.wikipedia.org/wiki/Zinedine_Zidane 	 ##
##  <bot> [Wiki-en] Extract >>																		 ##
##  <bot> Zinedine Yazid Zidane (French pronunciation: ​[zinedin jazid zidan]; born 23 June 1972), 	 ##
##		  nicknamed "Zizou" (pronounced [zizu]), is a French former professional football player and ##
##		  current manager of Real Madrid. Widely regarded as one of the greatest players of all time,##
##		  Zidane was an elite playmaker, renowned for his elegance, vision, ball control and 		 ##
##		  technique, and played as an attacking midfielder for Cannes, Bordeaux, Juventus and 		 ##
##		  Real Madrid. At club level, Zidane won two Serie A league titles with Juventus, 			 ##
##		  before he moved to Real Madrid for a world record fee of €77.5 million in 2001, 			 ##
##		  which remained unmatched for the next[...]												 ##
##                                                                                                   ##
#######################################################################################################
##									                             ##
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
##  			          Copyright 2008 - 2019 @ WwW.TCLScripts.NET        		                 ##
##                                                                                                   ##
#######################################################################################################

#######################################################################################################
###                                 CONFIGURATION FOR BLACK Wiki TCL                                ###
#######################################################################################################

##
# DEFAULT FIRST CHAR
#Set here default char for wiki commands
###
set wiki(char) "!"

##
# DEFAULT FLAGS
#Set here who can search via wiki
###
set wiki(flags) "nm|-"

##
# DEFAULT LANGUAGE
#Set default language for wiki command (Available output lang : ro, en, fr)
###
set wiki(default_language) "en"

##
# MAX DESCRIPTION WORDS
#set max words for extract ; 0 for all
###
set wiki(max_words) "100"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders, 0 to disable flood protection
###
set wiki(ignore_prot) "1"

###
# FLOOD PROTECTION
#Set the number of requests within specified number of seconds to trigger flood protection.
# By default, 3:10, which allows for upto 3 queries in 10 seconds. 3 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set wiki(flood_prot) "3:10"

#######################################################################################################
#
#
#######################################################################################################

bind pubm $wiki(flags) * wiki:cmd

package require http
package require tls
package require json

###
# Channel flags
setudef flag wiki

###
proc wiki:cmd {nick host hand chan arg} {
	global wiki
	set lang_def ""
if {![channel get $chan wiki]} {
	return
}
	set cmd [lindex [split $arg] 0]
if {[regexp -nocase [subst -nocommands -nobackslashes {($wiki(char)wiki-(.*))}] $cmd]} {
	set lang_def [string tolower [scan $cmd %*\[^-\]-%s]]
} elseif {[regexp -nocase [subst -nocommands -nobackslashes {($wiki(char)wiki)}] $cmd]} {
	set lang_def [string tolower $wiki(default_language)]
} else {
	return
}
	set flood_protect [wiki:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [wiki:get:flood_time $host $chan]
	wiki:say 7 [list $lang_def $get_seconds] $chan $lang_def
	return
}
if {![regexp {^[a-zA-Z]} $lang_def]} {
	set lang_def [string tolower $wiki(default_language)]
}
	set text [lrange [split $arg] 1 end]
if {$text == ""} {
	wiki:say 1 $lang_def $chan $lang_def
	return
}
	set data [wiki:data $text $lang_def]
if {$data == "0"} {
	wiki:say 5 $lang_def $chan $lang_def
	return
}
	set id [lindex $data 0]
	set title [lindex $data 1]
	set link [lindex $data 2]
	set extract [lindex $data 3]
foreach line [split $extract] {
if {$line != ""} {
	lappend t $line
	}
}
if {$id == "-1"} {
	wiki:say 2 [list $lang_def $text] $chan $lang_def
	return
}
if {$wiki(max_words) > 0} {
	set llength [llength [split $t]]
if {$llength > $wiki(max_words)} {
	set t "[join [lrange [split $t] 0 $wiki(max_words)]]\[...\]"
	}
}
	wiki:say 3 [list $lang_def $title $link] $chan $lang_def
	wiki:say 6 [list $lang_def] $chan $lang_def
foreach w [wiki:wrap $t 440] {
	wiki:say 4 [list $lang_def [join $w]] $chan $lang_def
	}
}

###
proc wiki:data {str lang} {
	global wiki
	set count_w 0
	set str [join $str "%20"]
if {$lang == ""} { set lang $wiki(default_language) }
	set link "https://$lang.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=$str"
	http::register https 443 [list ::tls::socket -tls1 1]
	set ipq [http::config -useragent "lynx"]
	set check_link [catch {set ipq [::http::geturl "$link" -timeout 50000]} error_link]
if {$check_link == "1"} { return 0 }
	set data [http::data $ipq]
if {[string match -nocase "*Moved Permanently*" $data]} {
	return 0
}
	set query [wiki:json "query" $data]
	set find [expr [lsearch -nocase $query "pages"] + 1]
	set extract [lindex $query $find]
	set id [lindex $extract 0]
	set content [lindex $extract 1]
	set title [lindex $content 5]
	set extract [lindex $content 7]
if {$id != "-1"} {
	set wiki_link [wiki:getlink $id $lang]
} else {
	set wiki_link "N/A"
}
	::http::cleanup $ipq
	return [list $id $title $wiki_link $extract]
}

###
proc wiki:json {get data} {
	global wiki
	set parse [::json::json2dict $data]
	set return ""
foreach {name info} $parse {
if {[string equal -nocase $name $get]} {
	set return $info
	break;
		}
	}
	return $return
}

###
proc wiki:wrap {str {len 100} {splitChr { }}} { 
	global wiki
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

###
proc wiki:getlink {id lang} {
	global wiki
	set link "https://$lang.wikipedia.org/w/api.php?action=query&prop=info&pageids=$id&inprop=url&format=json"
	http::register https 443 [list ::tls::socket -tls1 1]
	set ipq [http::config -useragent "lynx"]
	set ipq [::http::geturl "$link" -timeout 50000] 
	set data [http::data $ipq]
	set query [wiki:json "query" $data]
	set content [lindex $query 1]
	set content [lindex $content 1]
if {$content == ""} { return "N/A" }
	regexp {fullurl (.*)} $content url
	regsub -all {editurl (.*)} $url "" string
	return [lindex $string 1]
	::http::cleanup $ipq
}

###
proc wiki:say {num arg chan lang} {
	global wiki
if {[info exists wiki(lang.$lang.$num)]} {
	set lang $lang
} else {
	set lang [string tolower $wiki(default_language)]
}
	set inc 0
foreach s $arg {
	set inc [expr $inc + 1]
	set replace(%msg.$inc%) $s
}
	set reply [string map [array get replace] $wiki(lang.$lang.$num)]
	putserv "PRIVMSG $chan :$reply"
}


###
proc wiki:flood:prot {chan host} {
	global wiki
	set number [scan $wiki(flood_prot) %\[^:\]]
	set timer [scan $wiki(flood_prot) %*\[^:\]:%s]
if {[info exists wiki(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*wiki:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists wiki(flood:$host:$chan)]} { 
	set wiki(flood:$host:$chan) 0 
}
	incr wiki(flood:$host:$chan)
	utimer $timer [list wiki:remove:flood $host $chan]	
if {$wiki(flood:$host:$chan) > $number} {
	set wiki(flood:$host:$chan:act) 1
	utimer [expr $wiki(ignore_prot) * 60] [list wiki:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}

###
proc wiki:expire:flood {host chan} {
	global wiki
if {[info exists wiki(flood:$host:$chan:act)]} {
	unset wiki(flood:$host:$chan:act)
	}
}

###
proc wiki:get:flood_time {host chan} {
	global wiki
		foreach tmr [utimers] {
if {[string match "*wiki:expire:flood $host $chan*" [join [lindex $tmr 1]]]} {
	return [lindex $tmr 0]
		}
	}
}


###
proc wiki:remove:flood {host chan} {
	global wiki
if {[info exists wiki(flood:$host:$chan)]} {
	unset wiki(flood:$host:$chan)
	}
}

set ytitle(projectName) "BlackWiki TCL"
set ytitle(author) "BLaCkShaDoW"
set ytitle(website) "wWw.TCLScriptS.NeT"
set ytitle(version) "v1.0"

#Romanian
set wiki(lang.ro.1) "\[Wiki-\002%msg.1%\002\] Foloseste $wiki(char)wiki <text> sau $wiki(char)wiki-?? <text> \[?? - limba wiki\] "
set wiki(lang.ro.2) "\[Wiki-\002%msg.1%\002\] Nu am gasit nimic despre \002%msg.2%\002."
set wiki(lang.ro.3) "\[Wiki-\002%msg.1%\002\] \002Titlu:\002 %msg.2% ; \002Legatura:\002 %msg.3%"
set wiki(lang.ro.4) "\[Wiki-\002%msg.1%\002\] %msg.2%"
set wiki(lang.ro.5) "\[Wiki-\002%msg.1%\002\] Limba editie wikipedia invalida sau conexiune refuzata."
set wiki(lang.ro.6) "\[Wiki-\002%msg.1%\002\] \002Extract >>\002"
set wiki(lang.ro.7) "\[Wiki-\002%msg.1%\002\] Protectia anti-flood activata. Te rog asteapta \002 %msg.2% secunde\002 inainte de a folosii\002 $wiki(char)wiki\002 din nou"
#English
set wiki(lang.en.1) "\[Wiki-\002%msg.1%\002\] Use \002$wiki(char)wiki <text>\002 or \002$wiki(char)wiki-?? <text>\002 \[?? - wiki language\] "
set wiki(lang.en.2) "\[Wiki-\002%msg.1%\002\] Nothing found for \002%msg.2%\002."
set wiki(lang.en.3) "\[Wiki-\002%msg.1%\002\] \002Title:\002 %msg.2% ; \002Link:\002 %msg.3%"
set wiki(lang.en.4) "\[Wiki-\002%msg.1%\002\] %msg.2%"
set wiki(lang.en.5) "\[Wiki-\002%msg.1%\002\] Invalid wikipedia language or conection refused."
set wiki(lang.en.6) "\[Wiki-\002%msg.1%\002\] \002Extract >>\002"
set wiki(lang.en.7) "\[Wiki-\002%msg.1%\002\] Flood protection enabled. You need to wait\002 %msg.2% seconds\002 before using\002 $wiki(char)wiki\002 again"
#French
set wiki(lang.fr.1) "\[Wiki-\002%msg.1%\002\] Utilisez \ 002$wiki(char)wiki <text> \002 ou \002$wiki(char)wiki-?? <text> \002 \[?? - langue du wiki\]"
set wiki(lang.fr.2) "\[Wiki-\002%msg.1%\002\] Rien trouvé pour \002%msg.2%\002."
set wiki(lang.fr.3) "\[Wiki-\002%msg.1%\002\] \002Titre:\002%msg.2% ; \002Link:\002%msg.3%"
set wiki(lang.fr.4) "\[Wiki-\002%msg.1%\002\] %msg.2%"
set wiki(lang.fr.5) "\[Wiki-\002%msg.1%\002\] Une langue ou une connexion wikipedia non valide a été refusée."
set wiki(lang.fr.6) "\[Wiki-\002%msg.1%\002\] \002Extract >>\002"
set wiki(lang.fr.7) "\[Wiki-\002%msg.1%\002\] Protection contre les inondations activée. Vous devez attendre \002%msg.2% secondes \002 avant d'utiliser \002$wiki(char)wiki\002 à nouveau "

putlog "\002$ytitle(projectName) $ytitle(version)\002 coded by $ytitle(author) ($ytitle(website)): Loaded."