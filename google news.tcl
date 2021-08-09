#############################################################################
## BlackNews.tcl 1.1  (04/08/2019)  			                           ##
##                                                                         ##
##                              Copyright 2008 - 2019 @ WwW.TCLScripts.NET ##
##         _   _   _   _   _   _   _   _   _   _   _   _   _   _           ##
##        / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \          ##
##       ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )         ##
##        \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/          ##
##                                                                         ##
##                       ® BLaCkShaDoW Production ®                        ##
##                                                                         ##
##                                PRESENTS                                 ##
##									                                     ® ##
############################   BLACK NEWS TCL   #############################
##									                                       ##
##  DESCRIPTION: 							                               ##
##  Uses google news to print, on channels in real-time, the worldwide news##
##  published by the most important websites from all over the web.        ##
##  You can see different kinds of news covered by the same keywords, from ##
##  different sources or writted in different languages.                   ##
##									                                       ##
##  Tested on Eggdrop v1.8.3 (Debian Linux) Tcl version: 8.6.6             ##
##									                                       ##
#############################################################################
##								                                           ##
##  INSTALLATION: 						                                   ##
##  ++ http, json & tls packages are REQUIRED for this script to work.     ##
##  ++ Edit BlackNews.tcl script & place it into your /scripts directory.  ##
##  ++ add "source scripts/BlackNews.tcl" to your eggdrop.conf & rehash.   ##
##								                                           ##
#############################################################################
##									                                       ##
##  OFFICIAL LINKS:                                                        ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                           ##
##   Bugs report : http://www.tclscripts.net                               ##
##   GitHub page : https://github.com/tclscripts/ 			               ##
##   Online help : irc://irc.undernet.org/tcl-help                         ##
##                 #TCL-HELP / UnderNet        	                           ##
##                 You can ask in english or romanian                      ##
##									                                       ##
##     paypal.me/DanielVoipan = Please consider a donation. Thanks!        ##
##									                                       ##
#############################################################################
##									                                       ##
##           You want a customised TCL Script for your eggdrop?            ##
##               Easy-peasy, just tell me what you need!                   ##
##  I can create almost anything in TCL based on your ideas and donations. ##
##    Email blackshadow@tclscripts.net or info@tclscripts.net with your    ##
##      request informations and I'll contact you as soon as possible.     ##
##									                                       ##
#############################################################################
##								                                           ##
##  COMMANDS:                                                              ##
##								                                           ##
##  To activate:                                                           ##
##  .chanset +BlackNews | from BlackTools: .set #channel +BlackNews        ##
##                                                                         ##
##  !bnews [?|help] - shows all available commands.                        ##
##                                                                         ##
##  !bnews max <no.> - set maximum number of news to output.               ##
##                                                                         ##
##  !bnews <search terms> - shows a <no.> of news matching that criteria.  ##
##								                                           ##
##  !bnews save <keywords> [l=lang] [m=<max>] [c=<country>]                ##     
##								                                           ##
##  !bnews list - prints a list with saved news keywords.                  ##
##								                                           ##
##  !bnews country <country abbrev.> - defines default country for news.   ##
##								                                           ##
##  !bnews del <keywords> - removes <keywords> from automatic news output. ##
##								                                           ##
##  !bnews lang [ro|en] - sets the language for script messages.           ##
##								                                           ##
##  !bnews newslang [ro|en] - sets the language for output articles.       ##
##                                                                         ##
##  !bnews version - returns the script version.                           ##
##                                                                         ##
#############################################################################
##                                                                         ##
##  EXAMPLES:                                                              ##
##									                                       ##
## <user> !bnews lang en                                                   ##
## -bot- [NEWS] Set default script language as: en (English).              ##
##                                                                         ##
## <user> !bnews newslang en                                               ##
## -bot- [NEWS] Set default news language as: en (English).                ##
##                                                                         ##
## Search for a specific keyword(s):                                       ##
## <user> !bnews google                                                    ##
## <bot> www.forbes.com (google): Buy Amazon, Apple And Google Slowly      ##
##       http://tinyurl.com/yafffla5 ; Date: Sun, 25 Nov 2018 19:09:49 GMT ##
## <bot> www.theverge.com (google): Google settled with a contractor after ##
##       complaints of racial profiling - http://tinyurl.com/ybn9xnst      ##
##       Date: Sun, 25 Nov 2018 19:56:31 GMT                               ##
## <bot> searchengineland.com (google): Google showing zero results again  ##
##       for many time, calculations & conversions search results          ##
##       http://tinyurl.com/y8azvt2p ; Date: Mon, 26 Nov 2018 01:00:15 GMT ##
##                                                                         ##
## List saved news keyword(s):                                             ##
## <user> !bnews list                                                      ##
## -bot- [NEWS] #1. KeyWord: dragnea ; Lang: ro ; Country: - ; Max: 3      ##
## -bot- [NEWS] #4. KeyWord: btc ; Lang: en ; Country: - ; Max: 3          ##
## -bot- [NEWS] #5. KeyWord: brexit ; Lang: ro ; Country: - ; Max: 3       ##
## -bot- [NEWS] #6. KeyWord: coindesk ; Lang: en ; Country: - ; Max: 3     ##
##                                                                         ##
#############################################################################
##								                                           ##
##  PERSONAL AND NON-COMMERCIAL USE LIMITATION.                            ##
##                                                                         ##
##  This program is provided on an "as is" and "as available" basis,       ##
##  with ABSOLUTELY NO WARRANTY. Use it at your own risk.                  ##
##                                                                         ##
##  Use this code for personal and NON-COMMERCIAL purposes ONLY.           ##
##                                                                         ##
##  Unless otherwise specified, YOU SHALL NOT copy, reproduce, sublicense, ##
##  distribute, disclose, create derivatives, in any way ANY PART OF       ##
##  THIS CONTENT, nor sell or offer it for sale.                           ##
##                                                                         ##
##  You will NOT take and/or use any screenshots of this source code for   ##
##  any purpose without the express written consent or knowledge of author.##
##                                                                         ##
##  You may NOT alter or remove any trademark, copyright or other notice   ##
##  from this source code.                                                 ##
##                                                                         ##
##              Copyright 2008 - 2018 @ WwW.TCLScripts.NET                 ##
##                                                                         ##
#############################################################################

#############################################################################
##                              CONFIGURATIONS                             ##
#############################################################################
###
# Tooken
#Visit https://gapi.xyz/ to get your free key now  ;-)
#
set blacknews(tooken) "dd809304701c2a0fb01997e976debfaf"
###

###
# Cmdchar trigger
# + set here the trigger you want to use.
set blacknews(cmd_char) ">"

###
# Set here who can execute the command (-|- for all)
set blacknews(ip_flags) "mno"

###
# Set the default script language.
set blacknews(show_lang) "es"

###
# Set the default origin (country) of the news that you want to get.
set blacknews(default_lang) "ES"

###
# The maximum number of news you wish to output.
# + max value 20 ; min value 1
set blacknews(max_news) "3"

###
# Available tokens in the response format:
#  %title%		- the article title
#  %website%	- the website source name
#  %link%		- the article link
#  %date%		- the article date
#  %keyword%	- the article keywords
###
# The template you would like the news to be outputted
set blacknews(output_line) "\002%website%\002 (%keyword%): %title% ; %link% ; Date: %date%"

###
# Checking interval time for new news. How often (in minutes) you want be checked.
set blacknews(minutes_show) "5"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 3:10, which allows for upto 3 queries in 10 seconds. 3 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set blacknews(flood_prot) "3:10"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders, 0 to disable flood protection
###
set blacknews(ignore_prot) "1"

##############################################################################
###        DO NOT MODIFY HERE UNLESS YOU KNOW WHAT YOU'RE DOING            ###
##############################################################################

package require http
package require json
package require tls

###
# Bindings
# + using commands
bind pub $blacknews(ip_flags) $blacknews(cmd_char)bnews blacknews:act

###
# Channel flags
setudef str blacknews.showlang
setudef str blacknews.lang
setudef str blacknews.country
setudef int blacknews.max
setudef flag blacknews

###
set blacknews(country_list) {
"Afrikaans" "af"
"Akan" "ak"
"Albanian" "sq"
"Amharic" "am"
"Arabic" "ar"
"Armenian" "hy"
"Azerbaijani" "az"
"Basque" "eu"
"Belarusian" "be"
"Bemba" "bem"
"Bengali" "bn"
"Bihari" "bh"
"Bosnian" "bs"
"Breton" "br"
"Bulgarian" "bg"
"Cambodian" "km"
"Catalan" "ca"
"Cherokee" "chr"
"Chichewa" "ny"
"Chinese(Simplified)" "zh-CN"
"Chinese(Traditional)" "zh-TW"
"Corsican" "co"
"Croatian" "hr"
"Czech" "cs"
"Danish" "da"
"Dutch" "nl"
"English" "en"
"Esperanto" "eo"
"Estonian" "et"
"Ewe" "ee"
"Faroese" "fo"
"Filipino" "tl"
"Finnish" "fi"
"French" "fr"
"Frisian" "fy"
"Ga" "gaa"
"Galician" "gl"
"Georgian" "ka"
"German" "de"
"Greek" "el"
"Guarani" "gn"
"Gujarati" "gu"
"Hacker" "xx-hacker"
"Haitian Creole" "ht"
"Hausa" "ha"
"Hawaiian" "haw"
"Hebrew" "iw"
"Hindi" "hi"
"Hungarian" "hu"
"Icelandic" "is"
"Igbo" "ig"
"Indonesian" "id"
"Interlingua" "ia"
"Irish" "ga"
"Italian" "it"
"Japanese" "ja"
"Javanese" "jw"
"Kannada" "kn"
"Kazakh" "kk"
"Kinyarwanda" "rw"
"Kirundi" "rn"
"Klingon" "xx-klingon"
"Kongo" "kg"
"Korean" "ko"
"Krio(Sierra Leone)" "kri"
"Kurdish" "ku"
"Kurdish(Soranî)" "ckb"
"Kyrgyz" "ky"
"Laothian" "lo"
"Latin" "la"
"Latvian" "lv"
"Lingala" "ln"
"Lithuanian" "lt"
"Lozi" "loz"
"Luganda" "lg"
"Luo" "ach"
"Macedonian" "mk"
"Malagasy" "mg"
"Malay" "ms"
"Malayalam" "ml"
"Maltese" "mt"
"Maori" "mi"
"Marathi" "mr"
"Mauritian Creole" "mfe"
"Moldavian" "mo"
"Mongolian" "mn"
"Montenegrin" "sr-ME"
"Nepali" "ne"
"Nigerian Pidgin" "pcm"
"Northern Sotho" "nso"
"Norwegian" "no"
"Norwegian(Nynorsk)" "nn"
"Occitan" "oc"
"Oriya" "or"
"Oromo" "om"
"Pashto" "ps"
"Persian" "fa"
"Pirate" "xx-pirate"
"Polish" "pl"
"Portuguese(Brazil)" "pt-BR"
"Portuguese(Portugal)" "pt-PT"
"Punjabi" "pa"
"Quechua" "qu"
"Romanian" "ro"
"Romansh" "rm"
"Runyakitara" "nyn"
"Russian" "ru"
"Scots Gaelic" "gd"
"Serbian" "sr"
"Serbo-Croatian" "sh"
"Sesotho" "st"
"Setswana" "tn"
"Seychellois Creole" "crs"
"Shona" "sn"
"Sindhi" "sd"
"Sinhalese" "si"
"Slovak" "sk"
"Slovenian" "sl"
"Somali" "so"
"Spanish" "sp"
"Spanish(Latin American)" "sp-419"
"Sundanese" "su"
"Swahili" "sw"
"Swedish" "sv"
"Tajik" "tg"
"Tamil" "ta"
"Tatar" "tt"
"Telugu" "te"
"Thai" "th"
"Tigrinya" "ti"
"Tonga" "to"
"Tshiluba" "lua"
"Tumbuka" "tum"
"Turkish" "tr"
"Turkmen" "tk"
"Twi" "tw"
"Uighur" "ug"
"Ukrainian" "uk"
"Urdu" "ur"
"Uzbek" "uz"
"Vietnamese" "vi"
"Welsh" "cy"
"Wolof" "wo"
"Xhosa" "xh"
"Yiddish" "yi"
"Yoruba" "yo"
"Zulu" "zu"
}

###
if {![file exists "scripts/blacknews.txt"]} {
	set file [open "scripts/blacknews.txt" w]
	close $file
}
if {![info exists blacknews_timer_run]} {
	timer $blacknews(minutes_show) blacknews:timer
	set blacknews_timer_run 1
}

###
proc blacknews:timer {} {
	global blacknews
	set channels ""
	foreach chan [channels] {
if {[channel get $chan blacknews]} {
	lappend channels $chan
		}
	}			
if {$channels != ""} {
	blacknews:timer:act $channels 0
	}
	timer $blacknews(minutes_show) blacknews:timer
}

###
proc blacknews:timer:act {channels num} {
	global blacknews
	set inc 0
	set chan [lindex $channels $num]
	set keywords [blacknews:getkeywords $chan]
if {$keywords == "0"} {
	set inc [expr $num + 1]
if {[lindex $channels $inc] != ""} {
	utimer 10 [list blacknews:timer:act $channels $inc]
	}
	return
}
if {![info exists blacknews(news_counter:$chan)]} {
	set blacknews(news_counter:$chan) 0
} else {
	set blacknews(news_counter:$chan) [expr $blacknews(news_counter:$chan) + 1]
}
if {[lindex $keywords $blacknews(news_counter:$chan)] != ""} {
	set news [lindex $keywords $blacknews(news_counter:$chan)]
	blacknews:search $chan $news
} else {
	set blacknews(news_counter:$chan) 0
	set news [lindex $keywords $blacknews(news_counter:$chan)]
	blacknews:search $chan $news
}
	set inc [expr $num + 1]
if {[lindex $channels $inc] != ""} {
	utimer 10 [list blacknews:timer:act $channels $inc]
	}
}

###
proc blacknews:search {chan news} {
	global blacknews
	set keyword [string tolower [lindex $news 0]]
	set lang [lindex $news 1]
	set country [lindex $news 2]
	set max [lindex $news 3]
	set type [lindex $news 4]
	set oldest ""
	set new ""
	set news ""
	set first_one ""
	set found_new_news 0
	set temp_unixtime ""
	set show_news ""
if {$country != "-"} {
	set data [blacknews:data $keyword $lang $country $max]
} else {
	set data [blacknews:data $keyword $lang "-" $max]
}
if {$data == ""} { 
if {$type == "1"} {
	blacknews:tell "" $chan 25 [list $keyword]
	}
return 
}
	set error [catch {set news [blacknews:getjson "articles" $data] }]
	
if {$error != "0" || $news == ""} { 
if {$type == "1"} {
	blacknews:tell "" $chan 25 [list $keyword]
	}
	return
}
	set count_results [blacknews:getjson "count_results" $data]
if {$count_results == "0" && $type == "1"} {
	blacknews:tell "" $chan 25 [list $keyword]
	return
} elseif {$count_results == "0"} {
	return
}
if {$type == "1"} {
	blacknews:show_news $news $chan 0 $keyword
	return
}
foreach n $news {
	set pos_time [expr [lsearch -nocase $n "date"] + 1]
	set post_time [lindex $n $pos_time]
	set unixtime [clock scan $post_time -format "%a, %d %b %Y %T %Z"]
if {$first_one == ""} {
	set first_one $unixtime
	}
if {$first_one > $unixtime} {
	lappend oldest $n
	} else {
	set new [linsert $new 0 $n]
	set first_one $unixtime
	}
}
	set news "$new $oldest"
if {![info exists blacknews(key:$chan:$keyword)]} {
	set first_new [lindex $news 0]
	set pos_time [expr [lsearch -nocase $n "date"] + 1]
	set post_time [lindex $n $pos_time]
	set unixtime [clock scan $post_time -format "%a, %d %b %Y %T %Z"]
	set blacknews(key:$chan:$keyword) $unixtime
	set llength [llength $news]
foreach n $news {
	set pos_time [expr [lsearch -nocase $n "date"] + 1]
	set get_post_time [lindex $n $pos_time]
	set get_unixtime [clock scan $get_post_time -format "%a, %d %b %Y %T %Z"]
if {$temp_unixtime != ""} {
if {$get_unixtime > $temp_unixtime} {
	set temp_unixtime $get_unixtime
			}
		} else {
	set temp_unixtime $get_unixtime	
		}
		lappend show_news $n
	}
	set blacknews(key:$chan:$keyword) $temp_unixtime
} else {
foreach n $news {
	set pos_time [expr [lsearch -nocase $n "date"] + 1]
	set post_time [lindex $n $pos_time]
	set get_unixtime [clock scan $post_time -format "%a, %d %b %Y %T %Z"]
if {$get_unixtime > $blacknews(key:$chan:$keyword)} {
	lappend show_news $n
	set found_new_news 1
if {$temp_unixtime != ""} {
if {$get_unixtime > $temp_unixtime} {
	set temp_unixtime $get_unixtime
					}
				} else {
	set temp_unixtime $get_unixtime			
				}
			}
		}
if {$found_new_news == "1"} {
	set blacknews(key:$chan:$keyword) $temp_unixtime
		}		
	}
if {$show_news != ""} {
	blacknews:show_news $show_news $chan 0 $keyword
	}
}

###
proc blacknews:show_news {news chan num keyword} {
	global blacknews
	set new [lindex $news $num]
	set pos_time [expr [lsearch -nocase $new "date"] + 1]
	set date [lindex $new $pos_time]
	set counter 0
	set title [encoding convertfrom  utf-8 [encoding convertto utf-8 [lindex $new 1]]]
	set website [lindex $new 7]
	set link [maketiny [lindex $new 5]]
	
	set replace(%title%) $title
	set replace(%website%) $website
	set replace(%link%) $link
	set replace(%date%) $date
	set replace(%keyword%) $keyword
	set reply [string map [array get replace] $blacknews(output_line)]
	puthelp "PRIVMSG $chan :$reply"
	set counter [expr $num + 1]
if {[lindex $news $counter] != ""} {
	utimer 3 [list blacknews:show_news $news $chan $counter $keyword]
	}	
}

###
proc blacknews:getkeywords {chan} {
	global blacknews
	set keywords ""
	set file [open "scripts/blacknews.txt" r] 
while {[gets $file line] != -1} {
	set read_chan [lindex $line 0]
if {[string equal -nocase $read_chan $chan]} {
	set read_key [lindex $line 1]
	set read_lang [lindex $line 2]
	set read_country [lindex $line 3]
	set read_max [lindex $line 4]
	lappend keywords "$read_key $read_lang $read_country $read_max"
		}
	}
	close $file
if {$keywords != ""} {
	return $keywords
	} else { return 0 }
}

###
proc blacknews:act {nick host hand chan arg} {
	global blacknews
	set first [lindex [split $arg] 0]
	set second [lindex [split $arg] 1]
	set flood_protect [blacknews:flood:prot $chan $host]
if {$flood_protect == "1"} {
	set get_seconds [blacknews:get:flood_time $host $chan]
	blacknews:tell $nick $chan 24 [list $nick $get_seconds]
	return
}
switch $first {
	lang {
if {$second == ""} {
	channel set $chan blacknews.showlang ""
	blacknews:tell $nick $chan 21 ""
	return
}	
if {[string equal -nocase "en" $second] || [string equal -nocase "ro" $second]} {
	channel set $chan blacknews.showlang $second
	blacknews:tell $nick $chan 22 $second
	} else {
	blacknews:tell $nick $chan 23 ""
	}
}
	newslang {
if {$second == ""} {
	channel set $chan blacknews.lang ""
	blacknews:tell $nick $chan 1 ""
	return		
			}
	set search [lsearch $blacknews(country_list) [string tolower $second]]
if {$search > -1} {
	channel set $chan blacknews.lang [string tolower $second]
	blacknews:tell $nick $chan 2 [list [string tolower $second] [lindex $blacknews(country_list) [expr $search - 1]]]
			} else { blacknews:tell $nick $chan 3 "" }
		}
	country {
if {$second == ""} {
	channel set $chan blacknews.country ""
	blacknews:tell $nick $chan 4 ""
	return		
			}
	set search [lsearch $blacknews(country_list) [string tolower $second]]
if {$search > -1} {
	channel set $chan blacknews.country [string tolower $second]
	blacknews:tell $nick $chan 19 [list [string tolower $second] [lindex $blacknews(country_list) [expr $search - 1]]]
			} else { blacknews:tell $nick $chan 20 "" }			
	return	
		}
		
	max {
if {$second == ""} {
	channel set $chan blacknews.max 0
	blacknews:tell $nick $chan 5 ""
	return
			}
if {![regexp {^[0-9]} $second]} {
	blacknews:tell $nick $chan 6 ""
	return
			}
if {$second > 20} {
	blacknews:tell $nick $chan 7 ""
	return
			}
	channel set $chan blacknews.max $second
	blacknews:tell $nick $chan 8 [list $second]
		}
		
	save {
	set strings [lrange [split $arg] 2 end]
	blacknews:save:keyword $nick $chan $second $strings
		}
	list {
	blacknews:list $nick $chan
		}
	del {
	blacknews:delete $nick $chan $second	
		}
	version {
	blacknews:tell $nick $chan version ""
		}
	help {
	blacknews:tell $nick $chan help [list $blacknews(cmd_char)]
		}
	\? {
	blacknews:tell $nick $chan help [list $blacknews(cmd_char)]
		}
	default {
if {$first == ""} {
	blacknews:tell $nick $chan help [list $blacknews(cmd_char)]
	return
			}

	set lang [channel get $chan blacknews.lang]
if {$lang == ""} { set lang [string tolower $blacknews(default_lang)]}
	set country [channel get $chan blacknews.country]
if {$country == ""} { set country "-" }
	set max [channel get $chan blacknews.max]
if {$max == 0} { set max $blacknews(max_news) }
	blacknews:search $chan [list $first $lang $country $max 1]
		}
	}
}

###
proc blacknews:delete {nick chan item} {
	global blacknews
	set found_it 0
	set file [open "scripts/blacknews.txt" r]
	set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
	set temp "scripts/blacknews.txt.$timestamp"
	set tempwrite [open $temp w]
while {[gets $file line] != -1} {
	set read_chan [lindex $line 0]
	set read_key [lindex $line 1]
if {[string equal -nocase $chan $read_chan] && [string equal -nocase $item $read_key]} {
	set found_it 1
		continue
} else {
	puts $tempwrite $line
		}	
	}
	close $tempwrite
	close $file
    file rename -force $temp "scripts/blacknews.txt"
if {$found_it == "0"} {
	blacknews:tell $nick $chan 9 [list $item]
	} else {
	set keyword [string tolower $item]
if {[info exists blacknews(key:$chan:$keyword)]} {
	unset blacknews(key:$chan:$keyword)
		}
	blacknews:tell $nick $chan 10 [list $item $chan]
	}
}

###
proc blacknews:list {nick chan} {
	global blacknews
	set found_info 0
	set counter 0
	set file [open "scripts/blacknews.txt" r]
while {[gets $file line] != -1} {
	set counter [expr $counter + 1]
	set read_chan [lindex $line 0]
if {[string equal -nocase $chan $read_chan]} {
	set found_info 1
	set read_key [lindex $line 1]
	set read_lang [lindex $line 2]
	set read_country [lindex $line 3]
	set read_max [lindex $line 4]
	blacknews:tell $nick $chan 11 [list $counter $read_key $read_lang $read_country $read_max]
		}
	}
if {$found_info == "0"} {
	blacknews:tell $nick $chan 12 ""
	}	
}

###
proc blacknews:save:keyword {nick chan keyword string} {
	global blacknews
	set found_it 0
	set split_keyword [split $keyword "+"]
if {[llength $split_keyword] > 3} {
	blacknews:tell $nick $chan 13 ""
	return
}
	set error ""
	set file [open "scripts/blacknews.txt" r]
while {[gets $file line] != -1} {
	set read_chan [lindex $line 0]
	set read_key [lindex $line 1]
if {[string equal -nocase $read_chan $chan] && [string equal -nocase $read_key $keyword]} {
	set found_it 1
		}
	}
	close $file
if {$found_it == "1"} {
	blacknews:tell $nick $chan 14 [list $keyword]
	return
	}
	set lang [channel get $chan blacknews.lang]
	set country [channel get $chan blacknews.country]
	set max [channel get $chan blacknews.max]
if {$lang == ""} { set lang [string tolower $blacknews(default_lang)] }
if {$max == "0"} { set max $blacknews(max_news) }
if {$string != ""} {
	set split_it [split $string " "]
foreach item $split_it {
	set get_it [wsplit $item "="]
	set name [lindex $get_it 0]
	set value [lindex $get_it 1]
switch $name {
	l {
	set search_l [lsearch $blacknews(country_list) [string tolower $value]]
if {$search_l > -1} {
	set lang $value
		} else {
	lappend error $value
		}		
	}
	c {
	set search_c [lsearch $blacknews(country_list) [string tolower $value]]
if {$search_c > -1} {
	set country $value
		} else {
	lappend error $value
		}
	}
	m {
if {![regexp {^[0-9]} $value]} {
	lappend error $value
					} elseif {$value > 20} {
	lappend error $value
					} else {
	set max $value				
					}
				}
			}	
		}
if {$error != ""} {
	blacknews:tell $nick $chan 15 [list $keyword [join $error ", "]]
	return	
		}
if {$country != ""} {
	blacknews:tell $nick $chan 16 [list $keyword $lang $country $max]
	blacknews:save $chan $keyword $lang $country $max	
		} else {
	blacknews:save $chan $keyword $lang $country $max
	blacknews:tell $nick $chan 17 [list $keyword $lang $max]	
		}
	} else {
	blacknews:save $chan $keyword $lang $country $max
	blacknews:tell $nick $chan 18 [list $keyword $lang $max]
	}
}

###
proc blacknews:save {chan keyword lang country max} {
	global blacknews
if {$country == ""} { set country - }
	set file [open "scripts/blacknews.txt" a]
	puts $file "$chan $keyword $lang $country $max"
	close $file
}

proc blacknews:data {query lang country max} {
global blacknews
	set ipq ""
	set query [string map {
						"," "+"
						" " ""
						} $query]
	http::register https 443 [list ::tls::socket -autoservername true]	
if {$lang == ""} {
	set lang [string tolower $blacknews(default_lang)]
}
if {$max == ""} {
	set max [string tolower $blacknews(max_news)]
}
if {$country != ""} {
	set link "https://gnews.io/api/v2?q=$query&lang=$lang&country=$country&max=$max&token=$blacknews(tooken)"
} else {
	set link "https://gnews.io/api/v2?q=$query&lang=$lang&max=$max&token=$blacknews(tooken)"
}
	set ipq [http::config -useragent "lynx"]
	set error [catch {set ipq [http::geturl "$link"]}]
	set status [http::status $ipq]
if {$status != "ok"} { 
	http::cleanup $ipq
	return $status 
}
	set data [http::data $ipq]
	::http::cleanup $ipq
	return $data
}

###
proc blacknews:getjson {get data} {
	global blacknews
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
proc blacknews:tell {nick chan num arg} {
	global blacknews
	set counter 0
	set get_lang [channel get $chan blacknews.showlang]
if {$get_lang == ""} {
	set get_lang $blacknews(show_lang)
	}
if {![info exists blacknews(lang.$get_lang.$num)]} {
	return
}
foreach w $arg {
	set counter [expr $counter + 1]
	set replace(%msg.$counter%) $w
}
	set reply [string map [array get replace] $blacknews(lang.$get_lang.$num)]
if {$nick != ""} {
	puthelp "NOTICE $nick :$reply"
	} else {
	puthelp "PRIVMSG $chan :$reply"
	}
}

###
proc wsplit {string sep} {
    set first [string first $sep $string]
    if {$first == -1} {
        return [list $string]
    } else {
        set l [string length $sep]
        set left [string range $string 0 [expr {$first-1}]]
        set right [string range $string [expr {$first+$l}] end]
        return [concat [list $left] [wsplit $right $sep]]
    }
}

##
# Thanks to speechless
# http://forum.egghelp.org/viewtopic.php?t=11277&start=179
proc maketiny {url} {
	set ua "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5"
	set http [::http::config -useragent $ua -useragent "utf-8"]
	set token [http::geturl "http://tinyurl.com/api-create.php?[http::formatQuery url $url]" -timeout 3000]
	upvar #0 $token state
if {[string length $state(body)]} { return $state(body) }
	return $url
}

###
proc blacknews:flood:prot {chan host} {
	global blacknews
	set number [scan $blacknews(flood_prot) %\[^:\]]
	set timer [scan $blacknews(flood_prot) %*\[^:\]:%s]
if {[info exists blacknews(flood:$host:$chan:act)]} {
	return 1
}
foreach tmr [utimers] {
if {[string match "*blacknews:remove:flood $host $chan*" [join [lindex $tmr 1]]]} {
	killutimer [lindex $tmr 2]
	}
}
if {![info exists blacknews(flood:$host:$chan)]} { 
	set blacknews(flood:$host:$chan) 0 
}
	incr blacknews(flood:$host:$chan)
	utimer $timer [list blacknews:remove:flood $host $chan]	
if {$blacknews(flood:$host:$chan) > $number} {
	set blacknews(flood:$host:$chan:act) 1
	utimer [expr $blacknews(ignore_prot) * 60] [list blacknews:expire:flood $host $chan]
	return 1
	} else {
	return 0
	}
}

###
proc blacknews:remove:flood {host chan} {
	global blacknews
if {[info exists blacknews(flood:$host:$chan)]} {
	unset blacknews(flood:$host:$chan)
	}
}

###
proc blacknews:expire:flood {host chan} {
	global blacknews
if {[info exists blacknews(flood:$host:$chan:act)]} {
	unset blacknews(flood:$host:$chan:act)
	}
}

###
proc blacknews:get:flood_time {host chan} {
	global blacknews
		foreach tmr [utimers] {
if {[string match "*blacknews:expire:flood $host $chan*" [join [lindex $tmr 1]]]} {
	return [lindex $tmr 0]
		}
	}
}

###
# Credits
set blacknews(projectName) "Black News"
set blacknews(author) "BLaCkShaDoW"
set blacknews(website) "wWw.TCLScriptS.NeT"
set blacknews(email) "BLaCkShaDoW@TCLScriptS.NeT"
set blacknews(version) "v1.1"

#Languages
# Romanian
###
set blacknews(lang.ro.1) "\[NEWS\] Am resetat limba pentru stiri."
set blacknews(lang.ro.2) "\[NEWS\] Am setat limba principala a stirilor ca: \002%msg.1%\002 (%msg.2%)."
set blacknews(lang.ro.3) "\[NEWS\] Ai specificat o limba invalida."
set blacknews(lang.ro.4) "\[NEWS\] Am resetat tara."
set blacknews(lang.ro.5) "\[NEWS\] Am resetat numarul maxim de stiri."
set blacknews(lang.ro.6) "\[NEWS\] Ai specificat un numar invalid de stiri."
set blacknews(lang.ro.7) "\[NEWS\] Ai specificat un numar mai mare ca\002 20\002."
set blacknews(lang.ro.8) "\[NEWS\] Am setat numarul maxim de stiri la: \002%msg.1%\002."
set blacknews(lang.ro.9) "\[NEWS\] Nu am putut sterge cuvantul cheie: \002%msg.1%\002. Nu exista asemenea cuvant."
set blacknews(lang.ro.10) "\[NEWS\] Am sters cuvantul cheie: \002%msg.1%\002 dupa %msg.2%."
set blacknews(lang.ro.11) "\[NEWS\] \#%msg.1%. Cuvant: \002%msg.2%\002 ; Limba: \002%msg.3%\002 ; Tara: \002%msg.4%\002 ; Max: \002%msg.5%\002"
set blacknews(lang.ro.12) "\[NEWS\] Nu exista salvate cuvinte cheie :-)"
set blacknews(lang.ro.13) "\[NEWS\] Nu poti folosi mai mult de\002 3\002 cuvinte cheie."
set blacknews(lang.ro.14) "\[NEWS\] Nu am putut adauga \002%msg.1%\002. Cuvantul exista deja."
set blacknews(lang.ro.15) "\[NEWS\] Nu am putut adauga \002%msg.1%\002. Valori invalide: %msg.2%"
set blacknews(lang.ro.16) "\[NEWS\] Am adaugat \002%msg.1%\002 cu parametrii: limba:\002%msg.2%\002, tara:\002%msg.3%\002, max:\002%msg.4%\002"
set blacknews(lang.ro.17) "\[NEWS\] Am adaugat \002%msg.1%\002 cu parametrii: limba:\002%msg.2%\002, max:\002%msg.3%\002"
set blacknews(lang.ro.18) "\[NEWS\] Am adaugat \002%msg.1%\002 cu parametrii: limba:\002%msg.2%\002, max:\002%msg.3%\002"
set blacknews(lang.ro.19) "\[NEWS\] Am setat tara principala a scriptului ca: \002%msg.1%\002 (%msg.2%)."
set blacknews(lang.ro.20) "\[NEWS\] Ai specificat o tara invalida."
set blacknews(lang.ro.21) "\[NEWS\] Am resetat limba script-ului."
set blacknews(lang.ro.22) "\[NEWS\] Am setat limba principala a scriptului ca: \002%msg.1%\002."
set blacknews(lang.ro.23) "\[NEWS\] Ai specificat o limba invalida pentru script."
set blacknews(lang.ro.24) "\[NEWS\] \002%msg.1%\002: Trimiti cereri prea repede. Calmeaza-te si incearca din nou dupa \002%msg.2% secunde\002. Multumesc!"
set blacknews(lang.ro.25) "\[NEWS\] Nu am gasit nicio stire legata de \"%msg.1%\"."
set blacknews(lang.ro.version) "\002$blacknews(projectName) $blacknews(version)\002 creat de\002 $blacknews(author)\002 ($blacknews(email)) --\002 $blacknews(website)\002. PRIVATE TCL available only on donations."
set blacknews(lang.en.help) "\[NEWS\] Comenzi: \002%msg.1%bnews\002 \[?|help\] ; \002%msg.1%bnews\002 \[termeni cautare\] ; \002%msg.1%bnews\002 save <cuvinte cheie> \[l=limba\] \[m=<max>\] \[c=<tara>\] ; \002%msg.1%bnews\002 list ; \002%msg.1%bnews\002 country <tara abrev.> ; \002%msg.1%bnews\002 del <termeni cautare> ; \002%msg.1%bnews\002 lang \[ro|en\] ; \002%msg.1%bnews\002 newslang \[ro|en\] ; \002%msg.1%bnews\002 max <nr.> ; \002%msg.1%bnews\002 version"

# English
###
set blacknews(lang.en.1) "\[NEWS\] The \002news language\002 has been reset."
set blacknews(lang.en.2) "\[NEWS\] Default \002news language\002 set to: \002%msg.1%\002 (%msg.2%)."
set blacknews(lang.en.3) "\[NEWS\] Invalid \002language\002 specified."
set blacknews(lang.en.4) "\[NEWS\] \002Country\002 has been reset."
set blacknews(lang.en.5) "\[NEWS\] The maximum \002number of news\002 has been reset."
set blacknews(lang.en.6) "\[NEWS\] You specified an invalid news number."
set blacknews(lang.en.7) "\[NEWS\] You specified a number greater than\002 20\002."
set blacknews(lang.en.8) "\[NEWS\] The maximum \002number of news\002 set to:\002%msg.1%\002."
set blacknews(lang.en.9) "\[NEWS\] Couldn't delete KeyWord: \002%msg.1%\002. No such KeyWord."
set blacknews(lang.en.10) "\[NEWS\] Deleted KeyWord: \002%msg.1%\002 from %msg.2%."
set blacknews(lang.en.11) "\[NEWS\] \#%msg.1%. KeyWord: \002%msg.2%\002 ; Lang: \002%msg.3%\002 ; Country: \002%msg.4%\002 ; Max: \002%msg.5%\002"
set blacknews(lang.en.12) "\[NEWS\] No KeyWords added yet :-)"
set blacknews(lang.en.13) "\[NEWS\] Use a maximum of\002 3\002 keywords."
set blacknews(lang.en.14) "\[NEWS\] Couldn't add keyword \002%msg.1%\002. Keyword already exists."
set blacknews(lang.en.15) "\[NEWS\] Couldn't add keyword \002%msg.1%\002. Invalid values: %msg.2%"
set blacknews(lang.en.16) "\[NEWS\] Added keyword \002%msg.1%\002 with param: lang:\002%msg.2%\002, country:\002%msg.3%\002, max:\002%msg.4%\002"
set blacknews(lang.en.17) "\[NEWS\] Added keyword \002%msg.1%\002 with param: lang:\002%msg.2%\002, max:\002%msg.3%\002"
set blacknews(lang.en.18) "\[NEWS\] Added keyword \002%msg.1%\002 with param: lang:\002%msg.2%\002, max:\002%msg.3%\002"
set blacknews(lang.en.19) "\[NEWS\] Default \002script country\002 set to: \002%msg.1%\002 (%msg.2%)."
set blacknews(lang.en.20) "\[NEWS\] Invalid \002country\002 specified."
set blacknews(lang.en.21) "\[NEWS\] \002Default script language\002 has been reset."
set blacknews(lang.en.22) "\[NEWS\] Default \002script language\002 set to: \002%msg.1%\002."
set blacknews(lang.en.23) "\[NEWS\] Invalid script language specified."
set blacknews(lang.en.24) "\[NEWS\] \002%msg.1%\002: You're sending requests too fast. Calm down and try again after \002%msg.2% seconds\002. Thanks!"
set blacknews(lang.en.25) "\[NEWS\] No news found about \"%msg.1%\"."
set blacknews(lang.en.version) "\002$blacknews(projectName) $blacknews(version)\002 coded by\002 $blacknews(author)\002 ($blacknews(email)) --\002 $blacknews(website)\002. PRIVATE TCL available only on donations."
set blacknews(lang.en.help) "\[NEWS\] Commands: \002%msg.1%bnews\002 \[?|help\] ; \002%msg.1%bnews\002 \[search terms\] ; \002%msg.1%bnews\002 save <keywords> \[l=lang\] \[m=<max>\] \[c=<country>\] ; \002%msg.1%bnews\002 list ; \002%msg.1%bnews\002 country <country abbrev.> ; \002%msg.1%bnews\002 del <keyword> ; \002%msg.1%bnews\002 lang \[ro|en\] ; \002%msg.1%bnews\002 newslang \[ro|en\] ; \002%msg.1%bnews\002 max <no.> ; \002%msg.1%bnews\002 version"

putlog "\002$blacknews(projectName) $blacknews(version)\002 coded by\002 $blacknews(author)\002 ($blacknews(website)): Loaded & initialised.."

########
##############################################################################
###                  *** END OF Black News TCL ***                         ###
##############################################################################