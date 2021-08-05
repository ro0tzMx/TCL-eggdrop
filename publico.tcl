#__      ____      ____      _____  __ _  __ _  __| |_ __ ___  _ __   ___  ___        
#\ \ /\ / /\ \ /\ / /\ \ /\ / / _ \/ _` |/ _` |/ _` | '__/ _ \| '_ \ / _ \/ __|        
# \ V  V /  \ V  V /  \ V  V /  __/ (_| | (_| | (_| | | | (_) | |_) |  __/\__ \         
#  \_/\_/    \_/\_/    \_/\_(_)___|\__, |\__, |\__,_|_|  \___/| &__(_)___||___/  _     
#                                  |___/ |___/                |_|               (_)    
#                                                                                      
#Script de comandos publicos Echo expresamente para eggdrop&es                         
#Dedicado a al canal #eggdrop de CHatHispano especialmente a                           
#Sentencia +1000000 Script By CoCoLoCo                                                 


#Comandos para owner "n"
bind pub n .restart do_restart
bind pub n .die do_die
bind pub n .rehash do_rehash
bind pub n .hop do_hop
bind pub n .ignore proc_ignore
bind pub n .uignore proc_quitarignore
#este comando es el chattr que le cambiao el nombre
bind pub n .flags do_flags
##################################################
bind pub n .adduser do_adduser
bind pub n .deluser do_deluser
bind pub n .say do_say
bind pub n .sayq do_sayc
bind pub n .toma do_toma
bind pub n .tomaq do_tomaq
bind pub n .ctcp do_ctcp
#Comandos para master "m"
bind pub m .cleankick do_cleankick
bind pub m .cleanup do_mdeop
bind pub m .massop do_mop
bind pub m .uptime do_uptime
bind pub m .invite do_invite
bind pub m .op do_op
bind pub m .deop do_deop
bind pub m .kick do_kick
bind pub m .ban do_ban
bind pub m .unban do_unban
bind pub m .kickban do_kickban
bind pub m .voice do_voice
bind pub m .devoice do_devoice
bind pub m .addshit do_shit
bind pub m .delshit do_delshit
bind pub m .part do_part
bind pub m .join do_join
bind pub m .autovoz do_autovoz
bind pub m .autoop do_autoop
#comandos para oper "o"
bind pub o .help do_help
bind pub o .up do_up
bind pub o .down do_down
bind pub o .voz do_voz
bind pub o .devoz do_devoz
bind msg - !addhost msg_addhost

#PRINCIPIO DE LOS COMANDOS                                               
#Principio de voice
proc do_voice {nick host handle chan text} {
        set nombres [lrange [split $text " "] 0 end]
        if {$nombres eq ""} {
                putserv "privMSG $chan :Usa: !voice nicks (maximo 6 nicks a dar)"
                return
        }
        if {![botisop $chan]} {
	putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
	return 1
	}
        putlog "do_voice>> $text ($chan +v $nombres)"
        putserv "MODE $chan +vvvvvv $nombres"
	return 0
}
#final de voice
proc do_invite {nick host handle chan text} {
        set nombre [lrange [split $text " "] 0 end]
        if {$nombre eq ""} {
                putserv "privMSG $chan :Usa: !invite nick" 
	return
        }
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putlog "do_invite>> $text ($chan invite $nombre)"
        putserv "INVITE $nombre $chan" 
       return 0
}

#principio de devoice
proc do_devoice {nick host handle chan text} {
        set nombres [lrange [split $text " "] 0 end]
        if {$nombres eq ""} {
                putserv "PRIVMSG $chan :Usa: !devoice nicks (maximo 6 nicks a quitar)"
                return
        }
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putlog "do_devoice>> $text ($chan -v $nombres)"
        putserv "MODE $chan -vvvvvv $nombres"
	return 0
}
#final de devoice
#Principio de op
proc do_op {nick host handle chan text} {
        set nombres [lrange [split $text " "] 0 end]
	 if {$nombres eq ""} {
                putserv "PRIVMSG $chan :Usa: !op nicks (maximo 6 nicks a dar)"
                return
        }
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putlog "do_op>> $text ($chan +o $nombres)"
        putserv "MODE $chan +oooooo $nombres"
	return 0
}
#final de op

#principio de deop
proc do_deop {nick host handle chan text} {
        global botnick
        set nombres [lrange [split $text " "] 0 end]
        if {$nombres eq ""} {
                putserv "PRIVMSG $chan :Usa: !deop nicks (maximo 6 nicks a quitar)"
                return
        }
        if {[string tolower $nombres] == [string tolower $botnick]} {
        putserv "KICK $chan $nick :eso te pasa por pedirme que me quitara la @"
        return 1
        }
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
	if {[matchattr $nombres +n]} {
	putserv "MODE $chan -o $nick"
	putserv "PRIVMSG $chan :Que gracioso. $nick"
	putserv "KICK $chan $nick : Eso te pasa por leim."
	return 1
	}
	if {[matchattr $nombres +m]} {
	putserv "PRIVMSG $chan :$nick es master del bot ¿estas seguro?"
	return 1
	}	
	if {[matchattr $nombres +o]} {
	putserv "PRIVMSG $chan :$nick es oper del bot ¿estas seguro?"
	return 1
	}
        putlog "do_deop>> $text ($chan -o $nombres)"
        putserv "MODE $chan -oooooo $nombres"
}
#final de deop

#Principio cambio de vhost
proc msg_addhost {nick uhost handle text} {
set nickip [maskhost $nick!$uhost 7]
setuser $nick hosts $nickip
putlog "Actualizando handle de $nick $nickip"
putserv "PRIVMSG $nick :Has actualizado tu vhost en el acceso del bot: \002$nickip\002"
}
#final de cambio de host

#Principio de up
proc do_up {nick host handle chan text } {
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putlog "do_up>> $text ($chan -->> $nick)"
        putserv "MODE $chan +o $nick"
        putserv "PRIVMSG $chan :OP para $nick Concedido"
        return
}
#final de up

#principio de down
proc do_down {nick host handle chan text} {
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putserv "MODE $chan -o $nick"
        putlog "do_down>> $chan -->> $nick"
        putserv "PRIVMSG $chan :Deop para $nick Concedido"
        return
}
#final down

#principio de voz 
proc do_voz {nick host handle chan text } {
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putlog "do_voz>> $text ($chan -->> $nick)"
        putserv "MODE $chan +v $nick"
        putserv "PRIVMSG $chan :VOZ para $nick Concedido"
        return
}
#final de voz

#princio de devoz
proc do_devoz {nick host handle chan text} {
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
        putserv "MODE $chan -v $nick"
        putlog "do_devoz>> $chan -->> $nick"
        putserv "PRIVMSG $chan :DEVOZ para $nick Concedido"
        return
}
#final de devoz

#principio de Ignore
proc proc_ignore {nick uhost handle chan text} {
global chans 
	if {([lsearch -exact [string tolower $chan] [string tolower $chan]] != -1) || ($chans == "")} {
   newignore $text $nick "Ignore agregado por $nick el [clock format [clock seconds] -format "%d.%m%Y"] a las [clock format [clock seconds] -format %H:%M:%S] " 0 
   putserv "PRIVMSG $chan : 1« 1 Ignore agregado a $text 1«" 
  }
}
#final de ignore

#principio de quitar ignore
proc proc_quitarignore {nick uhost handle chan text} {
global chans 
	if {([lsearch -exact [string tolower $chan] [string tolower $chan]] != -1) || ($chans == "")} {
   killignore $text
   putserv "PRIVMSG $chan :1« 1 Ignore retirado a $text 1«" 
  }
}
#final de quitar ignore

#principio del ban
proc do_ban {nick uhost hand chan text} {
        global botnick
        set ban [lindex $text 0]
        if {$ban eq ""} {
                putserv "PRIVMSG $chan :Usa: !ban (nick!user@host)"
                return
        }
        if {[string tolower $ban] == [string tolower $botnick]} {
        putserv "KICK $chan $nick :eso te pasa por pedirme que me baneara a mi mismo"
        return 1
        }
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
	if {[matchattr $ban +n]} {
	putserv "PRIVMSG $chan :$nick es owner del bot ¿estas seguro?"
	return 1
	}
	if {[matchattr $ban +m]} {
	putserv "PRIVMSG $chan :$nick es master del bot ¿estas seguro?"
	return 1
	}
	if {[matchattr $ban +o]} {
	putserv "PRIVMSG $chan :$nick es oper del bot ¿estas seguro?"
	return 1
	}
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
 if {[string match *!*@* $ban]} {pushmode $chan +b $ban} {pushmode $chan +b *!*@[lindex [split [getchanhost $ban] @] 1]}
}
#final del ban
proc do_unban {nick uhost hand chan text} {
  set unban [lindex $text 0]
	 if {$unban eq ""} {
         putserv "PRIVMSG $chan :Usa: !unban (nick!user@host)"
         return
        }

        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
putserv "MODE $chan -b ${unban}"
putlog "do_unban>> $chan -->> $nick ${unban}"
putserv "PRIVIMSG $chan :quitando el ban ${unban}"
return
}
#princio de la help                                                        
proc do_help {nick uhost hand chan text} {
set options [list "" "owner" "master" "oper" ]
set subCommand [lindex [split $text " "] 0]
set arguments [join [lrange [split $text " "] 1 end] " "]
switch -- $subCommand {
{} {
  puthelp "PRIVMSG $nick :--\0033Comandos para OWNERS\003--."
  puthelp "PRIVMSG $nick :\002!adduser\002 <handle> "
  puthelp "PRIVMSG $nick :\002!delser\002 <handle> "
  puthelp "PRIVMSG $nick :\002!flags\002 <handle> "
  puthelp "PRIVMSG $nick :\002!rehash\002 recargara scripts y directivas (eggdrop.conf)."
  puthelp "PRIVMSG $nick :\002!die\002 Mata el bot."
  puthelp "PRIVMSG $nick :\002!ignore <nick> \002 Ignora a un nick del bot."
  puthelp "PRIVMSG $nick :\002!uignore <nick> \002 desIgnora a un nick del bot."
  puthelp "PRIVMSG $nick :--\0033Comandos para MASTERS y OWNERS\003--"
  puthelp "PRIVMSG $nick :--fin de comandos para masters"
  puthelp "PRIVMSG $nick :\002!op\002 <nicks separados con espacio> da op a uno o varios usuarios (maximo 6)"
  puthelp "PRIVMSG $nick :\002!deop\002 <nicks separados con espacios> quita op a uno o varios usuarios (maximo 6)"
  puthelp "PRIVMSG $nick :\002!kick\002 <nick> <razon> expulsa a un usuario)"
  puthelp "PRIVMSG $nick :\002!cleanup\002 expulsa a todos los uusarios del canal sin @ ni voice)"
  puthelp "PRIVMSG $nick :\002!ban\002 <nick> banea un usuario)"
  puthelp "PRIVMSG $nick :\002!unban\002 nick!user@host osease el ban que hayais puesto :D"
  puthelp "PRIVMSG $nick :\002!kickban\002 <nick> <razon> expulsa a un usuario)"
  puthelp "PRIVMSG $nick :\002!voice\002 <nicks separados con espacio> da voice a uno o varios usuarios (maximo 6)"
  puthelp "PRIVMSG $nick :\002!devoice\002 <nicks separados con espacios> quita voice a uno o varios usuarios (maximo 6)"
  puthelp "PRIVMSG $nick :\002!addshit\002 <nick> lo añadira a la shitlist del canal donde pongais el comando ."
  puthelp "PRIVMSG $nick :\002!delshit\002 <nick> quitara al nick de la shitlist del canal donde pongais el comando."
  puthelp "PRIVMSG $nick :\002!autoop\002 on|off"
  puthelp "PRIVMSG $nick :\002!autovoz\002 on|off"
  puthelp "PRIVMSG $nick :\002!join\002 <#canal> "
  puthelp "PRIVMSG $nick :\002!part\002 <#canal>"
  puthelp "PRIVMSG $nick :\002!hop\002 lo ara en el canal" 
  puthelp "PRIVMSG $nick :--\0033Comandos para OPERS OWNERS MASTERS\003--"
  puthelp "PRIVMSG $nick :\002!up\002 te da op"
  puthelp "PRIVMSG $nick :\002!down\002 te la quita la op"
  puthelp "PRIVMSG $nick :\002!voz\002 te da voz"
  puthelp "PRIVMSG $nick :\002!devoz\002 te quita la voz"

  puthelp "PRIVMSG $nick :--"
  puthelp "PRIVMSG $nick :\0034Si encontrais algun fallo o teneis alguna sugerencia \00312ghosty9087@gmail.com.\003"
}
{owner} {
puthelp "PRIVMSG $chan :\00312!join !part !hop !up !down !op !deop !voice !devoice !voz !devoz !autoop !autovoz !kick !cleanup !ban !unban !kickban !rehash !addshit !delshit !adduser !deluser !flags !die\003."
return
}
{master} {
puthelp "PRIVMSG $chan :\00312!up !down !op !deop !voice !devoice !voz !devoz !autoop !autovoz !kick !cleanup !ban !unban !kickban !addshit !delshit\003."
return
}
{oper} {
puthelp "PRIVMSG $chan :\00312!up !down !op !voz !devoz."
return
}

default { putserv "PRIVMSG $chan  :Hola, $subCommand no es válido. Usa uno de estos: [join $options {, }]"
}
}
}
#final del help
#principio rehash

proc do_rehash {nick host handle channel text} {
 global botnick
 set who [lindex $text 0]
 if {$who == ""} {
 rehash
 putquick "PRIVMSG $channel :OK."
 return 1
}
}
#final rehash
#principio del kick
proc do_kick {nick uhost hand chan text} {
	global botnick
	set kickeado [lindex $text 0]
	set razon [lrange $text 1 end]
	if {$kickeado == ""} {
	putserv "PRIVMSG $chan :Usa: !kick Nick Razon"
	return 1
	}
        if {[string tolower $kickeado] == [string tolower $botnick]} {
        putserv "KICK $chan $nick :eso te pasa por pedirme que me echara a mi mismo"
        return 1
 	}
	if {[matchattr $kickeado +n]} {
	putserv "PRIVMSG $chan :$nick es owner del bot ¿estas seguro?"
	return 1
	}
	if {[matchattr $kickeado +m]} {
	putserv "PRIVMSG $chan :$nick es master del bot ¿estas seguro?"
	return 1
	}
	if {[matchattr $kickeado +o]} {
	putserv "PRIVMSG $chan :$nick es oper del bot ¿estas seguro?"
	return 1
	}
        if {![botisop $chan]} {
        putserv "PRIVMSG $chan :No puedo complacerte $nick, no tengo +o."
        return 1
        }
	if {![onchan $kickeado $chan]} {
	putserv "PRIVMSG $chan :$kickeado no se encuentra en $chan"
	return 1
	}
	putlog "do_kick>> $chan $kickeado :$razon"
	putserv "KICK $chan $kickeado :$razon"
	return 1
	}
#Final del kick
#principio de shit
proc do_shit {nick host handle chan testes} {
global botnick
set why [lrange $testes 1 end]
set who [lindex $testes 0]
set ban *!*@[lindex [split [getchanhost $who $chan] {@}] 1]
if {$who == ""} {
putserv "PRIVMSG $chan :Usa: !addshit <nick a añadir> razon"
set ban *!*@[lindex [split [getchanhost $who $chan] {@}] 1]
return 1
}
if {![onchan $who $chan]} {
putserv "PRIVMSG $chan :$who no se encuentra en $chan."
return 1
}
if {[string tolower $who] == [string tolower $botnick]} {
putserv "KICK $chan $nick :No me me añadire a mi mismo."
return 1
}
if {[matchattr $who +n]} { 
putserv "PRIVMSG $chan :$nick es owner del bot ¿estas seguro?" 
return 1
}
if {[matchattr $who +m]} {
putserv "PRIVMSG $chan :$nick es master del bot ¿estas seguro?"
return 1
}
if {[matchattr $who +o]} { 
putserv "PRIVMSG $chan :$nick es oper del bot ¿estas seguro?" 
return 1
}

newchanban $chan $ban $nick $why
stick $ban $chan
putserv "KICK $chan $who :$why"
putlog "$nick añade en la shit a $who $ban razon: $why."
putserv "PRIVMSG $chan :shitlist \002$who\002 en el canal \002$chan\002 con la razon: \002$why\002."
return 1
}
#Final de shit
#principio de delshit
proc do_delshit {nick host handle chan testes} {
set who [lindex $testes 0]
if {$who == ""} {
putserv "PRIVMSG $chan  :Usa !delshit <Shit to remove>"
return 1
}
killchanban $chan $who
putlog "$nick :borra a $who de la  shitlist."
putserv "PRIVMSG $chan :$who borrado de la shitlist."
return 1
}


#final de delshit
#Principio de restart
proc do_restart  {nick host handle channel testes} {
 global botnick
 set who [lindex $testes 0]
 if {$who == ""} {
 restart
 putquick "PRIVMSG $channel : Me reinicias......"
 return 1
}
}
#final de restart
#principio del uptime
proc do_uptime {nick host handle chan arg} {
 global uptime
 set uu [unixtime]
 set tt [incr uu -$uptime]
 set verCoCo "1.3"
 puthelp "privmsg $chan : $nick Mi Uptime es:\0032 [duration $tt]\003 Script \002$verCoCo\002"
return
}
#final del uptime
#addchattr para añadir flags

proc do_flags {nick uhost handle chan arg} {
 set handle [lindex $arg 0]
 if {$handle == ""} {
  puthelp "privmsg $chan :!flags <handle> <+|-><flags> !"
  return o
 }
set flags [lindex $arg 1]
 if {![validuser $handle]} {
  puthelp "privmsg $chan :$nick: esa handle no existe!"
  return 0
 }
 if {$flags == ""} {
  puthelp "privmsg $chan :$nick: Syntax: !flags <handle> <+|-><flags>"
  return 0
 }
 chattr $handle $flags
 puthelp "privmsg $chan :añadido! $nick."
return
}
#adduser

proc do_adduser {nick uhost handle chan arg} {
 set handle [lindex $arg 0]
 set hostmask [lindex $arg 1]
 if {[validuser $handle]} {
  puthelp "privmsg $chan :Este usuario ya existe!!!"
  return 0
 }
 if {$hostmask == ""} {
  set host [getchanhost $handle]
  if {$host == ""} {
   puthelp "privmsg $chan :no puedo añadir handle incorrecta ($handle)"
   puthelp "privmsg $chan :Syntax: !adduser <handle> <mascara:(nick!user@host)>"
   return 0
 }
  if {![validuser $handle]}  {
   adduser $handle *!$host
   puthelp "privmsg $chan :Añadido!"
  }
 }
  if {![validuser $handle]}  {
  adduser $handle $hostmask
  puthelp "privmsg $chan :Añadido!"

  }
 }
#final del adduser
#principio de deluser

proc do_deluser {nick uhost handle chan arg} {
 set handle [lindex $arg 0]
 set hostmask [lindex $arg 1]
 if {[validuser $handle]} {
  deluser $handle
  puthelp "privmsg $chan :Ha sido borrado"
  return 0
 }
 if {![validuser $handle]} {
  puthelp "privmsg $chan :no se encuentra!"
  return 0
 }
}
#final de deluser
#principio del DIE
proc do_die {nick host handle chan text} {
 global botnick
 set texto [lindex $text 0]
 if {$texto == ""} {
 putquick "PRIVMSG $chan :Me voy adios!!"
 putlog "do_die>> $nick me mata"
 rehash
 die
return 1
}
}
#final del die
#principio del join

proc do_join { nick uhost hand chan text } {
 putlog "Entrando al canal $text Me lo Ordena $nick"
 putserv "PRIVMSG $chan :Entrando al Canal $text a Peticion de $nick"
 putserv "JOIN :$text"
 channel add $text
 putserv "PRIVMSG $chan :"
}
#final del join 
#principio del part
proc do_part { nick uhost hand chan text } {
set chan1 [lindex [split $text " "] 0]
 if {$chan1 == ""} {
 putlog "do_part>> saliendo de $chan1 orenado por $nick"
 putserv "PRIVMSG $chan :saliendo de $chan ordenado por $nick"
 putserv "PART :$chan"
 channel remove $chan
return 1
}
if {![validchan $chan1]} {
putmsg $chan "no te inventes canales hijo de la gran puta"
return
}
if {![onchan $::botnick $chan1]} {
putmsg $chan "yo no estoy en ese canal"
return
}
putlog "Parting $chan1 by $nick Request"
putserv "PRIVMSG $chan :Saliendo del Canal $chan1 a Peticion de $nick"
channel remove $chan1
return 1
}
#final del part
#principio del kickban
proc do_kickban {nick uhost hand chan text} {
global botnick
set kickeado [lindex $text 0]
set razon [lrange $text 1 end]
if {$kickeado == ""} {
putserv "PRIVMSG $chan :Uso: !kickban Nick Razon"
return 1
}
if {[matchattr $kickeado +n]} {
putserv "PRIVMSG $chan :$nick es owner del bot ¿estas seguro?"
return 1
}
if {[matchattr $kickeado +m]} {
putserv "PRIVMSG $chan :$nick es master del bot ¿estas seguro?"
return 1
}
if {[matchattr $kickeado +o]} {
putserv "PRIVMSG $chan :$nick es oper del bot ¿estas seguro?"
return 1
}

if {![onchan $kickeado $chan]} {
putserv "PRIVMSG $chan :$kickeado no se encuentra en $chan"
return 1
}
if {[string tolower $kickeado] == [string tolower $botnick]} {
putserv "MODE $chan +b ${kickeado}!*@*"
putserv "KICK $chan $nick :toma kickban a mi mismo :D"
      putlog "do_kickban>> :$nick te intenta echar de $chan"
return 1
}
putserv "MODE $chan +b ${kickeado}!*@*" 
putserv "KICK $chan $kickeado :$razon"
return 1
}
#Final del kickban
#principio hop
proc do_hop {nick uhost hand chan text} {
set canal [lindex $text 0]
 if {$canal == ""} {
 putlog "do_hop>> reentro en $chan ordenado por $nick"
 putserv "PRIVMSG $chan : Reentrando ordenado por $nick"
 putserv "PART :$chan"
 putserv "JOIN :$chan"
return 1
}
 putlog "do_hop>> reentro en $canal ordenado por $nick"
 putserv "PRIVMSG $chan : Reentrando en $canal ordenado por $nick"
 putserv "PART :$canal"
 putserv "JOIN :$canal"
}
#final hop
#Proceso para que el bot de voz cuando entra al canal donde este activao ou yeah
catch {bind join - * do_darvoz}
proc do_darvoz {nick uhost hand chan} {
  if {[lsearch -exact [channel info $chan] +autov] != -1} {
    putquick "MODE $chan +v $nick"
    return 0
  }
}
proc do_autovoz {nick uhost hand chan arg} {
  switch -exact -- $arg {
    "on" {
      channel set $chan +autov
      putserv "PRIVMSG $chan :AutoVoz Activado para: $chan"
      putlog "do_autovoice>> ctivado en $chan"
    }
    "off" {
      channel set $chan -autov
      putserv "PRIVMSG $chan :AutoVoz Desactivado en: $chan"
      putlog "do_autovoice>> desactivado en $chan"
    }
    "default" {
   putserv "PRIVMSG $chan :sintaxis !autovoz on|off"

  }
}
}
setudef flag autov
#final del autovoz
#principio del proceso para dar op a todos los usuarios en el canal
catch {bind join - * do_darop}
proc do_darop {nick uhost hand chan} {
  if {[lsearch -exact [channel info $chan] +autoo] != -1} {
    putquick "MODE $chan +o $nick"
    return 0
  }
}
proc do_autoop {nick uhost hand chan arg} {
  switch -exact -- $arg {
    "on" {
      channel set $chan +autoo
      putserv "PRIVMSG $chan :AutoOP Activado para: $chan"
      putlog "do_autoop>> ctivado en $chan"
    }
    "off" {
      channel set $chan -autoo
      putserv "PRIVMSG $chan :AutoOP Desactivado en: $chan"
      putlog "do_autoop>> desactivado en $chan"

    }
    "default" {
   putserv "PRIVMSG $chan :sintaxis !autoop on|off"
  }
}
}
setudef flag autoo
proc do_say {nick uhost handle chan arg} {
puthelp "privmsg $chan :$arg"
putlog "do_say>> $chan :$arg"
return
}
proc do_say {nick uhost handle chan arg} {
puthelp "privmsg $chan :$arg"
putlog "do_say>> $chan :$arg"
return
}
proc do_ctcp {nick uhost handle chan text} {
set elnick [lindex $text 0]
set envio [lrange $text 1 end]
putserv "PRIVMSG $elnick :\001$envio\001"
putserv "PRIVMSG $chan :Realizo un ctcp $envio a $elnick."
putlog "do_ctcp>> $elnick :$envio"
return
}
proc do_cleankick {nick uhost hand chan arg} {
  set dorks [chanlist $chan]
  set dorklist ""
  set reason "Limpieza de canal ordenada por $nick"
  foreach p $dorks {
    set who [nick2hand $p $chan]
    if {![matchattr $who o] && ![isop $p $chan] && ![isvoice $p $chan]} {
      append dorklist " " $p
    }
  }
  if {$dorklist == ""} {
    putserv "PRIVMSG $chan :No veo a nadie al que tenga que kickear"
    return 0
  }
  set blah "[llength $dorklist]"
  putserv "PRIVMSG $chan :Expulso \]\002$blah\002\] Users:\002$dorklist\002"
  set count 0
  while {$count < $blah} {
    putserv "KICK $chan [lindex $dorklist $count] :$reason"
    incr count 1
  }
  return 1

}
proc do_mdeop {nick uhost hand chan text} {
	 set perLine 6
     # esta variable va a contar cuántos nicks van ya
     set i 0
     # aquí voy guardando los nicks por orden
     set nickList [list]
     foreach target [chanlist $chan] {

         # Si es el propio bot o no tiene @ no me interesa
         if {([isbotnick $target]) || (![isop $target $chan])} {
             # por tanto continua con el siguiente nick sin hacer nada
             # de lo que va después de este comando
             continue
         }
         # Si he contado menos nicks de los que quiero por línea,
         # sigo añadiendo a otro
         if {$i <= $perLine} {
             lappend nickList $target
         incr i
             putlog ">> $nickList"
         } else {
             # Y de lo contrario...
             putserv "MODE $chan -[string repeat "o" $i] [join $nickList " "]"
             # y ahora que ya está hecho, vuelvo a empezar
             set i 0
             set nickList [list]
         }
     }
     if {[llength $nickList] > 0} {
         putserv "MODE $chan -[string repeat "o" $i] [join $nickList " "]"
     }
}

proc do_mop {nick uhost hand chan text} {
         set perLine 6
     # esta variable va a contar cuántos nicks van ya
     set i 0
     # aquí voy guardando los nicks por orden
     set nickList [list]
     foreach target [chanlist $chan] {

         # Si es el propio bot o no tiene @ no me interesa
         if {([isbotnick $target])} {
             # por tanto continua con el siguiente nick sin hacer nada
             # de lo que va después de este comando
             continue
         }
         # Si he contado menos nicks de los que quiero por línea,
         # sigo añadiendo a otro
         if {$i <= $perLine} {
             lappend nickList $target
         incr i
             putlog ">> $nickList"
         } else {
             # Y de lo contrario...
             putserv "MODE $chan [string repeat "o" $i] [join $nickList " "]"
             # y ahora que ya está hecho, vuelvo a empezar
             set i 0
             set nickList [list]
         }
     }
     if {[llength $nickList] > 0} {
         putserv "MODE $chan [string repeat "o" $i] [join $nickList " "]"
     }
}
proc do_toma {nick uhost handle chan text} {
set toma [lindex $text 0]
if {$toma == ""} {
puthelp "privmsg $chan :Expecifica el nick."
return 1
}
putlog "do_toma>> $chan :$toma"
putnow "privmsg $chan :               /´¯/)"
putnow "privmsg $chan :             /¯  /"
putnow "privmsg $chan :            /   /"
putnow "privmsg $chan :      /´¯/'   '/´¯¯`·¸"
putnow "privmsg $chan :   /'/   /    /       /¯|"
putnow "privmsg $chan : ('(   ´   ´     ¯~/'    ')"
putnow "privmsg $chan :  \                 '     /"
putnow "privmsg $chan :   '\'   \           _ ·´"
putnow "privmsg $chan :Mira $toma PATI!!!"
return 1
}
proc do_tomaq {nick uhost handle chan text} {
set toma [lindex $text 0]
if {$toma == ""} {
puthelp "privmsg $chan :Expecifica el nick."
return 1
}
putlog "do_tomaq>> $nick :$toma"
putnow "privmsg $toma :               /´¯/)"
putnow "privmsg $toma :             /¯  /"
putnow "privmsg $toma :            /   /"
putnow "privmsg $toma :      /´¯/'   '/´¯¯`·¸"
putnow "privmsg $toma :   /'/   /    /       /¯|"
putnow "privmsg $toma : ('(   ´   ´     ¯~/'    ')"
putnow "privmsg $toma :  \                 '     /"
putnow "privmsg $toma :   '\'   \           _ ·´"
putnow "privmsg $toma :Mira $toma PATI!!!"
return 1
}

#Mensaje de carga del script
set verCoCo "1.3"
putlog "\002publico.tcl\002 por \0032CoCoLoCo\003 Version \002$verCoCo\002 cargado con exito"
putlog "Si funciona mal dirigase a #eggdrop en ChatHispano"
