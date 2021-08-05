# tcl subida por el staff de #tcls en DALnet por Sedition y Arnold_X-P email coky_02@hotmail.com #
# puedes encontrarme en la red latinchat server speed.friendschats.org #


# secuencia del anti flood 5 lineas por 3 segundos, esto se puede modificar de acuerdo a su criterio
set chantexttrigger "7:3"

# mensaje de la patada
set mensajeantiflood "Por Favor evita el Flood..."

bind pubm - "*" text:flood
bind ctcp - ACTION action:flood
bind notc - "*" notice:flood

proc text:flood {nick uhost hand chan text} {
text:flood:delay $nick $uhost $hand $chan $text "Text"
}

proc action:flood {nick uhost hand dest keyword text} {
if {[isbotnick $dest]} { return 0 }
if {[string equal "#" [string index $dest 0]] && [string match "#*" $dest]} {
text:flood:delay $nick $uhost $hand $dest $text "Action"
}
}

proc notice:flood {nick uhost hand text {dest ""}} {
if {[isbotnick $dest] || [string equal "ChanServ" $nick] || [string equal "NickServ" $nick] || [string equal "MemoServ" $nick] || ($nick == "")} { return 0 }
if {[string equal "@" [string index $dest 0]] && [string equal "#" [string index $dest 1]]} { return 0 }
if {[string equal "#" [string index $dest 0]] && [string match "#*" $dest]} {
text:flood:delay $nick $uhost $hand $dest $text "Notice"
}
}

proc text:flood:delay {nick uhost hand chan text type} {
global chantexttrigger chantextflood mensajeantiflood
if {[isbotnick $nick] || ![botisop $chan] || [isop $nick $chan] || [isvoice $nick $chan] || [string equal "sedition" $nick]} { return 0 }
if {[string match -nocase "#*" $chan]} {
set user [string tolower $nick:$chan]
if {![info exists chantextflood($user)]} {
set chantextflood($user) 0
}
utimer [lindex [split $chantexttrigger :] 1] [list text:flood:list $user]
if {[incr chantextflood($user)] >= [lindex [split $chantexttrigger :] 0]} {
putquick "MODE $chan +b *!*@[lindex [split $uhost @] 1]"
putquick "KICK $chan $nick $mensajeantiflood"
timer 60 [list putquick "MODE $chan -b *!*@[lindex [split $uhost @] 1]"]
if {[info exists chantextflood($user)]} { unset chantextflood($user) }
}
}
}

proc text:flood:list u {
global chantextflood
if {[info exists chantextflood($u)]} { incr chantextflood($u) -1 }
}