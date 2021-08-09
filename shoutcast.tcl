#######################################################################################################
## BlackRadio 1.2 - Shoutcast Edition (09/12/2020) 				Copyright 2008 - 2020 @ WwW.TCLScripts.NET ##
##                        _   _   _   _   _   _   _   _   _   _   _   _   _   _                      ##
##                       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \                     ##
##                      ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )                    ##
##                       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/                     ##
##                                                                                                   ##
##                                      ® BLaCkShaDoW Production ®                                   ##
##                                                                                                   ##
##                                              PRESENTS                                             ##
##									                          																									   ® ##
###########################################  BLACK RADIO TCL   ########################################
####################                       	SHOUTCAST EDITION 						    #########################
##  DESCRIPTION: 						 	                            																					 ##
##  Simple & easy to use script for Shoutcast servers.       							                           ##
##									                             																										 ##
##  Supports ONLY SHOUTCAST servers.                                                         			   ##
##									                             																										 ##
##  Tested on Eggdrop v1.8.3 (Debian Linux 3.16.0-4-amd64) Tcl version: 8.6.6                        ##
##									                             																										 ##
#######################################################################################################
##									                             																										 ##
##                                 /===============================\                                 ##
##                                 |      This Space For Rent      |                                 ##
##                                 \===============================/                                 ##
##									                             																										 ##
#######################################################################################################
##									                                                                                 ##
##  INSTALLATION: 							                                                                     ##
##     ++ http package is REQUIRED for this script to work.                                          ##
##     ++ Edit the BlackRadio.tcl script and place it into your /scripts directory,                  ##
##     ++ add "source scripts/BlackRadio.tcl" to your eggdrop config and rehash the bot.             ##
##									                           																										   ##
#######################################################################################################
##									                            																									   ##
##  OFFICIAL LINKS:                                                                                  ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                                                     ##
##   Bugs report : http://www.tclscripts.net                                                         ##
##   GitHub page : https://github.com/tclscripts/ 			                           								   ##
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
##									                             																										 ##
##  Commands:                                                                                        ##
##								                                    																							 ##
##  Enable: .chanset +blackradio | from BlackTools: .set #chan +blackradio              	           ##
##									                             																								  	 ##
##  !radio (show current song) | !radio uptime (show radio uptime)									                 ##
##									                       																										       ##
##  !dj add <nick> | list | del <nick>/<hand> | on | off | top [total] (top shoutcast time and votes)##                                          ##
##									                            																										 ##
##  !like (if you like a song)| list (for admin flags or dj)																				 ##
##																																																	 ##
##  !dislike (if you dont like a song) | list (for admin flags or dj)			    											 ##
##																																																	 ##
##  !vote (vote for the current DJ) | list (for admin flags) | reset (for admin flags)							 ##
##									                           																											 ##
##  !request <your message to the dj> (when DJ is online)                                       	   ##
##									                                                                                 ##
##  Automatic TOPIC setup on backup/dj: set +radiotopic                                              ##
##																																																	 ##
##	Script works on multiple channels for showing song or listeners																	 ##
##									                            																										 ##
##  ONLY SHOUTCAST servers are supported. 	                                                         ##
##									                             																										 ##
#######################################################################################################
##									                            																										 ##
##  PERSONAL AND NON-COMMERCIAL USE LIMITATION.                                                      ##
##									                             																										 ##
##  This program is provided on an "as is" and "as available" basis, with ABSOLUTELY NO WARRANTY.    ##
##  Use it at your own risk.                                                                         ##
##									                             																									   ##
##  Use this code for personal and NON-COMMERCIAL purposes ONLY.                                     ##
##									                          																										   ##
##  Unless otherwise specified, YOU SHALL NOT copy, reproduce, sublicense, distribute, disclose,     ##
##  create derivatives, in any way ANY PART OF THIS CONTENT, nor sell or offer it for sale.          ##
##									                             																										 ##
##  You will NOT take and/or use any screenshots of this source code for any purpose without the     ##
##  express written consent or knowledge of author(s)/co-author(s).                                  ##
##									                             																										 ##
##  You may NOT alter or remove any trademark, copyright or other notice from this source code.      ##
##									                             																										 ##
##                        Copyright 2008 - 2020 @ WwW.TCLScripts.NET                                 ##
##									                             																										 ##
#######################################################################################################

#######################################################################################################
##                                               CONFIGURARI                                         ##
#######################################################################################################

###
# Cmdchar trigger
# - set here the trigger you want to use.
set black(radio_char) "!"

###
#What flags can use use !radio or to reset things in radio ? (admin flags)
set black(radio_admin_flags) "mn|-"

##
#set radio channel
set black(radio_chan) "#tererefm"

##
#set radio backchan (You can use !dj stuff also)
set black(radio_backchan) "#tererefm"

##
#set radio ip:port
set black(radio_ip) "138.201.12.42:8014"

#set radio admin pass
set black(radio_pass) "AZWHMUNMY2969WWBQRX8"

#set shoutcast version (1 - version 1.x ; 2 - version 2.x)
#version 1.x uses socket connection ; version 2.x uses http.tcl
set black(radio_version) "1"

###
#script banner
set black(banner_radio) "\[R\]"

##
#set radio streamname
set black(radio_stream) "RADIO TerereFM"

##
#set radio stream url (it will appear in messages)
set black(radio_stream_url) "Escucha la radio poniendo la siguiente direccion en tu navegador: "

##
#set the topic when backup
set black(radio:backup_topic) "\002%radio%\002 is \002ONLINE\002. Backup : ON. Listen by accessing this link $black(radio_stream_url)"

##
#set the topic when DJ is online
set black(radio:dj_topic) "\002%radio%\002 is \002ONLINE\002. with DJ : \002%dj%\002. Listen by accessing this link $black(radio_stream_url)"

##
#set the topic when radio is offline
set black(radio:offline_topic) "\002%radio%\002 is \002OFFLINE\002. We'll be right back."

###
#Do you want the "Current listeners" to be shown separately or with the song change ? (1 - separately ; 0 with the song)
set black(listeners_show_type) "0"

#After what number of minutes of inactivity (joins,messages)
#the radio should suspend ? (set it to 0 if dont want the radio to autostop)
set black(radio_minutes_stop) "720"

##
#After what number of days the "like's should expire ?"
set black(radio:like_expire) "7"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 4:10, which allows for upto 3 queries in 10 seconds. 4 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set blackradio(flood_prot) "3:5"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders
###
set blackradio(ignore_prot) "1"

#######################################################################################################
###                       DO NOT MODIFY HERE UNLESS YOU KNOW WHAT YOU'RE DOING                      ###
#######################################################################################################

###
# Bindings
# - using commands
bind pub $black(radio_admin_flags) $black(radio_char)radio black:radio:cmd
bind pub - $black(radio_char)dj black:radio:dj
bind pub - $black(radio_char)request black:radio:request
bind pub - $black(radio_char)like black:radio:like
bind pub - $black(radio_char)dislike black:radio:dislike
bind pub - $black(radio_char)vote black:radio:vote
bind join - * black:radio:join
bind pubm - * black:radio:chanmessage
bind time - "* * * * *" radio:minute:timer
bind time - "00 00 * * *" radio:reset:dayshoutcasttime

###
# Channel flags
setudef flag blackradio
setudef flag radiotopic

if {$black(radio_version) == 2} {
package require http
if {[regexp {https://} $black(radio_stream_url)]} {
package require tls
	}
}

###
if {![file exists "radio_likes.txt"]} {
	set file [open "radio_likes.txt" w]
	close $file
}
###
if {![file exists "radio_dislikes.txt"]} {
	set file [open "radio_dislikes.txt" w]
	close $file
}

###
proc radio:topic:set {chan dj off} {
	global black
	set message ""
if {[channel get $chan radiotopic]} {
if {[botisop $chan]} {
	set replace(%link%) [black:radio:getinfo "website"]
	set replace(%dj%) $dj
	set replace(%radio%) [black:radio:getinfo "streamname"]
if {$dj != ""} {
	set message [string map [array get replace] $black(radio:dj_topic)]
			} elseif {$off == "offline"} {
	set message [string map [array get replace] $black(radio:offline_topic)]
			} else {
	set message [string map [array get replace] $black(radio:backup_topic)]
			}
	putserv "TOPIC $chan :$message"
		}
	}
}

###
proc black:radio:dislike {nick host hand chan arg} {
	global black
	set list [lindex [split $arg] 0]
if {[string equal -nocase $chan $black(radio_chan)]} {
if {![channel get $chan blackradio]} {
	return
}
	set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
if {[string equal -nocase $list "list"]} {
	set num 0
	set file [open "radio_dislikes.txt" r]
while {[gets $file line] != -1} {
	set num [expr $num + 1]
	set read_dj [lindex [split $line] 0]
	set read_host [lindex [split $line] 1]
	set read_time [lindex [split $line] 2]
	set read_song [lrange [split $line] 3 end]
	putserv "PRIVMSG $chan :\[RS\] $num. \002Song\002:$read_song ; \002DJ\002:$read_dj ; \002Date\002:[ctime $read_time] ; \002Host\002:$read_host"
		}
	close $file
if {$num == "0"} {
	putserv "PRIVMSG $chan :$black(banner_radio) There are currently no dislikes for $black(radio_stream)"
		}
	return
	}
}
if {![info exists black(radio:dj_status)]} {
	set dj "N/A"
} else {
	set dj $black(radio:dj_status)
}
	set current_song [black:radio:getinfo "currentsong"]
	set liked [radio:type:add $dj $current_song $host 1]
if {$liked == 2} {
	putserv "NOTICE $nick :$black(banner_radio) You already expressed your feelings for this song."
	return
}
if {$liked == "1"} {
	putserv "NOTICE $nick :$black(banner_radio) Your dislike for : \002$current_song\002 has been registered. We thank you :)"
			} else {
	putserv "NOTICE $nick :$black(banner_radio) You already liked this song :P"
		}
	}
}

###
proc black:radio:like {nick host hand chan arg} {
	global black
	set list [lindex [split $arg] 0]
if {[string equal -nocase $chan $black(radio_chan)]} {
if {![channel get $chan blackradio]} {
	return
}
	set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
if {[string equal -nocase $list "list"]} {
	set num 0
	set file [open "radio_likes.txt" r]
while {[gets $file line] != -1} {
	set num [expr $num + 1]
	set read_dj [lindex [split $line] 0]
	set read_host [lindex [split $line] 1]
	set read_time [lindex [split $line] 2]
	set read_song [lrange [split $line] 3 end]
	putserv "PRIVMSG $chan :$black(banner_radio) $num. \002Song\002:$read_song ; \002DJ\002:$read_dj ; \002Data\002:[ctime $read_time] ; \002Host\002:$read_host"
		}
	close $file
if {$num == "0"} {
	putserv "PRIVMSG $chan :$black(banner_radio) There are currently no likes for $black(radio_stream)"
		}
	return
	}
}
	set current_song [black:radio:getinfo "currentsong"]

if {![info exists black(radio:dj_status)]} {
	set dj "N/A"
} else {
	set dj $black(radio:dj_status)
}
	set liked [radio:type:add $dj $current_song $host 0]
if {$liked == "2"} {
		putserv "NOTICE $nick :$black(banner_radio) You already expressed your feelings for this song."
		return
	}
if {$liked == "1"} {
	putserv "NOTICE $nick :$black(banner_radio) Your like for : \002$current_song\002 has been registered. We thank you :)"
			} else {
				putserv "NOTICE $nick :$black(banner_radio) You already like it this song :P"
		}
	}
}

###
proc radio:type:add {dj song host type} {
	global black
	set already_liked 0
	set already_report 0
if {$type == 0} {
	set filetype "radio_likes.txt"
} else {
	set filetype "radio_dislikes.txt"
}
	set file [open "radio_likes.txt" r]
	while {[gets $file line] != -1} {
	set read_dj [lindex [split $line] 0]
	set read_host [lindex [split $line] 1]
	set read_time [lindex [split $line] 2]
	set read_song [lrange [split $line] 3 end]
if {[string equal -nocase $read_host $host] && [string equal -nocase $song $read_song]} {
	set already_liked 1
		}
	}
	close $file

	set file [open "radio_dislikes.txt" r]
	while {[gets $file line] != -1} {
	set read_dj [lindex [split $line] 0]
	set read_host [lindex [split $line] 1]
	set read_time [lindex [split $line] 2]
	set read_song [lrange [split $line] 3 end]
if {[string equal -nocase $read_host $host] && [string equal -nocase $song $read_song]} {
	set already_report 1
		}
	}
	close $file
if {$already_liked == 1 && $type == 1} {
	return 2
} elseif {$already_report == 1 && $type == 0} {
	return 2
}
if {$already_liked == "0" && $already_report == 0} {
	set file [open $filetype a]
	puts $file "$dj $host [unixtime] $song"
	close $file
} else {
	return -1
	}
	return 1
}

###
proc black:radio:join {nick host hand chan} {
	global black
if {![channel get $chan blackradio]} {
	return
}
if {$black(radio_minutes_stop) != "0"} {
	set black(radio:lastaction:$chan) [unixtime]
	}
	return
}

###
proc black:radio:chanmessage {nick host hand chan arg} {
	global black
if {![channel get $chan blackradio]} {
	return
	}
if {$black(radio_minutes_stop) != "0"} {
	set black(radio:lastaction:$chan) [unixtime]
	}
	return 0
}

###
proc radio:reset:dayshoutcasttime {minute hour day month year} {
	global black
	set chan $black(radio_chan)
if {[info exists black(radio:today_votes)]} {
	unset black(radio:today_votes)
}
if {[validchan $chan]} {
foreach user [userlist "-|D" $chan] {
	set day_time [getuser $user XTRA DAYSTREAMCONNECT]
if {$day_time != ""} {
	setuser $user XTRA DAYSTREAMCONNECT
	setuser $user XTRA STREAMVOTESTODAY
			}
		}
	}
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set file [open "radio_likes.txt" r]
	set day_seconds [expr [unixtime] + [expr $black(radio:like_expire) * 86400]]
	set temp "radio_likes.$timestamp"
	set tempwrite [open $temp w]
while {[gets $file line] != -1} {
	set read_time [lindex [split $line] 2]
	set day_seconds [expr $read_time + [expr $black(radio:like_expire) * 86400]]
if {[expr $day_seconds - [unixtime]] <= 0} {
	continue
		} else {
	puts $tempwrite $line
		}
	}
	close $tempwrite
	close $file
	file rename -force $temp "radio_likes.txt"
}

###
proc radio:minute:timer {min hour day mon year} {
	global black
if {![validchan $black(radio_chan)]} {
	return
}
if {![channel get $black(radio_chan) blackradio]} {
if {[info exists black(radio:status)]} {
	radio:reset
}
	return
}
	set chan $black(radio_chan)
	set stream_status [black:radio:getinfo "streamstatus"]
if {$stream_status == "0"} {
	radio:reset
	radio:topic:set $chan "" "offline"
	black:radio:show "radiooffline" ""
	return
}
if {![info exists black(radio:status)]} {
	set black(radio:status) 1
if {[info exists black(radio:dj_status)]} {
	set black(radio:dj_show) 1
	black:radio:show "radiostart" "$black(radio:dj_status)"
	radio:topic:set $chan $black(radio:dj_status) ""
	radio:dj:set $black(radio:dj_status)
	} else {
	radio:topic:set $chan "" ""
	black:radio:show "radiostart" "backup"
	set black(radio:backup_show) 1
	}
} else {
if {[info exists black(radio:dj_status)]} {
if {![info exists black(radio:dj_show)]} {
	radio:topic:set $chan $black(radio:dj_status) ""
	black:radio:show "radiostart" "$black(radio:dj_status)"
	set black(radio:dj_show) 1
		}
	} else {
if {![info exists black(radio:backup_show)]} {
	radio:topic:set $chan "" ""
	black:radio:show "radiostart" "backup"
	set black(radio:backup_show) 1
		}
	}
}
if {![info exists black(radio:currentsong)]} {
	set currentsong [black:radio:getinfo "currentsong"]
if {$currentsong == ""} {return}
	set black(radio:currentsong) $currentsong
	black:radio:show "currentsong" $black(radio:currentsong)
if {![info exists black(radio:dj_status)]} {
		set nextsong [black:radio:getinfo "nextsong"]
if {$nextsong != ""} {
		black:radio:show "nextsong" $nextsong
		}
	}
} else {
	set currentsong [black:radio:getinfo "currentsong"]
if {$currentsong == ""} {return}
if {$black(radio:currentsong) != $currentsong} {
	set black(radio:currentsong) $currentsong
	black:radio:show "currentsong" $currentsong
	if {![info exists black(radio:dj_status)]} {
		set nextsong [black:radio:getinfo "nextsong"]
if {$nextsong != ""} {
		black:radio:show "nextsong" $nextsong
				}
			}
		}
	}

if {$black(listeners_show_type) == 1} {
if {![info exists black(radio:listeners)]} {
	set black(radio:listeners) [black:radio:getinfo "currentlisteners_num"]
	black:radio:show "listeners" $black(radio:listeners)
	} else {
	set currentlisteners [black:radio:getinfo "currentlisteners_num"]
	set unique_listeners [lindex $currentlisteners 1]
	set currentlisteners [lindex $currentlisteners 0]
if {$black(radio:listeners) != $currentlisteners} {
	black:radio:show "listeners" [list $currentlisteners $unique_listeners]
	set black(radio:listeners) $currentlisteners
		}
	}
}
if {![info exists black(radio:bitrate)]} {
	set black(radio:bitrate) [black:radio:getinfo "bitrate"]
	utimer 15 [list black:radio:show "bitrate" $black(radio:bitrate)]
	} else {
	set currentbitrate [black:radio:getinfo "bitrate"]
if {$black(radio:bitrate) != $currentbitrate} {
	set black(radio:bitrate) $currentbitrate
	utimer 15 [list black:radio:show "bitrate" $black(radio:bitrate)]
		}
	}
}

###
proc black:radio:request {nick host hand chan arg} {
	global black
	set dj ""
	set text [split $arg]
if {[string equal -nocase $chan $black(radio_chan)]} {
if {![channel get $chan blackradio]} {
	return
}
if {![info exists black(radio:dj_status)]} {
	putserv "NOTICE $nick :$black(banner_radio) Hey \002$nick\002, Your request cannot be registered because there is NO online DJ."
	return
}
	set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }

if {$arg == ""} {
	putserv "NOTICE $nick :$black(banner_radio) Use !request <your request>"
	return
}
foreach user [chanlist $chan] {
	set handle [nick2hand $user]
if {[string equal -nocase $handle $black(radio:dj_status)]} {
	set dj $user
	}
}
if {$dj != ""} {
	putserv "PRIVMSG $dj :$black(banner_radio) Hey $dj, you got a \002request\002 from \002$nick\002 : \"$text\""
	putserv "NOTICE $nick :$black(banner_radio) Your request has been sent. Thank you ;-)"
		}
	}
}

###
proc radio:reset {} {
	global black
if {[info exists black(radio:dj_show)]} {
	unset black(radio:dj_show)
}
if {[info exists black(radio:backup_show)]} {
	unset black(radio:backup_show)
}
if {[info exists black(radio:status)]} {
	unset black(radio:status)
}
if {[info exists black(radio:dj_status)]} {
	unset black(radio:dj_status)
}
if {[info exists black(radio:currentsong)]} {
	unset black(radio:currentsong)
	}
if {[info exists black(radio:listeners)]} {
	unset black(radio:listeners)
	}
if {[info exists black(radio:bitrate)]} {
	unset black(radio:bitrate)
	}
if {[info exists black(radio:lastaction)]} {
	unset black(radio:lastaction)
	}
}

###
proc black:radio:vote {nick host hand chan arg} {
	global black
	set option [lindex [split $arg] 0]
	if {[string equal -nocase $chan $black(radio_chan)] || [string equal -nocase $chan $black(radio_backchan)]} {
	if {![channel get $chan blackradio] && [string equal -nocase $chan $black(radio_chan)]} {
		return
}
		set allow 0
		set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }
if {[string equal -nocase "reset" $option] && [matchattr $hand $black(radio_admin_flags) $chan]} {
	foreach user [userlist "-|D" $chan] {
		setuser $user XTRA STREAMVOTESTODAY
		setuser $user XTRA STREAMVOTES
				}
if {[info exists black(radio:today_votes)]} {
		unset black(radio:today_votes)
	}
		putserv "NOTICE $nick :$black(banner_radio) Reseted the votes for all DJ's."
		return
} elseif {[string equal -nocase "list" $option] && [matchattr $hand $black(radio_admin_flags) $chan]} {
	if {![info exists black(radio:today_votes)]} {
		putserv "NOTICE $nick :$black(banner_radio) No votes for TODAY."
	}
		putserv "NOTICE $nick :$black(banner_radio) Today's VOTES"
		set counter 0
	foreach entry $black(radio:today_votes) {
		incr counter
		set bywho [lindex $entry 0]
		set dj [lindex $entry 1]
		putserv "NOTICE $nick :$black(banner_radio) $counter.) \002DJ:\002 $dj ; \002HOSTNAME:\002 $bywho"
	}
	return
}
	if {![info exists black(radio:dj_status)]} {
		putserv "NOTICE $nick :$black(banner_radio) Hey \002$nick\002, There is no DJ Online for you to VOTE."
		return
	}
	set dj $black(radio:dj_status)
if {[string equal -nocase $dj $hand] || [string equal -nocase $dj $nick]} {
	putserv "NOTICE $nick :$black(banner_radio) You can't vote for yourself :P"
	return
}
if {![info exists black(radio:today_votes)]} {
	set allow 1
} else {
		set search [lsearch -nocase $black(radio:today_votes) [list $host "*"]]
if {$search > -1} {
		putserv "NOTICE $nick :$black(banner_radio) Hey \002$nick\002, you already voted your favorite DJ for today."
		return
	} else {set allow 1}
}
if {$allow == 1} {
	lappend black(radio:today_votes) [list $host $dj]
	set number [getuser $dj XTRA STREAMVOTES]
	set number_today [getuser $dj XTRA STREAMVOTESTODAY]
if {$number == ""} {
		setuser $dj XTRA STREAMVOTES 1
			}	else {
		setuser $dj XTRA STREAMVOTES [expr $number + 1]
			}
if {$number == ""} {
		setuser $dj XTRA STREAMVOTESTODAY 1
}	else {
		setuser $dj XTRA STREAMVOTESTODAY [expr $number_today + 1]
			}
		putserv "NOTICE $nick :$black(banner_radio) Your vote for the current DJ \002$dj\002 has been sent. Thank you ;-)"
		}
	}
}

###
proc radio:dj:set {dj} {
	global black
if {[validuser $dj]} {
if {[matchattr $dj -|D $black(radio_chan)]} {
	set stream_number [getuser $dj XTRA STREAMNUMBER]
if {$stream_number == ""} {
	set stream_number 0
}
	set stream_number [expr $stream_number + 1]
	setuser $dj XTRA STREAMNUMBER $stream_number
	setuser $dj XTRA CURRENTSTREAMCONNECT [unixtime]
		}
	}
}

###
proc radio:dj:unset {dj} {
	global black
if {[validuser $dj]} {
if {[matchattr $dj -|D $black(radio_chan)]} {
	set connecttime [getuser $dj XTRA CURRENTSTREAMCONNECT]
if {$connecttime == ""} { return }
	set dif_time [expr [unixtime] - $connecttime]
	set totaltime [getuser $dj XTRA TOTALSTREAMCONNECT]
	set daytime [getuser $dj XTRA DAYSTREAMCONNECT]
if {$totaltime == ""} {
	setuser $dj XTRA TOTALSTREAMCONNECT $dif_time
			} else {
	set totaltime [expr $dif_time + $totaltime]
	setuser $dj XTRA TOTALSTREAMCONNECT $totaltime
			}
if {$daytime == ""} {
	setuser $dj XTRA DAYSTREAMCONNECT $dif_time
			} else {
	set daytime [expr $dif_time + $daytime]
	setuser $dj XTRA DAYSTREAMCONNECT $daytime
			}
		}
	}
}

###
proc black:radio:show {type arg} {
	global black
	set channels ""
foreach chan [channels] {
if {[channel get $chan blackradio]} {
	lappend channels $chan
	}
}
if {$channels != ""} {
	black:radio:show:all $type $arg 0 $channels
	}
}

###
proc black:radio:show:all {type arg num channels} {
	global black
	set chan [lindex $channels $num]
	set inc 0
if {$black(radio_minutes_stop) != "0"} {
if {![info exists black(radio:lastaction:$chan)]} {
	set black(radio:lastaction:$chan) [unixtime]
}
if {[expr $black(radio:lastaction:$chan) + [expr $black(radio_minutes_stop) * 60]] <= [unixtime]} {
	set inc [expr $num + 1]
if {[lindex $channels $inc] != ""} {
	utimer 5 [list black:radio:show:all $type $arg $inc $channels]
	}
	return
	}
}
	switch $type {
	bitrate {
		putserv "PRIVMSG $chan :$black(banner_radio) Bitrate is set to \00304\002$arg\002\003 kbps."
	}
	listeners {
	set current_listeners [lindex $arg 0]
	set unique_listeners [lindex $arg 1]
if {$unique_listeners != ""} {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003 ($unique_listeners unique)"
	} else {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003"
		}
	}

	djquit {
	putserv "PRIVMSG $chan :$black(banner_radio) Dj \0032\002$black(radio:dj_status)\002\003 is out."
	}

	backup {
	set text [black:radio:getinfo "currentlisteners_num"]
	set current_listeners [lindex $text 0]
	set unique_listeners [lindex $text 1]
	putserv "PRIVMSG $chan :$black(banner_radio) Backup is active at \00304\002$black(radio_stream)\002\003"
	if {$unique_listeners != ""} {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003 ($unique_listeners unique)"
	} else {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003"
		}
}

	newdj {
	set text [black:radio:getinfo "currentlisteners_num"]
	set current_listeners [lindex $text 0]
	set unique_listeners [lindex $text 1]
	putserv "PRIVMSG $chan :$black(banner_radio) Ahora ONLINE \003\002$black(radio_stream)\002\003 new DJ is ON"
	putserv "PRIVMSG $chan :$black(banner_radio) El actual dj es : \00304\002$black(radio:dj_status)\002"
	putserv "PRIVMSG $chan :$black(banner_radio) Use : \00304\002!request <link> <message>\002\00304 if you want to dedicate a song to someone"
	if {$unique_listeners != ""} {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003 ($unique_listeners unique)"
	} else {
		putserv "PRIVMSG $chan :$black(banner_radio) Current listeners : \00304\002$current_listeners\002\003"
		}
	}

	currentsong {
if {$black(listeners_show_type) == 1} {
if {[info exists black(radio:dj_status)]} {
	putserv "PRIVMSG $chan :$black(banner_radio) DJ - \00304\002$black(radio:dj_status)\002\003 on \00304\002$black(radio_stream)\002\003 with\00304 \"$arg\"\003 - \00304\002$black(radio_stream_url)\002\003"
	} else {
	putserv "PRIVMSG $chan :$black(banner_radio) Ahora ONLINE \00304\002$black(radio_stream)\002\003 Sintoniza\00304 \"$arg\"\003 - \00304\002$black(radio_stream_url)\002\003"
			}
		} else {
		set listeners [black:radio:getinfo "currentlisteners_num"]
		set listeners [lindex $listeners 0]
if {[info exists black(radio:dj_status)]} {
	putserv "PRIVMSG $chan :$black(banner_radio) DJ - \00304\002$black(radio:dj_status)\002\003 on \00304\002$black(radio_stream)\002\003 with\00304 \"$arg\"\003 and \002\00304$listeners\003\002 listeners ($unique_listeners unique) - \00304\002$black(radio_stream_url)\002\003"
		} else {
	putserv "PRIVMSG $chan :$black(banner_radio) Ahora en \00304\002$black(radio_stream)\002\003 Tema:\00304 \"$arg\"\003 con \002\00304$listeners\003\002 oyentes - \00304\002$black(radio_stream_url)\002\003"
			}
		}
	}
	nextsong {
	putserv "PRIVMSG $chan :$black(banner_radio) el siguiente tema: \00304 \"$arg\"\003"
	}
	radiostart {
if {$arg == "backup"} {
	putserv "PRIVMSG $chan :$black(banner_radio) \00304\002$black(radio_stream)\002\003 is started with \002BACKUP\002"
	} else {
		putserv "PRIVMSG $chan :$black(banner_radio) \00304\002$black(radio_stream)\002\003 ONLINE."
		putserv "PRIVMSG $chan :$black(banner_radio) DJ : \00304\002$arg\002\003"
	}
	set text [black:radio:getinfo "currentlisteners_num"]
	set current_listeners [lindex $text 0]
	set unique_listeners [lindex $text 1]
	if {$unique_listeners != ""} {
			putserv "PRIVMSG $chan :$black(banner_radio) Cantidad de Oyentes Unicos : \00304\002$current_listeners\002\003 ($unique_listeners unique)"
		} else {
			putserv "PRIVMSG $chan :$black(banner_radio) Cantidad de Oyentes : \00304\002$current_listeners\002\003"
			}
		}
	radiooffline {
		putserv "PRIVMSG $chan :$black(banner_radio) \00304\002$black(radio_stream)\002\003 OFFLINE. Volveremos en breve.."
		}
	}
	set inc [expr $num + 1]
if {[lindex $channels $inc] != ""} {
	utimer 5 [list black:radio:show:all $type $arg $inc $channels]
	}
}

###
proc black:radio:dj {nick host hand chan arg} {
	global black
if {[string equal -nocase $chan $black(radio_backchan)]} {
	set chan1 $chan
	set chan $black(radio_chan)
} else {
	set chan1 $chan
}
	set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }
	set cmd [lindex [split $arg] 0]
	set total [lindex [split $arg] 1]
switch $cmd {
	help {
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
		putserv "NOTICE $nick :HELP : \002$black(radio_char)dj\002 add <nick> <host> ; \002$black(radio_char)dj\002 del <nick> ; \002$black(radio_char)dj\002 list ; \002$black(radio_char)dj\002 on ; \002$black(radio_char)dj\002 off ; \002$black(radio_char)dj\002 top ; \002$black(radio_char)dj\002 info <nick> ; \002$black(radio_char)dj\002 reset <nick>"
	}
}
	on {
if {![matchattr $hand -|D $chan]} {
	return
}
if {[info exists black(radio:dj_status)]} {
if {[string equal -nocase $black(radio:dj_status) $hand]} {
	puthelp "NOTICE $nick :$black(banner_radio) You are already set up online as a DJ"
	return
	} else {
	radio:dj:unset $black(radio:dj_status)
	puthelp "NOTICE $nick :$black(banner_radio) You set yourself up online as a DJ (The current DJ \002$black(radio:dj_status)\002 is removed from the broadcast)"
	black:radio:show "djquit" $black(radio:dj_status)
	set black(radio:dj_status) $hand
	black:radio:show "newdj" $hand
	radio:dj:set $hand
	radio:topic:set $chan $black(radio:dj_status) ""
if {![info exists black(radio:backup_show)]} {
	unset black(radio:backup_show)
}
	return
	}
} else {
	puthelp "NOTICE $nick :$black(banner_radio) You set yourself up online as a DJ"
if {![info exists black(radio:dj_show)]} {
	set black(radio:dj_show) 1
}
if {![info exists black(radio:backup_show)]} {
	unset black(radio:backup_show)
}
	radio:dj:set $hand
	set black(radio:dj_status) $hand
	black:radio:show "newdj" $hand
	radio:topic:set $chan $black(radio:dj_status) ""
	return
	}
}
	off {
if {![matchattr $hand -|D $chan]} {
	return
}
if {![info exists black(radio:dj_status)]} {
	puthelp "NOTICE $nick :$black(banner_radio) There is no OnLine DJ !"
	return
}
if {[string equal -nocase $black(radio:dj_status) $hand]} {
	radio:dj:unset $hand
	puthelp "NOTICE $nick :$black(banner_radio) You're out from the broadcast !"
	black:radio:show "djquit" $black(radio:dj_status)
	radio:topic:set $chan "" ""
	black:radio:show "radiostart" "backup"
if {![info exists black(radio:backup_show)]} {
	set black(radio:backup_show) 1
}
if {![info exists black(radio:dj_show)]} {
	unset black(radio:dj_show)
}
	unset black(radio:dj_status)
	return
} else {
	puthelp "NOTICE $nick :$black(banner_radio) You are not online as a DJ !"
	return
}
	}
	top {
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
	array set djs [list]
	array set votedjs [list]

	set total_top 0
	set num 0
	set vnum 0
	set text ""
	set vote_text ""
if {[string equal -nocase $total "total"]} {
	set total_top 1
}
foreach user [userlist "-|D" $chan] {
if {$total_top == "1"} {
	set get_time [getuser $user XTRA TOTALSTREAMCONNECT]
	set get_votes [getuser $user XTRA STREAMVOTES]
			} else {
	set get_time [getuser $user XTRA DAYSTREAMCONNECT]
	set get_votes [getuser $user XTRA STREAMVOTESTODAY]
			}
if {$get_time != ""} {
	lappend djs($get_time) $user
			}
if {$get_votes != ""} {
	lappend votedjs($get_votes) $user
	}
}
foreach u [lsort -integer -decreasing [array names djs]] {
	set num [expr $num + 1]
if {$num <= 10} {
	lappend text "$num. \002[join $djs($u)]\002 ([duration $u])"
			}
		}
foreach u [lsort -integer -decreasing [array names votedjs]] {
	set vnum [expr $vnum + 1]
if {$vnum <= 10} {
	lappend vote_text "$vnum. \002[join $votedjs($u)]\002 ($u)"
			}
		}
if {$text == ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) There are no DJ's in the TOP."
	return
}
if {$total_top == "0"} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Top \002DJ\002 for \00304\002$black(radio_stream)\002"
} else {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Top \002DJ\002 total for \00304\002$black(radio_stream)\002"
}
	putserv "PRIVMSG $chan1 :$black(banner_radio) \002BROADCASTING TIME\002 --- [join $text]"
if {$vote_text != ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) \002VOTES\002 --- [join $vote_text]"
		}
	}
}
	add {
if {[matchattr $hand mn]} {
	set user [lindex [split $arg] 1]
	set hostname [lindex [split $arg] 2]
if {[validuser $user]} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002 already exists, it is set as \002DJ\002"
	chattr $user "-|D" $chan
				} else {
if {![onchan $user $chan]} {
if {$hostname == ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) For help use \002!dj help\002"
	return
				} else {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \00304\002$user\002\003 is added as \002DJ\002 with host \00304\002$hostname\002"
	adduser $user $hostname
	chattr $user "-|D" $chan
				}
			} else {
	set hand [nick2hand $user]
if {[validuser $hand]} {
	chattr $hand "-|D" $chan
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002($hand) already exists, he is set as \002DJ\002"
} else {
	set hostname "*!*@[lindex [split [getchanhost $user $chan] @] 1]"
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \00304\002$user\002\003 is added as \002DJ\002 with host \00304\002$hostname\002"
	adduser $user $hostname
	chattr $user "-|D" $chan
					}
				}
			}
		}
	}
	list {
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
	set list [userlist -|D $chan]
	putserv "PRIVMSG $chan1 :$black(banner_radio) DJ LIST - \002$black(radio_stream)\002"
if {$list == ""} { set list "N/A"
	return
}
foreach user $list {
	set day_time [getuser $user XTRA DAYSTREAMCONNECT]
	set get_time [getuser $user XTRA TOTALSTREAMCONNECT]
	set last_stream [getuser $user XTRA CURRENTSTREAMCONNECT]
if {$day_time == ""} { set day_time 0}
if {$get_time == ""} { set get_time 0}
if {$last_stream == ""} {set last_stream "N/A"}
if {$get_time != 0} {
	set get_time [duration $get_time]
} else {
	set get_time "N/A"
}
if {$day_time != 0} {
	set day_time [duration $day_time]
} else {
	set day_time "N/A"
		}
		putserv "PRIVMSG $chan1 :$black(banner_radio) $user - Total broadcast time:\00304$get_time\003; Today:\00304$day_time\003 ; Last Stream: \00304 [ctime $last_stream]"
		}
	}
}
	del {
if {[matchattr $hand mn]} {
	set user [lindex [split $arg] 1]
	set theuser $user
	set otheruser 0
if {$user == ""} {
	putserv "NOTICE $nick :$black(banner_radio) For help use \002!dj help\002"
	return
			}
if {![validuser $user]} {
	set user [nick2hand $user]
	set otheruser 1
}
if {![validuser $user]} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$theuser\002 does not exist."
			} elseif {![matchattr $user -|D $chan]} {
if {$otheruser == "1"} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002($theuser) is not set as \002DJ\002."
} else {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002 is not set as \002DJ\002."
}
			} else {
if {$otheruser == "1"} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002($theuser) has been deleted from \002DJ\002 list."
} else {
	putserv "PRIVMSG $chan1 :$black(banner_radio) User \002$user\002 has been deleted from \002DJ\002 list."
}
	chattr $user "-|-D" $chan
			}
		}
	}
	info {
if {[matchattr $hand -|D $chan] || [matchattr $hand $black(radio_admin_flags) $chan]} {
	set user [lindex [split $arg] 1]
if {$user == ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Use !dj info <user>"
	return
}
if {![validuser $user]} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) DJ \002$user\002 does not exist in the database."
	return
}
if {![matchattr $user -|D $chan]} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Dj \002$user\002 is not set as DJ."
	return
}
	set stream_number [getuser $user XTRA STREAMNUMBER]
	set lasttime_connect [getuser $user XTRA CURRENTSTREAMCONNECT]
	set total_connect [getuser $user XTRA TOTALSTREAMCONNECT]
	set day_connect [getuser $user XTRA DAYSTREAMCONNECT]
	set current [getuser $user XTRA CURRENTSTREAMCONNECT]
	set votes [getuser $user XTRA STREAMVOTES]
	set votes_today [getuser $user XTRA STREAMVOTESTODAY]
if {$stream_number == ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Dj \002$user\002 has not entered in broadcast."
	return
}
putserv "PRIVMSG $chan1 :$black(banner_radio) Dj \00304\002$user\002\003 has \00304$stream_number\003 broadcast entries."
putserv "PRIVMSG $chan1 :$black(banner_radio) The last time he logged in was on : \00304\002[ctime $lasttime_connect]\002"
if {[info exists black(radio:dj_status)]} {
if {[string equal -nocase $black(radio:dj_status) $user]} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Is currently airing : \00304\002[duration [expr [unixtime] - $current]]\002"
	return
	}
}
if {$total_connect == ""} { return }
if {$total_connect != "" && $day_connect == ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Has a total of \00304\002[duration $total_connect]\002\003 in broadcast."
}
if {$total_connect != "" && $day_connect != ""} {
	putserv "PRIVMSG $chan1 :$black(banner_radio) Has a total of \00304\002[duration $total_connect]\002\003 in broadcast of which \00304\002[duration $day_connect]\002\003 today."
	}
if {$votes != ""} {
if {$votes_today == ""} { set votes_today 0}
	putserv "PRIVMSG $chan1 :$black(banner_radio) Total number of votes:\00304\002$votes\002\003. Votes today:\00304\002$votes_today\002\003"
		}
	}
}
	reset {
if {[matchattr $hand mn]} {
	set user [lindex [split $arg] 1]
	setuser $user XTRA STREAMNUMBER
	setuser $user XTRA CURRENTSTREAMCONNECT
	setuser $user XTRA TOTALSTREAMCONNECT
	setuser $user XTRA DAYSTREAMCONNECT
	setuser $user XTRA STREAMVOTESTODAY
	setuser $user XTRA STREAMVOTES
	putserv "PRIVMSG $chan1 :$black(banner_radio) Reset the DJ activity for \002$user\002"
}
	}
	default {
	if {[info exists black(radio:dj_status)]} {
		putserv "PRIVMSG $chan : DJ - \00304\002$black(radio:dj_status)\002"
} else {
putserv "PRIVMSG $chan :There is NO online DJ."
			}
		}
	}
}

###
proc black:radio:cmd {nick host hand chan arg} {
	global black
	set cmd [lindex [split $arg] 0]
	set id [lindex [split $arg] 1]
	set counter 0
	set text ""
	set flood_check [blackradio:flood:prot $chan $host]
if {$flood_check == "1"} { return }
switch $cmd {
	uptime {
	set uptime [black:radio:getinfo "streamuptime"]
	putserv "PRIVMSG $chan :$black(banner_radio) Uptime \002$black(radio_stream)\002 : $uptime"
	}
	default {
	set currentsong [black:radio:getinfo "currentsong"]
		black:radio:show "currentsong" $currentsong
		}
	}
}

###
proc black:radio:getinfo {type} {
	global black
	set counter 0
	set info ""
if {$type == "currentsong"} {
	set info [black:radio:get "song"]
	return $info
} elseif {$type == "peaklisteners"} {
	set info [black:radio:get "peak"]
	return $info
} elseif {$type == "streamuptime"} {
	set info [black:radio:get "uptime"]
	return $info
} elseif {$type == "streamstatus"} {
	set info [black:radio:get "listeners"]
if {$info == -1} {
	return 0
} else {
	return 1
	}
} elseif {$type == "streamname"} {
	return $black(radio_stream)
} elseif {$type == "website"} {
	return $black(radio_stream_url)
} elseif {$type == "currentlisteners_num"} {
	set info [black:radio:get "listeners"]
	return $info
} elseif {$type == "bitrate"} {
	set info [black:radio:get "bitrate"]
	return $info
} elseif {$type == "nextsong"} {
	set info [black:radio:get "nextsong"]
	return $info
	}
}

###
proc black:radio:get {type} {
	global black
	set data [black:radio:getdata]
if {$data == "-1"} { return -1 }
if {[string equal -nocase $type "song"]} {
	return [black:radio:get_song $data]
} elseif {[string equal -nocase $type "listeners"]} {
	return [black:radio:get_listeners $data]
	} elseif {[string equal -nocase $type "bitrate"]} {
	return [black:radio:get_bitrate $data]
	} elseif {[string equal -nocase $type "uptime"]} {
	return [black:radio:getuptime $data]
	} elseif {[string equal -nocase $type "peak"]} {
	return [black:radio:get_peak $data]
			} elseif {[string equal -nocase $type "nextsong"]} {
	return [black:radio:nextsong $data]
		}
}

###
proc black:radio:get_bitrate {data} {
	global black
	set info ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<BITRATE>(.*)</BITRATE>} $firstline info
	set info [black:radio:filter $info]
	return $info
}

###
proc black:radio:getuptime {data} {
	global black
	set info ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<STREAMUPTIME>(.*)</STREAMUPTIME>} $firstline info
	set info [black:radio:filter $info]
	return [duration $info]
}

###
proc black:radio:nextsong {data} {
	global black
	set info ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<NEXTTITLE>(.*)</NEXTTITLE>} $firstline info
	set info [black:radio:filter $info]
	return [encoding convertfrom utf-8 $info]
}

###
proc black:radio:get_song {data} {
	global black
	set info ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<SONGTITLE>(.*)</SONGTITLE>} $firstline -> info
if {$info == ""} {
	regexp {<TITLE>(.*)</TITLE>} $firstline info
}
	putlog $info
	set info [black:radio:filter $info]
if {[string match -nocase "*<METADATA>*" $info]} {
	set info [blackradio:wsplit $info "<METADATA>"]
	set info [lindex $info 0]
}
	return [encoding convertfrom utf-8 $info]
}

###
proc black:radio:get_listeners {data} {
	global black
	set info ""
	set info2 ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<CURRENTLISTENERS>(.*)</CURRENTLISTENERS>} $firstline info
	regexp {<UNIQUELISTENERS>(.*)</UNIQUELISTENERS>} $firstline info2
	set info [black:radio:filter $info]
	set info2 [black:radio:filter $info2]
	return [list $info $info2]
}

###
proc tls:socket args {
   set opts [lrange $args 0 end-2]
   set host [lindex $args end-1]
   set port [lindex $args end]
   ::tls::socket -servername $host {*}$opts $host $port
}

###
proc black:radio:get_peak {data} {
	global black
	set info ""
	set output [split $data "\n"]
	set firstline [lindex $output 0]
	regexp {<PEAKLISTENERS>(.*)</PEAKLISTENERS>} $firstline info
	set info [black:radio:filter $info]
	return $info
}

###
proc black:radio:getdata {} {
	global black
if {$black(radio_version) == 1} {
	black:radio:getdata_v1
	} else {
	black:radio:getdata_v2
	}
}

###
proc black:radio:getdata_v1 {} {
	global black
	set split_info [split $black(radio_ip) ":"]
	set ip [lindex $split_info 0]
	set port [lindex $split_info 1]
if {[catch {set sock [socket -async $ip $port] } sockerror]} {
	putlog "$black(banner_radio): $sockerror"
	return 0
	} else {
	fconfigure $sock -blocking 0
	puts $sock "GET /admin.cgi?pass=$black(radio_pass)&sid=1&mode=viewxml&page=0 HTTP/1.0"
	puts $sock "User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9)"
	puts $sock "Host: $black(radio_ip)"
	puts $sock "Connection: close"
	puts $sock ""
	flush $sock
while {[eof $sock] != 1} {
	set bl [gets $sock]
}
	close $sock
}
if {[info exists bl]} {
	return $bl
	} else {return 0}
}

###
proc black:radio:getdata_v2 {} {
	global black
	set pass [::http::formatQuery pass $black(radio_pass)]
if {[regexp {https://} $black(radio_stream_url)]} {
	set link "https://$black(radio_ip)/admin.cgi$pass&sid=1&mode=viewxml"
	http::register https 443 [list tls::socket]
} else {
	set link "http://$black(radio_ip)/admin.cgi?$pass&sid=1&mode=viewxml"
}
	set ipq [http::config -useragent "lynx"]
	set error [catch {set ipq [http::geturl $link -timeout 10000]} eror]
	set status [http::status $ipq]
if {$status != "ok"} {
	::http::cleanup $ipq
	return 0
}
	set getipq [http::data $ipq]
	::http::cleanup $ipq
	return $getipq
}

###
proc black:radio:filter {data} {
	global black
	set text [string map {
							"</SONGTITLE>" ""
							"<SONGTITLE>" ""
							"</NEXTTITLE>" ""
							"<NEXTTITLE>" ""
							"</STREAMUPTIME>" ""
							"<STREAMUPTIME>" ""
							"</PEAKLISTENERS>" ""
							"<PEAKLISTENERS>" ""
							"</STREAMSTATUS>" ""
							"<STREAMSTATUS>" ""
							"</CURRENTLISTENERS>" ""
							"<CURRENTLISTENERS>" ""
							"</BITRATE>" ""
							"<BITRATE>" ""
							"<TITLE>" ""
							"</TITLE>" ""
							"</UNIQUELISTENERS>" ""
							"<UNIQUELISTENERS>" ""
							"&amp;" "&"
							"&apos;" "'"
							   			} $data]
	return $text
}

###
#http://wiki.tcl.tk/989
proc blackradio:wsplit {string sep} {
    set first [string first $sep $string]
    if {$first == -1} {
        return [list $string]
    } else {
        set l [string length $sep]
        set left [string range $string 0 [expr {$first-1}]]
        set right [string range $string [expr {$first+$l}] end]
        return [concat [list $left] [blackradio:wsplit $right $sep]]
    }
}

#OBF
# Credits
set bradio(projectName) "BlackRadio - SHOUTCAST Edition"
set bradio(author) "BLaCkShaDoW"
set bradio(website) "wWw.TCLScriptS.NeT"
set bradio(email) "blackshadow\[at\]tclscripts.net"
set bradio(version) "v1.0"
#/OBF

###
proc blackradio:flood:prot {chan host} {
	global blackradio
	set number [scan $blackradio(flood_prot) %\[^:\]]
	set timer [scan $blackradio(flood_prot) %*\[^:\]:%s]
if {[info exists blackradio(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*blackradio:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists blackradio(flood:$host:$chan)]} {
	set blackradio(flood:$host:$chan) 0
}
	incr blackradio(flood:$host:$chan)
	utimer $timer [list blackradio:remove:flood $host $chan]
if {$blackradio(flood:$host:$chan) > $number} {
	set blackradio(flood:$host:$chan:act) 1
	utimer [expr $blackradio(ignore_prot) * 60] [list blackradio:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}

###
proc blackradio:expire:flood {host chan} {
	global blackradio
if {[info exists blackradio(flood:$host:$chan:act)]} {
	unset blackradio(flood:$host:$chan:act)
	}
}

###
proc blackradio:remove:flood {host chan} {
	global blackradio
if {[info exists blackradio(flood:$host:$chan)]} {
	unset blackradio(flood:$host:$chan)
	}
}

putlog "\002$bradio(projectName) $bradio(version)\002 by\002 $bradio(author)\002 ($bradio(website)): Loaded & initialised.."

##################
#######################################################################################################
###                  *** END OF BLACKRADIO TCL ***                                                 ###
#######################################################################################################