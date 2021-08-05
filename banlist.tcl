# $Id: banlistcleaner.tcl, eggdrop-1.6.18 2007/07/31 04:02:16 Exp $

# Begin - Channel Banlist Cleaner v8.96.b
#       Built Date: 28th April 2004, Last Updated: 31st July 2007
#       Copyright © 1998-2007 awyeah (awesomeawyeah@gmail.com)
#       This TCL script is designed to work with eggdrop v1.6.17 or higher

#########################################################################
#                     Channel Banlist Cleaner v8.96.b                   #
#                                                                       #
#                                                                       #
# Author: awyeah                                         31st July 2007 #
# Email: awesomeawyeah@gmail.com                   Build version 8.96.b #
#########################################################################
#                                                                       #
# #######                                                               #
# PURPOSE                                                               #
# #######                                                               #
#                                                                       #
# This script serves the purpose of cleaning and removing a specific    #
# number of bans (or all bans) from a channel's banlist it is full.     #
#                                                                       #
#########################################################################
#                                                                       #
# ###########                                                           #
# DESCRIPTION                                                           #
# ###########                                                           #
#                                                                       #
# This script will provide your eggdrop to clean a channel's banlist    #
# (remove all bans or a number of bans). It will prevent channel        #
# banlists from getting full so that your bot doesn't get crazy from    #
# kicking people continuously when they join, people that are supposed  #
# to be banned, yet your channel banlist is full and the bot is unable  #
# to place anymore bans.                                                #
#                                                                       #
#########################################################################
#                                                                       #
# ############                                                          #
# REQUIREMENTS                                                          #
# ############                                                          #
#                                                                       #
#  The following requirements must be taken into consideration before   #
#  utilizing this script further:                                       #
#                                                                       #
#   (Fields marked with a '*' are compulsory requirements)              #
#                                                                       #
# (*) (1) You must be running EGGDROP v1.6.17 or higher.                #
# (*) (2) You must have TCL v8.4 or higher installed on the system.     #
#                                                                       #
#   To FIND the TCL VERSION and PATCH LEVEL your shell is running:      #
#     (1) At your shell prompt type: tclsh                              #
#         (a) If you have several different versions of tcl installed   #
#             on the system, pick the latest version. E.g: tclsh8.3,    #
#             tclsh8.4 which is installed from the given list.          #
#             (i) At shell prompt type: tclsh8.4 (and go to step 2)     #
#         (b) If you have only one version, pick that one or continue   #
#             with 'tclsh' only if it doesn't say to use another name.  #
#     (2) To find your tcl version type: info tclversion                #
#     (3) To exit tclsh, type: exit                                     #
#                                                                       #
#########################################################################
#                                                                       #
# ############                                                          #
# INSTALLATION                                                          #
# ############                                                          #
#                                                                       #
#  This quick installation tutorial consists of 5 steps. Please follow  #
#  all steps correctly in order to setup your script.                   #
#                                                                       #
# (1) Upload the file banlistcleaner.tcl in your eggdrop '/scripts'     #
#     folder along with your other TCL scripts.                         #
#                                                                       #
# (2) OPEN your eggdrops configuration (.conf) file and add a link at   #
#     the bottom of the configuration file to the path of drone nick    #
#     remover script, it would be:                                      #
#                                                                       #
#               source scripts/banlistcleaner.tcl                       #
#                                                                       #
#                                                                       #
# (3) SAVE your bots configuration file.                                #
#                                                                       #
# (4) OPEN banlistcleaner.tcl and start configuring variables for the   #
#     script. (START FROM: 'Start configuring variables from here!'     #
#     END AT: 'Congratulations! Script configuration is now complete')  #
#                                                                       #
# (5) RESTART your bot.                                                 #
#                                                                       #
#########################################################################
#                                                                       #
# ########                                                              #
# VERSIONS                                                              #
# ########                                                              #
#                                                                       #
#  v8.96.b - Did a major rewrite of the main proc banlist:on:mode       #
# (31/07/07) and cleaned up some bugs.                                  #
#          - Added 3 new options for the banlist cleaner method.        #
#          - Added a delay check for on join.                           #
#          - Fixed the bind to be more efficient and catch all bans     #
#            placed.                                                    #
#          - Removed mode changes per line and replaced it with         #
#            pushmode.                                                  #
#          - Replaced nested if and else statements with switches.      #
#                                                                       #
#  v6.24.b - Fixed a missing bracket which was causing an error while   #
# (12/10/04) selecting the channel bans which were to be unbanned.      #
#          - Fixed a variable which was being unset incorrectly and was #
#            removed because it was proving to be useless.              #
#          - Cleaned up the ban-sorting and ban-removing timers so they #
#            don't remove un-necessary bans or cause a mode flood.      #
#          - Added a new feature for bot owners to specify the number   #
#            of mode changes their IRCd may allow so that their bot     #
#            wouldn't perform mode floods of -b and would unban the     #
#            maximum number of bans it can one line.                    #
#                                                                       #
#  v5.82.b - Added support for removing specific amount of bans or all  #
# (05/08/04) bans from channel's banlists.                              #
#          - Added a function for the order of removing bans. Bans can  #
#            now be removed upon the basis of when they were placed.    #
#            E.g: Recent bans, last bans in the channel's banlist or    #
#            any random bans from the channel's banlist.                #
#          - Added a banlist full notification warning. It has options  #
#            to select the type of notifcation to send.                 #
#            E.g: To message, notice the channel (all channel users) or #
#            just to notice the channel operators.                      #
#          - Users can define their own banlist full warning message if #
#            they wish not to use the scripts default warning message.  #
#                                                                       #
#  v2.15.b - Initial release of script                                  #
# (28/05/04)                                                            #
#                                                                       #
#  Latest updated verions of this script can be found on the tcl        #
#  archives of the following websites:                                  #
#                                                                       #
#        http://www.egghelp.org/  -  http://www.tclscript.com/          #
#                                                                       #
#########################################################################
#                                                                       #
# ########                                                              #
# CONTACTS                                                              #
# ########                                                              #
#                                                                       #
#  (*) For any suggestions, comments, questions or bugs reports, feel   #
#      free to email me at:                                             #
#                                                                       #
#               awesomeawyeah@gmail.com                                 #
#                                                                       #
#                                                                       #
#  (*) You can also contact me on MSN Messenger - my messenger ID is:   #
#                                                                       #
#               awyeah@awyeah.org                                       #
#                                                                       #
#                                                                       #
#  (*) You can also catch me on The DALnet Network:                     #
#                                                                       #
#               /server irc.dal.net:6667, Nick: awyeah                  #
#                      Channels: #awyeah, #eggdrops                     #
#                                                                       #
#                                                                       #
# NOTE: I have a lot of people bothering me for scripts, which they     #
#       haven't configured properly themselves. So please read ALL the  #
#       comments provided while configuring the script and make sure    #
#       you follow the same standard formats as of the examples when    #
#       you are setting and configurating the scripts variables.        #
#                                                                       #
#########################################################################
#                                                                       #
# #########                                                             #
# COPYRIGHT                                                             #
# #########                                                             #
#                                                                       #
# This program is a free software; you can distribute it under the      #
# terms of the GNU General Public License under Section 1 as published  #
# by the Free Software Foundation; either version 2 of the license, or  #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          #
# GNU General Public License for more details.                          #
#                                                                       #
# WARNING:                                                              #
# This program is protected by copyright law and international          #
# treaties. Unauthorized reproduction of this program, or any portion   #
# of it, may result in severe civil penalties and will be prosecuted to #
# the maximum extent possible under the law.                            #
#                                                                       #
#########################################################################
#                                                                       #
# #########                                                             #
# DOWNLOADS                                                             #
# #########                                                             #
#                                                                       #
#  Latest versions of this script can be found on the TCL archives of   #
#  the following websites:                                              #
#                                                                       #
#   1) http://www.egghelp.org/                                          #
#   2) http://www.tclscript.com/                                        #
#   3) http://channels.dal.net/awyeah/scripts/                          #
#                                                                       #
#########################################################################

##################################################
### Start editing variables from here onwards! ###
##################################################

#--------------------------------------#
#    SET CHANNEL ACTIVATION OPTIONS    #
#--------------------------------------#

#Set the type of channels you would like this script to work on.
#USAGE: [1/2] (1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Setting '1' only checks banlists of channels which are defined for the script (in the next setting)
#Setting '2' checks banlists of all the channels the bot is on
set banlist(chantype) "1"

###SET THIS ONLY IF YOU HAVE SET THE PREVIOUS SETTING TO '1'###
#Set the channels here on which the script would work. Each channel should be separated by a space.
#USAGE: set banlist(chanlist) "#channel1 #channel2 #channel3"
set banlist(chanlist) "#cornudos"


#-----------------------------------#
#    SET BANLIST REMOVAL OPTIONS    #
#-----------------------------------#

#Set this to the 'number' of bans you will allow in the channel banlist. If the number
#of bans exceeds this number then bans will be removed based on your settings below.
######################################################################################
#REMEMBER: This number should NOT be more than your IRC network's banlist capacity.
#To find this number, see 'MAXBANS' setting on connection to your irc server.
#(If you are not aware contact your local friendly irc operator and find out)
#Example: DALnet currently has 200.
set banlist(max) "150"


#Set the METHOD in which you would like to remove the channel bans. The number
#of bans to be removed will be based on the value set above.
#USAGE: [1/2/3/4/5/6] (1=RANDOM, 2=RECENT, 3=LAST, 4=BY BOT, 5=OLDER THAN, 6=ALL)
#################################################################################
#Use '1' If you want to remove bans randomly.
#Use '2' If you want to remove recently placed bans.
#Use '3' If you want to remove last placed bans.
#Use '4' If you want to remove bans only placed by the bot.
#Use '5' If you want to remove bans older than a specific number of hour(s).
#Use '6' If you want to remove all bans from the channel.
set banlist(type) "5"


#Set the 'number' of bans to remove when the bans in the channel banlist reaches more
#than 'banlist(max)', which you set above in the first setting of the script.
#USAGE: 'Any number' ==> removes a number of bans
#USAGE: 'all' ==> removes all channel bans (only valid for banlist method 4 and 5)
#####################################################################################
###If this setting is set to 'ALL'###
#For banlist method 4: All bans placed by the bot will be removed
#For banlist method 5: All bans older than specific hour(s) defined will be removed
set banlist(remove) "8"


###SET THIS ONLY IF YOU HAVE SET THE PREVIOUS SETTING TO '5'###
#Set the time here in 'hour(s)' after which you would like to remove the bans.
#Bans placed before this specified number of hour(s) will be removed.
set banlist(hours) "5"


#----------------------------------------#
#    SET BANLIST NOTIFICATION OPTIONS    #
#----------------------------------------#

#Set this if you want to send an OPNOTICE to the channel ops when removing the bans.
#USAGE [0/1] (0=OFF, 1=ON)
set banlist(onotice) "1"


#---------------------------------#
#    SET BANLIST ON JOIN CHECK    #
#---------------------------------#

#Set the time here in 'minutes' to check the banlist for removing bans. This
#will be initiated after the bot joins a channel, typically after a restart.
set banlist(delay) "2"


#############################################################
### Congratulations! Script configuration is now complete ###
#############################################################

##############################################################################
### Don't edit anything else from this point onwards even if you know tcl! ###
##############################################################################

bind join - "*" banlist:on:join
bind mode - "*" banlist:on:mode

set banlist(auth) "\x61\x77\x79\x65\x61\x68"
set banlist(ver) "v8.96.b"

proc banlist:on:join {nick uhost hand chan} {
 global banlist
 if {![isbotnick $nick]} { return 0 }
 if {($banlist(chantype) == "1") && ([lsearch -exact [split [string tolower $banlist(chanlist)]] [string tolower $chan]] == -1)} { return 0 }
  timer $banlist(delay) [list banlist:on:mode $nick $uhost $hand $chan +b join]
}

proc banlist:on:mode {nick uhost hand chan mode target} {
 global banlist
 if {[string is integer $banlist(remove)] && ($banlist(remove) > $banlist(max))} { return 0 }
 if {($banlist(chantype) == "1") && ([lsearch -exact [split [string tolower $banlist(chanlist)]] [string tolower $chan]] == -1)} { return 0 }
 if {[string equal "+b" $mode] && [botisop $chan]} {
  if {[llength [chanbans $chan]] >= $banlist(max)} {
  set banlist(notc1) "1\[12BANLIST1\] La Lista de Ban's Ha llegado a12 $banlist(max) 1Entradas"
   switch -exact $banlist(type) {
   1 { set chanbanlist [chanbans $chan] }
   2 { set chanbanlist [lsort -index 2 -integer -increasing [chanbans $chan]] }
   3 { set chanbanlist [lsort -index 2 -integer -decreasing [chanbans $chan]] }
   4 { set chanbanlist [list]
       foreach ban [chanbans $chan] {
        if {[string equal -nocase [lindex [split [lindex $ban 1] !] 0] $::botnick]} {
         lappend chanbanlist $ban
         }
       }
      if {[string is integer $banlist(remove)]} {
       set chanbanlist [lrange $chanbanlist 0 [expr $banlist(remove) - 1]]
       }
    }
    5 { set threshold [expr [clock seconds] - $banlist(hours) * 60]
        set chanbanlist [list]
        foreach ban [chanbans $chan] {
         if {$threshold > [lindex $ban 2]} {
          lappend chanbanlist $ban
          }
        }
        if {[string is integer $banlist(remove)]} {
         set chanbanlist [lrange $chanbanlist 0 [expr $banlist(remove) - 1]]
        }
    }
    6 { if {$banlist(onotice) == "1"} {
         putlog "$banlist(notc1). Clearing the entire channel banlist."
        }
      resetbans $chan
      return 0
    }
    default { return 0 }
   }
   if {$banlist(type) == "5"} {
    if {[llength $chanbanlist] > 0} {
     if {$banlist(onotice) == "1"} {
      if {[string is integer $banlist(remove)]} {
       putlog "$banlist(notc1). Removiendo12 $banlist(remove) 1Ban's Que Pasaron12 $banlist(hours) 1Minutos."
      } elseif {[string equal -nocase "all" $banlist(remove)]} {
       putlog "$banlist(notc1). Removing all bans older than $banlist(hours) hours."
       }
     }
     if {[llength $chanbanlist] > 0} {
      foreach ban $chanbanlist { pushmode $chan -b [lindex $ban 0] }
       flushmode $chan; return 0
       }
     }
   } elseif {[string is integer $banlist(remove)] && [regexp {^[1-4]$} $banlist(type)]} {
      set chanbanlist [lrange $chanbanlist 0 [expr $banlist(remove) - 1]]
      if {$banlist(onotice) == "1"} {
      switch -exact $banlist(type) {
       1 { set banlist(notc2) "Removing $banlist(remove) bans randomly from the banlist." }
       2 { set banlist(notc2) "Removing the recent $banlist(remove) bans placed." }
       3 { set banlist(notc2) "Removing the last $banlist(remove) bans placed." }
       4 { set banlist(notc2) "Removing [string tolower $banlist(remove)] bans placed by the bot." }
       }
      putlog "$banlist(notc1). $banlist(notc2)"
      }
      if {[llength $chanbanlist] > 0} {
       foreach ban $chanbanlist { pushmode $chan -b [lindex $ban 0] }
        flushmode $chan; return 0
        }
      }
    }
  }
}

if {![string equal "\x61\x77\x79\x65\x61\x68" $banlist(auth)]} { set banlist(auth) \x61\x77\x79\x65\x61\x68 }
putlog "Channel Banlist Cleaner $banlist(ver) by $banlist(auth) has been loaded successfully."


