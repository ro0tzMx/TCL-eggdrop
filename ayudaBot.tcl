#------------------------------------------------------------#
#       Servicio de Ayuda Opers_help                                      #
#------------------------------------------------------------#

##AUTOR : Desconocido
##VERSION : 1.0
##EMAIL : Desconocido

###############
# DESCRIPCIÓN #
###############
#Cuando un usuario entre al canal #opers_help el Bot(Bautista) le mandara privado solicitandole la ayuda que necesite,
#El usuario pondrá su duda en el privado del Bot y este lo notificara al canal #opers, donde un operador
#Vera si acepta la ayuda o lo deniega con el comando help estando en el canal #opers,
#Este servicio funciona en varios tipos de servidores irc como ircuh, unreal,
#DarKu etc.

set canal_ayuda "#Opers_Help"
set canal_bot   "#Opers"

set ctcp-version "roBOT destinado a la Ayuda en #Opers_Help"

bind join - * msg:join
bind part - * msg:part
bind msgm - "*" msg:opers

bind pubm - "*" pub_atender


set confirmados_db "bautistadb/confirmados.dat"

proc confirmar_addentrada {nick} {
global confirmados_db;

   set nick [string tolower $nick]

   if {![file exists $confirmados_db]} {
       file mkdir [lindex [split $confirmados_db /] 0]
       set fp [open $confirmados_db w+]
       puts $fp "Usuarios que aceptaron las condiciones de confidencialidad."
       close $fp
   } else {
       set fp [open $confirmados_db a]
       puts $fp "$nick - [ctime [unixtime]]"
       close $fp
   }
}


proc msg:join { nick host handle chan } {
global botnick canal_ayuda canal_bot

   if {$botnick == $nick} {
       return 0
   }

   if {[string match -nocase "$canal_ayuda" $chan]} {
       if {![validuser $nick]} {
               putquick "PRIVMSG $nick :Hola $nick, soy el encargado de ponerte en contacto con un OPER. \2Por favor, ¿podrías describirme en una línea el problema?\2"
               putquick "PRIVMSG $canal_bot :\00312$nick\003 entra a \00312$chan\003"
       }
   }

   if {[string match -nocase "$canal_bot" $chan]} {
       if {![validuser $nick]} {
               putquick "PRIVMSG $nick :Hola, soy \00312$botnick\003, encargado de gestionar las consultas que se realizan en \00312$canal_ayuda\003."
               putquick "PRIVMSG $nick :Para poder utilizarme es necesario que estes dado de alta en mi DB, escribe \2/MSG $botnick ALTA\2"
       }
       if {[matchattr $nick O] && [botisop $chan]} {
                putserv "MODE $chan +o $nick"
       }
   }
}

proc msg:part { nick host handle chan msg } {
global botnick canal_ayuda canal_bot

   if {$nick == $botnick} {
       return 0
   }

   if {[string match -nocase "$canal_ayuda" $chan]} {
       putquick "PRIVMSG $canal_bot :\00312$nick\003 sale de \00312$chan\003"
   }
}

proc msg:opers {nick uhost hand text} {
global botnick canal_ayuda canal_bot

   if {$nick == $botnick} {
       return 0
   }

   set cmd [lindex $text 0]
   if {[string match -nocase "help" $cmd] && [onchan $nick $canal_bot]} {
       if {[matchattr $nick O]} {
               putquick "PRIVMSG $nick :\2Ayuda de $botnick\2"
               putquick "PRIVMSG $nick : "
               putquick "PRIVMSG $nick :\2.Aceptar nick\2 - Atiendes la consulta del nick especificado."
               putquick "PRIVMSG $nick :\2.Rechazar nick\2 - Deniegas la consulta del nick especificado"
               putquick "PRIVMSG $nick :\2.Finalizar nick\2 - Finalizas la consulta del nick especificado."
               putquick "PRIVMSG $nick :\2.Ban nick\2 - Expulsas al usuario del canal \00312$canal_ayuda\003"
               putquick "PRIVMSG $nick : "
               putquick "PRIVMSG $nick :\0034IMPORTANTE\003: Recuerda que has firmado un contrato de confidencialidad,"
               putquick "PRIVMSG $nick :cumple las normas y haz un buen uso de este servicio."
               return 0
       }

       if {[validuser $nick] && ![matchattr $nick O]} {
               putquick "PRIVMSG $nick :\2Normas\2"
               putquick "PRIVMSG $nick :Normas del uso de $botnick: No hacer flood al bot, no atender al mismo nick varios OPER's, no expulsar al bot del canal"
               putquick "PRIVMSG $nick :Normas del canal $canal_bot: Canal confidencial, lo que pasa en $canal_bot no sale de $canal_bot."
               putquick "PRIVMSG $nick : "
               putquick "PRIVMSG $nick :\0034CONFIRMACION\003"
               putquick "PRIVMSG $nick :Confirmas cumplir las normas de uso de $botnick y del canal $canal_bot mencionadas líneas arriba."
               putquick "PRIVMSG $nick :Firmas el contrato de confidencialidad de este Canal, asumiendo las consecuencias al romperlo."
               putquick "PRIVMSG $nick :Aceptas cualquier sanción adquirida por el incumplimiento de cualquiera de las normas ya mencionadas"
               putquick "PRIVMSG $nick :Para aceptar escribe: \2/msg $botnick CONFIRMACION 273912\2"
               return 0
       }
       return 0
    }

   if {[string match -nocase "ALTA" $cmd] && [onchan $nick $canal_bot]} {
       if {[validuser $nick]} {
               putquick "PRIVMSG $nick :Ya te encuentras dado de alta en $botnick"
               return 0
       }
       set addusermask [maskhost $nick![getchanhost $nick $canal_bot]]
       adduser $nick $addusermask
       set addusernick [nick2hand $nick]
       putquick "PRIVMSG $canal_bot :\2$nick\2 se acaba de dar de ALTA."
       putquick "PRIVMSG $nick :Por favor, escribe: \2/MSG $botnick HELP\2"
       unset addusermask
       unset addusernick
       return 0
   }

   if {[string match -nocase "CONFIRMACION" $cmd]} {
       if {[matchattr $nick O]} {
               putquick "PRIVMSG $nick :No necesitas volver a confirmar."
               return 0
       }
       if {[validuser $nick] && [onchan $nick $canal_bot]} {
               set cod [lindex $text 1]
               if {[string match -nocase "273912" $cod]} {
                       chattr $nick +O|
                       putquick "PRIVMSG $nick :Confirmación realizada correctamente, utiliza: \2/MSG $botnick HELP\2"
                       confirmar_addentrada $nick
                       return 0
               }
       }
       return 0
   }

   if {[string match -nocase "SILENCE" $cmd]} {
       if {![matchattr $nick O]} {
               return 0
       }

       set opcion [lindex $text 1]
       set mascara [lindex $text 2]
       if {$opcion == "" || $mascara == ""} {
               putquick "PRIVMSG $nick :\2Sintaxis:\2 \00312SILENCE \[ADD|DEL|LIST\] máscara\003"
               return 0
       }

       switch $opcion        {
               "add"        {
                       if {[isignore $mascara] == 1} {
                               putquick "PRIVMSG $nick :La máscara \00312$mascara\003 ya se encuentra agregada en mi db."
                               return 0
                       }
                       newignore $mascara $nick solicitado 60
                       putquick "PRIVMSG $canal_bot :Nuevo Silence Agregado: \00312$mascara\003 por \00312$nick\003"
                       putquick "PRIVMSG $nick :Nuevo silence: \00312$mascara\003"
               }
               "del"   {
                       if {[isignore $mascara] == 0} {
                               putquick "PRIVMSG $nick :La máscara \00312$mascara\003 no se encuentra agregada en mi db."
                               return 0
                       }
                       killignore $mascara
                       putquick "PRIVMSG $canal_bot :Silence eliminado: \00312$mascara\003 por \00312$nick\003"
                       putquick "PRIVMSG $nick :Silence eliminado: \00312$mascara\003"
               }
               "list"   {
                       foreach ignore [ignorelist] {
                               putquick "PRIVMSG $nick :$ignore"
                       }
               }
               default {
                       putquick "PRIVMSG $nick :Opción inválida."
               }
       }
       return 0
  }


  if {[matchattr $nick O]} {
       return 0
   }

  if {![onchan $nick $canal_ayuda]} {
       return 0
   }

   set operadores 0
   foreach user [chanlist $canal_bot] {
       if {[isop $user $canal_bot] && $botnick != $user } {
               incr operadores
       }
   }
   set mensaje [lrange $text 0 end]
   if  {$operadores > 0} {
       putquick "PRIVMSG $canal_bot :El usuario \00312$nick\003 está solicitando ayuda -> \2$mensaje\2"
       putquick "PRIVMSG $canal_bot :\2\0034Opciones\003\2: .Aceptar \2|\2 .Rechazar \2|\2 .Finalizar \2|\2 .Ban "
       putquick "PRIVMSG $canal_bot :-----------"
       putquick "PRIVMSG $nick :Gracias, en breve te informaré del nick del OPERador/a que te va a ayudar. Por favor, no abandones el canal mientras eres atendido/a."
   } else {
       putserv "PRIVMSG $nick :Lamento comunicarle que en este momento no hay OPERadores disponibles, por favor abandone el canal \2$canal_ayuda\2 y vuelva después."
   }
}

proc pub_atender {nick uhost hand chan text} {
global botnick canal_ayuda canal_bot

   if {![string match -nocase "$canal_bot" $chan]} {
       return 0
   }

   if {$nick == $botnick} {
       return 0
   }

   set cmd [lindex $text 0]
   set usuario [lindex $text 1]

   if {[string match -nocase ".aceptar" $cmd] && [matchattr $nick O]} {
       if {$usuario == ""} {
               putquick "PRIVMSG $canal_bot :$nick, debes especificar el nick."
               return 0
       }
       if {![onchan $usuario $canal_ayuda]} {
               putquick "PRIVMSG $canal_bot :$nick, el usuario $usuario no se encuentra dentro del canal $canal_ayuda"
               return 0
       }
       if {[isvoice $usuario $canal_ayuda]} {
               putquick "PRIVMSG $canal_bot :$usuario, ya se encuenta siendo atendid@"
               return 0
       }
       putquick "PRIVMSG $canal_bot :El usuario \00312$usuario\003 ha sido asignado a \00312$nick\003"
       putquick "PRIVMSG $usuario :El OPERador \00312$nick\003 se pondrá en contacto contigo en un momento."
       putserv "MODE $canal_ayuda +v $usuario"
       return 0
   }

   if {[string match -nocase ".rechazar" $cmd] && [matchattr $nick O]} {
       if {$usuario == ""} {
               putquick "PRIVMSG $canal_bot :$nick, debes especificar el nick."
               return 0
       }
       if {![onchan $usuario $canal_ayuda]} {
               putquick "PRIVMSG $canal_bot :$nick, el usuario $usuario no se encuentra dentro del canal $canal_ayuda"
               return 0
       }
       putquick "PRIVMSG $usuario :Lo sentimos, pero su consulta a sido denegada"
       putquick "PRIVMSG $usuario :abandone el canal \2$canal_ayuda\2"
       return 0
   }

   if {[string match -nocase ".finalizar" $cmd] && [matchattr $nick O]} {
       if {$usuario == ""} {
               putquick "PRIVMSG $canal_bot :$nick, debes especificar el nick."
               return 0
       }
       if {![onchan $usuario $canal_ayuda]} {
               putquick "PRIVMSG $canal_bot :$nick, el usuario $usuario no se encuentra dentro del canal $canal_ayuda"
               return 0
       }
       putquick "PRIVMSG $canal_bot :El OPERador \00312$nick\003 ha finalizado la sesión de \00312$usuario\003"
       putquick "PRIVMSG $usuario :Por favor, abandone el canal una vez atendido."
       putquick "PRIVMSG $usuario :Si su duda o problema no fue resuelto igualmente abandone el canal y vuelva a ingresar para que otro OPERador tome su consulta, gracias."
       putserv "MODE $canal_ayuda -v $usuario"
       return 0
   }

   if {[string match -nocase ".ban" $cmd] && [matchattr $nick O]} {
       if {$usuario == ""} {
               putquick "PRIVMSG $canal_bot :$nick, debes especificar el nick."
               return 0
       }
       if {![onchan $usuario $canal_ayuda]} {
               putquick "PRIVMSG $canal_bot :$nick, el usuario $usuario no se encuentra dentro del canal $canal_ayuda"
               return 0
       }
       set kick_close  "Por favor, regresa cuando tengas una consulta que realizar. Gracias."
       set banmask [maskhost *![getchanhost $usuario $canal_ayuda]]
       #newchanban $canal_ayuda $banmask $botnick $kick_close 10
       pushmode $canal_ayuda +b $banmask
       flushmode $canal_ayuda
       utimer 5 [putkick $canal_ayuda $usuario $kick_close]
       return 0
   }
}

putlog "\2Bautista.tcl v1.0\2 : Cargado."