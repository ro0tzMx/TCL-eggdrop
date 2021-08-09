# rules1.0.tcl inspired by `Dracu|a`
# rewritten from tell1.1.tcl (Lassi Lahtinen lahtinen.lassi@nic.fi) by Wanderer|
# final debug by ShadowLord
# email me @: jjmacgregor@kscable.com
# version 1.0 a simple and to the point TCL :)

# You can ask help:
# 1. by emailing me
# 2. I'm on Dalnet in #VladTepes
# 3. Wanderer| is on UnderNET in #TCL
# thanks a lot to Wanderer| and ShadowLord!

# actualizado por sedition
# si quieres contactarme buscame en
# IRC: /server irc.dal.net canales #tcls #cremacamba mis nick's sedition o Arnold_X-P
# tambien estoy en irc.chatzona.org canal #tcl y #la
# o enviame un email a: reebot@outlook.com urquizoandrade@gmail.com

# usted puede agregar todas sus reglas en una sola linea :
# set chanrules {
# "las reglas del canal son: 1.-1.- No Mayúsculas: Por lo general significan gritar en el IRC, gracias por no gritar!, 2.- No Flood: Se considera Flood al hacer mas de 4 lineas seguidas o dibujos grandes, esto te puede costar un BAN."
# }
# o tambien por partes...

# comandos: puedes usar !reglas y el bot te dira las reglas.
# o tambien puedes usar !reglas nick y le dira las reglas al nick que seleccionaste ejemplo !reglas sedition

set chanrules {
"%nick a continuación las reglas del canal %chan"
"1.- No Mayúsculas: Por lo general significan gritar en el IRC, gracias por no gritar!"
"2.- No Flood: Se considera Flood al hacer mas de 4 lineas seguidas o dibujos grandes, esto te puede costar un BAN."
"3.- No Regionalismos: Si empiezas a discriminar a otros usuarios, serás baneado sin reclamo alguno"
"4.- No Groserias o insultos: No se aceptan warangos de ninguna clase en el canal, te comportas o te sales, asi de sencillo."
"5.- No Repeticiones: No repitas seguidamente basicamente con una se te lee o puedes hacer cada cierto tiempo largo."
"6.- No Spam o inviters: Esta totalmente prohibido, enviar invitaciones a otros canales, enviar publicidad automática o tratar de vender, comprar articulos en el canal!"
"7.- No emails/telefonos: Esta prohibido el compartir o poner el canal público emails o números de teléfono"
}

# escoja el metodo que el bot usara, para lanzar las reglas de tu canal
# 0 = mensaje via notice o noticia al nick que solicite !reglas
# 1 = mensaje via abierto canal
# 2 = mensaje privado al nick que solicite !reglas

set noticeoptionxp 1

#comandos, puedes agregar mas comandos como desees
set rules_command "!reglas .reglas !rules .rules"

foreach ruleschans [split $rules_command] {bind pub - $ruleschans pub:t}

proc pub:t {nick uhost hand chan text} {
global chanrules noticeoptionxp
set rulenick [lindex [split $text " "] 0]
if {$text != "" && [onchan $rulenick $chan]} {
puthelp "NOTICE $rulenick :estas son las reglas de nuestro canal. Presta atencion!"
foreach line $chanrules {
regsub -all -- {%nick} $line "$nick" line
regsub -all -- {%chan} $line "$chan" line
puthelp "NOTICE $rulenick :$line" }
return 0
}
if {$noticeoptionxp == "0"} {
foreach line $chanrules {
regsub -all -- {%nick} $line "$nick" line
regsub -all -- {%chan} $line "$chan" line
puthelp "NOTICE $nick :$line" }
}
if {$noticeoptionxp == "1"} {
foreach line $chanrules {
regsub -all -- {%nick} $line "$nick" line
regsub -all -- {%chan} $line "$chan" line
puthelp "PRIVMSG $chan :$line" }
}
if {$noticeoptionxp == "2"} {
foreach line $chanrules {
regsub -all -- {%nick} $line "$nick" line
regsub -all -- {%chan} $line "$chan" line
puthelp "PRIVMSG $nick :$line" }
}
}

putlog "\002rules 2.0 by `Dracu|a` actualizado por sedition"