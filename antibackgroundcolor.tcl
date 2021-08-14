## tcl anti fondos en textos de colores
## esta tcl advertira, y luego expulsara al usuario que haga el uso de fondos en textos de colores.
## por sedition email: admin@peoplechat.org
## redes donde me encontraras /server irc.peoplechat.org  channel #eggdrop y en /server irc.chatzona.org  canal #tcl mi nick sedition

## aqui por defecto ya esta agregado la variante para fondos no tocar.
set textfondos {
"*\003*,*"
}

set fondotime 80 ; # tiempo en segundo donde el bot grabara al infractor en su memoria (no tocar dejarlo tal cual)

set advertenciafondo "4Advertencia 7%­nick el uso de Fondos en textos de colores no esta permitido en el canal %chan, evite hacerlo o sera expulsado." ; # mensaje advertencia

set kickfondo "El uso de fondos en textos de colores no esta permitido!" ; # mensaje del kick.

bind pubm - * advertenciakick
bind ctcp - ACTION fondoaction

proc fondoaction {nick uhost hand chan keyword arg} {
advertenciakick $nick $uhost $hand $chan $arg
}

proc advertenciakick {nick uhost hand chan arg} {
global wkb textfondos fondotime advertenciafondo kickfondo
 set match 0
foreach word $textfondos {
if {[string match -nocase $word $arg]} {
 set match 1
break
 }
}
 if {$match} {
set o [throttled $nick:$uhost $fondotime]
regsub -all -- {%­nick} $advertenciafondo $nick advertenciafondo
regsub -all -- {%chan} $advertenciafondo $chan advertenciafondo
if {$o == 1} {
 putserv "PRIVMSG $chan :$advertenciafondo"
} {
putserv "kick $chan $nick :$kickfondo"
if {$o >= 2} {
 putserv "mode $chan +b *!*@[lindex [split $uhost @] 1]" -next
  }
 }
}
}

# user's throttled procedure with slight modification
proc throttled {id time} {
global throttled
if {[info exists throttled($id)]} {
 incr throttled($id)
} {
set throttled($id) 1
 utimer $time [list unset throttled($id)]
}
return $throttled($id)
}