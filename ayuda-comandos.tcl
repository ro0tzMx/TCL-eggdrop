## Tcl de ayudas por Arnold_X-P red DALnet canal #tcls ##
# Tipo de Servicios - Anope 2.9.0##
# TCL editado y adaptado para redes con Anope.##
# Editado por device, irc.puntochat.net ##
## aqui el nombre de tu canal donde funcionara la tcl ##
set ayudascomando "#ayuda"

bind pub - !Chan pub_cs

proc pub_cs {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick, Ayuda para CHaN, para verlas teclea como estan aquí: !IdentificarCanal !CambiarFounder !DescripcionCanal !UrlCanal !Keeptopic !Topiclock !mlock !CanalPrivado !CanalRestringido !AccesCanal !BorrarAccesCanal !akick !DropearCanal !InfoCanal !unban !SendpassCanal !Manager"
}
}

bind pub - !Nick pub_ns

proc pub_ns {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick, Ayuda para NiCK, para ver las opciones de ayuda teclea asi !IdentificarNick !CambiarClaveNick !PonerWebNick !EmailNick !noop !nomemo !enforce !DropearNick !recover !ghost !InfoNick"
}
}

bind pub - !Memo pub_ms

proc pub_ms {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick, Ayuda para MeMo, para ver las opciones de ayuda teclea asi !EnviarMemo !ListarMemo !leermemo !borrarmemo"
}
}

bind pub - !Varios pub_varios

proc pub_varios {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick, Tenemos las respuestas a tus preguntas más frecuentes para verlas teclea como estan aquí !ip - !ircop - !clon - !flood - !split - !op - !script - !lag - !PingPong - !EscribirColor - !Topic - !cortarpegar - !dns - !ignore - !log - !me - !msg - !cambiarnick - !notify - !query - !Play - !Sound - !Who - !list - !invite - !whois - !join - !darop - !quitarop - !modoscanal - !voice - !kick - !ban"
}
}

bind pub - !ayuda pub_ayuda

proc pub_ayuda {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :\002$nick Esta es toda la ayuda que puedo ofrecerte \002:"
puthelp "NOTICE $nick :!nickreg (para registrar un nick)"
puthelp "NOTICE $nick :!chanreg (para registrar un canal)"
puthelp "NOTICE $nick :!Chan (ayuda sobre los comandos del CHaN)"
puthelp "NOTICE $nick :!Nick (ayuda sobre los comandos del NiCK)"
puthelp "NOTICE $nick :!Memo (ayuda sobre los comandos del MeMo)"
puthelp "NOTICE $nick :!Varios (los comandos más usados)"
puthelp "NOTICE $nick :$nick debes usar todos los comandos con el signo ! por delante ejemplo !nickreg"
puthelp "NOTICE $nick :Recuerde que todos los comandos se usan sin colores.. Gracias por tu visita."
}
}

bind pub - !ip pub_ip

proc pub_ip {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre IP por el privado"
puthelp "PRIVMSG $nick :IP, Se puede definir como un número o un nombre que el servidor de Internet te da al conectarte. No siempre es el mismo."
}
}

bind pub - !ircop pub_ircop

proc pub_ircop {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre IRCop por el privado"
puthelp "PRIVMSG $nick :IRCop, Es un colaborador de un servidor, se encarga de los problemas de los usuarios que se conectan por el IRC o por el WebChat."
}
}

bind pub - !fserve pub_fserve

proc pub_fserve {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Fserve por el privado"
puthelp "PRIVMSG $nick :Fserve, Inicia una sesión con el servidor de archivos para otro usuario, utilizando un DCC Chat con el usuario especificado. Debemos insertar un directorio elaborado por nosotros. El usuario estará limitado a acceder sólo a los archivos y directorios que se encuentran en dicho directorio."
}
}

bind pub - !clon pub_clon

proc pub_clon {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar información sobre clon por el privado"
puthelp "PRIVMSG $nick :Clon, Un Clon es una persona con dos (o más) nick osea es un usuario conectado con dos mirc a dos servidores diferentes pero con una misma conexión. (en PuntoChat se permiten hasta tres(3) clones)."
}
}

bind pub - !flood pub_flood

proc pub_flood {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Flood por el privado"
puthelp "PRIVMSG $nick :Flood, Flood es enviar muchos textos ó comandos seguidos con motivos de llenar la pantalla o para desconectar a algun usuario."
}
}

bind pub - !split pub_split

proc pub_split {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Split por el privado"
puthelp "PRIVMSG $nick :Split, Es la separacion de un servidor de IRC de la red, separando unos usuarios de otros, pareciendo que se hubiera desconectado."
}
}

bind pub - !op pub_op

proc pub_op {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre OP por el privado"
puthelp "PRIVMSG $nick :OPerador, como cada casa, los canales de IRC deben tener alguien que se encargue de administrar y supervisar. Las personas encargadas de esto son llamadas operadores y para identificarlos tienen una @ junto a su nick. Los Ops regulan las reglas internas del canal, para dar OP tecleas: /mode #canal +o nick para agregarle a la lista de Operador de un canal tecleas /cs AOP #canal ADD Nick (ese comando resulta solo si eres Sop ó Fop)"
}
}

bind pub - !script pub_script

proc pub_script {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre script por el privado"
puthelp "PRIVMSG $nick :Script, Son añadidos para implementar el programa cliente de IRC (plugins), sirven para realizar acciones automatizadas, no son imprescindibles pero si muy recomendables para la defensa. Cada uno es especifico de su programa cliente (un script de mIRC solo funciona con ese programa), llamados también REMOTES."
}
}

bind pub - !lag pub_lag

proc pub_lag {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre LAG por el privado"
puthelp "PRIVMSG $nick :Lag, Es el retraso en enviar/recibir los datos por el irc. Para medir el lag se usa el /ping tu nick eso devuelve el tiempo que tardó en devolver la información el nick. Cuando es demasiado la única solución es cambiar de server."
}
}

bind pub - !pingpong pub_pingpong

proc pub_pingpong {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Ping?Pong! por el privado"
puthelp "PRIVMSG $nick :PING?PONG! Esto aparece en nuestra ventana del status, y es la comprobación que hace el servidor para ver si nuestra conexión esta activa si llevamos algún tiempo sin enviar ningún dato, en caso de que nuestro ordenador no conteste cortará la conexión."
}
}

bind pub - !escribircolor pub_escribircolor

proc pub_escribircolor {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Escribir a Colores por el privado"
puthelp "PRIVMSG $nick :Para escribir a Color Se apretan las teclas CTRL+K nº,nº Texto Ejemplo CTRL+K 0,12 Hola!! Los colores van del 0 al 15. El subrayado es con CTRL+U y letras negritas con CTRL+B."
}
}

bind pub - !topic pub_topic

proc pub_topic {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como cambiar el Topic de un canal por el privado"
puthelp "PRIVMSG $nick :Topic es el tema o frase o asunto de cada canal, Para cambiar el Topic Tienes que ser operador del canal para poder cambiar el topic, para hacerlo Teclea el comando /topic #TuCanal texto_deseado. Ejemplo /topic #Ayudas Un canal de ayuda opcional al novato sobre DALnet/IRC/mIRC"
}
}

bind pub - !cortarpegar pub_cortarpegar

proc pub_cortarpegar {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como Pegar y Cortar por el privado"
puthelp "PRIVMSG $nick :Cortar y pegar Pulsa el botón izquierdo del ratón y pasa el puntero por el texto que quieras copiar, luego lo pegas donde quieras con CTRL+V."
}
}

bind pub - !dns pub_dns

proc pub_dns {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando DNS por el privado"
puthelp "PRIVMSG $nick :DNS ejemplo /dns nick Averigua la IP del nick - /dns IP - Devuelve el Host de dicha IP"
}
}

bind pub - !ignore pub_ignore

proc pub_ignore {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando Ignore por el privado"
puthelp "PRIVMSG $nick :IGNORE usa /ignore nick, e Ignoras al nick indicado, de esa forma nada de lo que haga o diga lo veras, sera como si hubiera desaparecido. Ejemplo: /ignore Bots (todo lo que escriba o haga bots no te aparecera)"
}
}

bind pub - !log pub_log

proc pub_log {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando Log por el privado"
puthelp "PRIVMSG $nick :LOG Es una grabación que se hace del Chat/canal/status/Log on/off -Nos permite conectar o desconectar la grabación log en una ventana."
}
}

bind pub - !me pub_me

proc pub_me {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando ME por el privado"
puthelp "PRIVMSG $nick :ME use /Me mensaje - Comunica al canal actual o a la ventana de consulta lo que estamos haciendo. Ejemplo /me Escribiendo.."
}
}

bind pub - !msg pub_msg

proc pub_msg {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando MSGpor el privado"
puthelp "PRIVMSG $nick :MSG use /msg nick mensaje - Envía un mensaje privado a este usuario. Ejemplo /msg Carlos Hola!!."
}
}

bind pub - !cambiarnick pub_cambiarnick

proc pub_cambiarnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Cambiar el nick por el privado"
puthelp "PRIVMSG $nick : Para cambiar de NICK use /nick nuevo nick - Cambia nuestro apodo por otro que deseemos. Ejemplo /nick Pepe"
}
}

bind pub - !notify pub_notify

proc pub_notify {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :te acabo de enviar la información sobre Comando Notify por el privado"
puthelp "PRIVMSG $nick : NOTIFY use /notify [-alr] nick Añade o elimina de la lista de notificación un apodo especificado. Ejemplo /notify pepe (añade pepe), /notify -r pepe (borra a pepe), /Notify -l (te muestra la lista de notify)"
}
}

bind pub - !query pub_query

proc pub_query {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre el comando query por el privado"
puthelp "PRIVMSG $nick : Para enviar un QUERY use /Query nick [mensaje] abre una ventana de consulta a este usuario para enviarle un mensaje privado. Ejemplo /query pepe Hola"
}
}

bind pub - !play pub_play

proc pub_play {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre el Comando Play por el privado"
puthelp "PRIVMSG $nick :PLAY use /play nombrearchivo.txt - Muestra el contenido del txt en la ventana activa. Ejemplo /play alias.ini 3000 (que te mostrara el contenido de alias.ini con un retardo de 3 segundos."
}
}

bind pub - !sound pub_sound

proc pub_sound {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre el Comando Sound por el privado"
puthelp "PRIVMSG $nick : SOUND use /sound [nick/#canal] archivo mensaje - Envía una demanda de sonido a otro usuario. Ejemplo /sound #Ayudas angeles.mp3"
}
}

bind pub - !who pub_who

proc pub_who {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre el Comando Who por el privado"
puthelp "PRIVMSG $nick :WHO use /who nick /who *user* /who *host.es /who IP - Muestra información sobre alguien especifico. Ejemplo /who sedition (muestra información del usuario)"
}
}

bind pub - !list pub_list

proc pub_list {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando List por el privado"
puthelp "PRIVMSG $nick :LIST use /list - Sirve para pedir la lista de canales. Ejemplo /list *ayuda* (Se recomienda poner los asterisco para buscar los canales especificos)."
}
}

bind pub - !invite pub_invite

proc pub_invite {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando invite por el privado"
puthelp "PRIVMSG $nick : INVITE use /cs invite #ayuda pepe, Invitar un usuario a un canal. Suponiendo que el canal esta registrado y eres @ en el mismo."
}
}

bind pub - !whois pub_whois

proc pub_whois {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando Whois por el privado"
puthelp "PRIVMSG $nick :WHOIS use /whois nick, Da la dirección del nick, al servidor que está conectado, los canales donde está, y si su nick está identificado, tambien se usa para ver si está conectado al IRC., ejemplo /whois pepe"
}
}

bind pub - !join pub_join

proc pub_join {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Comando Join por el privado"
puthelp "PRIVMSG $nick :JOIN use /join #canal, Es para entrar en un canal. Ejemplo /join #Ayuda"
}
}

bind pub - !darop pub_darop

proc pub_darop {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como dar Op por el privado"
puthelp "PRIVMSG $nick :Dar OP Utilizar el siguiente comando /mode #canal +o nick Ejemplo /mode #Ayuda +o pepe (este comando es para dar Op temporal, si quieres agregarlo a tu lista teclea !accescanal)"
}
}

bind pub - !quitarop pub_quitarop

proc pub_quitarop {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como quitar Op por el privado"
puthelp "PRIVMSG $nick :Como quitar OP Utilizar el siguiente comando /mode #canal -o nick Ejemplo /mode #Ayuda -o pepe (Esto solo quita el OP temporal, si quieres borrarlo de lista teclea !borraraccescanal)"
}
}

bind pub - !voice pub_voice

proc pub_voice {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick acabo de enviar la información sobre Como dar voice por el privado"
puthelp "PRIVMSG $nick :Como dar voice Utilizar el siguiente comando /mode #canal +v nick Para quitar Utilizar el siguiente comando /mode #canal -v nick Ejemplo /mode #Ayuda +v pepe"
}
}

bind pub - !kick pub_kick

proc pub_kick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre como dar kick por el privado"
puthelp "PRIVMSG $nick :Para expulsar un usuario/a utiliza el siguiente comando /kick #canal nick Ejemplo /kick #Ayuda pepe Prueba!"
}
}

bind pub - !ban pub_ban

proc pub_ban {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como dar un ban por el privado"
puthelp "PRIVMSG $nick :Como dar ban utilizar el siguiente comando /Ban #canal nick. Ejemplo /ban #Ayuda pepe"
}
}

bind pub - !modoscanal pub_modoscanal

proc pub_modoscanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner modos a un Canal por el privado"
puthelp "PRIVMSG $nick :Como poner modos tecleas el siguiente comando /mode #canal <+/-[iklmnpstRM]>. Ejemplo: /mode #Ayuda +nt-s (Estos son modos momentaneos, solo el founder puede cambiar o poner modes fijos para ver opciones teclea !mlock)"
}
}

bind pub - !identificarnick pub_identificarnick

proc pub_identificarnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como identificarce con su nick por el privado"
puthelp "PRIVMSG $nick :Para Identificarte con tu nick tecleas el siguiente comando /login Nick contraseña (no poner este comando en ningun canal por seguridad hacerlo en el status) Ejemplo /login pepe mipass123"
}
}

bind pub - !cambiarclavenick pub_cambiarclavenick

proc pub_cambiarclavenick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como cambiar el password de tu nick por el privado"
puthelp "PRIVMSG $nick : Para cambiar tu contraseña en esta red debes ingresa via web a https://www.puntochat.net/registro/usuarios/, ingresar tus datos actuales y por ultimo cambiar contraseña desde tu panel de usuario. Por ultimo pon dentro del IRC -> /login nick nueva-contraseña"
}
}

bind pub - !webnick pub_webnick

proc pub_webnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner tu web al info de tú nick"
puthelp "PRIVMSG $nick :Para poner tu web en el info de tu nick tecleas /ns SET URL www.ejemplo.com. Ejemplo; /ns set URL www.puntochat.net"
}
}

bind pub - !emailnick pub_emailnick

proc pub_emailnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick acabo de enviar la información sobre Como poner cambiar de email en tu nick por el privado"
puthelp "PRIVMSG $nick :El cambio de e-mail no esta habilidado en nuestra RED :("
}
}

bind pub - !noop pub_noop

proc pub_noop {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como activa y desactiva el NoOp por el privado"
puthelp "PRIVMSG $nick :Para Activar/Desactivar autOOP en tu nick teclea /ns SET AUTOOP  ON/OFF. Ejemplo: /ns set autoop on (con la opcion off activada no resibiras @ en ningun canal)"
}
}

bind pub - !sendpassnick pub_sendpassnick

proc pub_sendpassnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como recuperar tú clave por tu email por el privado"
puthelp "PRIVMSG $nick :Para recuperar tu clave ingresa a https://www.puntochat.net/registro/usuarios/forgotpass - Ingresa tu Usuario, correo y podras cambiar de contraseña."
}
}

bind pub - !memo pub_nomemo

proc pub_nomemo {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como ativar y desactivar el NoMemo por el privado"
puthelp "PRIVMSG $nick :Para ver las opciones de MeMo - tipea /ms HELP"
}
}

bind pub - !release pub_release

proc pub_release {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviarte información acerca de como hacer un recover por el privado"
puthelp "PRIVMSG $nick :No puedes ponerte tú nick?, entonces teclea /ns recover nick contraseña. Ejemplo: /ns recover pepe mipass123 (recupera tu nick de NiCK)"
}
}

bind pub - !securekill pub_enforce

proc pub_enforce {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como activar y desactivar Enforce por el privado"
puthelp "PRIVMSG $nick :Para Activar/Desactivar SecureNick teclea /ns set kill on. (activa el enforce e impide que otros lo usen sin su clave)"
}
}

bind pub - !dropearnick pub_dropearnick

proc pub_dropearnick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como borrar el registro de tu nick por el privado"
puthelp "PRIVMSG $nick :Para Dropear tu nick teclea /Nickserv DROP nick - despues te enviaran un email con un AUTH(codigo) para comprobar que quieras borrarlo, copias y pegas el codigo y queda sin registro tu nick"
}
}

bind pub - !secureon pub_recover

proc pub_recover {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como activar la proteccion (Secure) tú nick por el privado"
puthelp "PRIVMSG $nick :Secure recupera tu nick tecleas asi /ns set secure on. "
}
}

bind pub - >!ghost pub_ghost

proc pub_ghost {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como matar (desconectar) un Ghost por el privado"
puthelp "PRIVMSG $nick :(nick fantasma) Matar un Ghost tecleas /Nickserv GHOST nick contraseña - Ejemplio /nickserv ghost Sedition 2748656"
}
}

bind pub - !infonick pub_infonick

proc pub_infonick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como hacer para ver el info de un nick por el privado"
puthelp "PRIVMSG $nick :Para ver la Información de un Nick tecleas /ns INFO nick. Ejemplo /ns info pepe (te saldra la información de registro y opciones de su nick)"
}
}

bind pub - !identificarcanal pub_identificarcanal

proc pub_identificarcanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre identificarte como founder del canal por el privado"
puthelp "PRIVMSG $nick :Para identificarce como founder de un canal Poner el siguiente comando /cs IDENTIFY #canal contraseña - ejemplo /chanserv identify #Ayudas 3749546"
}
}

bind pub - !cambiarfounder pub_cambiarfounder

proc pub_cambiarfounder {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como cambiar el founder del canal por el privado"
puthelp "PRIVMSG $nick : En PuntoChat los canales registrados esta asociados a tu <nick>, una vez identificado con NiCK tienes automaticamente el control de tu canal. "
}
}

bind pub - !descripcioncanal pub_descripcioncanal

proc pub_descripcioncanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como cambiar de descripción a tu canal por el privado"
puthelp "PRIVMSG $nick :Para cambiar de descripcion a tu canal Poner el siguiente comando /cs SET DESC #canal  descripción. Ejemplo: /cs SET DESC #ayuda Canal de ayuda IRC."
}
}

bind pub - !urlcanal pub_urlcanal

proc pub_urlcanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner URL a tu canal por el privado"
puthelp "PRIVMSG $nick :Para poner URL en el info de tu canal Poner el siguiente comando /cs SET URL #canal https://www.ejemplo.com. Ejemplo: /cs SET URL #amistad https://www.puntochat.net/chat/amistad/"
}
}

bind pub - !keeptopic pub_keeptopic

proc pub_keeptopic {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre activar o desactivar el KEEPTOPIC por el privado"
puthelp "PRIVMSG $nick :Para activar el KEEPTOPIC Poner el siguiente comando /cs SET KEEPTOPIC #canal (ON/OFF) - Ejemplo: /cs SET KEEPTOPIC #ayuda oN  (esto permite que el topic no se pierda del canal)"
}
}

bind pub - >!topiclock pub_topiclock

proc pub_topiclock {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre como activar y desactivar TOPICLOCK por el privado"
puthelp "PRIVMSG $nick :Para que solo el Fop o Sop puedan cambiar el topic Poner el siguiente comando /Chanserv SET #canal TOPICLOCK (Sop/Fop/OFF) ejemplo /chanserv set #Ayudas topiclock Sop (Solo los Sops y el Fop podran cambiar el topic)"
}
}

bind pub - !mlock pub_mlock

proc pub_mlock {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner modos permanentes a un canal por el privado"
puthelp "PRIVMSG $nick :Para poner modos permanentes a un canal Poner el siguiente comando /cs mode lock #canal +/-(i,k,l,m,n,p,s,t,R,M) Ejemplo: /cs mode lock #ayuda +CGnt (Tienes que hacerlo con el nick de founder, o identificalo con el canal)"
}
}

bind pub - !canalprivado pub_canalprivado

proc pub_canalprivado {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner tu canal pivado(PRIVATE) por el privado"
puthelp "PRIVMSG $nick :Para que tu canal sea Privado Poner el siguiente comando /cs SET private #canal. Ejemplo: /cs SET private #ayuda (Solo los que tenga accesso tu canal podran permanecer)"
}
}

bind pub - !canalrestringido pub_canalrestringido

proc pub_canalrestringido {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner restringido tu canal por el privado"
puthelp "PRIVMSG $nick :Para que tu canal sea Restringido Poner el siguiente comando /cs SET RESTRICTED #canal (ON/OFF). Ejemplo: /cs SET RESTRICTED #ayuda (ON (Solo podran entrar los que sean operadores del canal)"
}
}

bind pub - !accescanal pub_accescanal

proc pub_accescanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Dar Aop/Sop en canal por el privado"
puthelp "PRIVMSG $nick :Para agregar un Aop o Sop Poner el siguiente comando /cs sop/aop #canal add nick. Ejemplo: /cs sop #ayuda add pepe (Agrega a la lista de superop <admin>). Ejemplo: /cs aop #ayuda add pepe2 (agrega a la lista de operadores de #ayuda)"
}
}

bind pub - !borraraccescanal pub_borraraccescanal

proc pub_borraraccescanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como borrar el acceso de un nick a tu canal de Aop o Sop por el privado"
puthelp "PRIVMSG $nick :Para borrar a un Aop o Sop de la lista de tu canal Poner el siguiente comando /cs sop/aop #canal del nick. Ejemplo: /cs aop #canal del pepe (Borra de la lista de aops de ayudas a pepe)"
}
}

bind pub - >!sendpasscanal pub_sendpasscanal

proc pub_sendpasscanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la como se hace un SENDPASS para recuperar la clave de tu canal por el privado"
puthelp "PRIVMSG $nick :$nick para recuperar la clave de tú canal teclea /Chanserv sendpass #TúCanal Tú@email.com - Ejemplo /chanserv sendpass #Ayudas sedition@canal-ayudas.tk (La clave del canal será enviada a dicho correo)"
}
}

bind pub - >!manager pub_manager

proc pub_manager {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar el info de como se hace un MANAGER en tu canal por el privado Recuerda que solo podes agregar 5 nicks"
puthelp "PRIVMSG $nick :$nick que es un MANAGER es un colaborador del canal que tiene casi las mismas ventajas que un FUNDER el puede cambiar casi todo (aop-sop-akick-modes del canal) a ecepción de la clave del canal y sucesor, para usar este comando se usa de la siguiente forma /Chanserv manager #TúCanal add nick"
puthelp "PRIVMSG $nick :$nick Ejemplo /chanserv manager #Ayudas add sedition luego para remover un manager es asi /chanserv manager #Ayudas del sedition ver la lista de manager /chanserv manager #Ayudas list ten en cuenta que solo puedes agregar 5 nick (manager)"
}
}

bind pub - !akick pub_akick

proc pub_akick {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como poner akick a un nick por el privado"
puthelp "PRIVMSG $nick :Para agregar a la lista de akick de un canal a un nick Poner el siguiente comando /cs akick #canal add nick!*@*. "
}
}

bind pub - !dropearcanal pub_dropearcanal

proc pub_dropearcanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como borrar el registro de un canal por el privado"
puthelp "PRIVMSG $nick :Para borrar el registro de un canal Poner el siguiente comando /cs DROP #canal."
}
}

bind pub - !infocanal pub_infocanal

proc pub_infocanal {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como ver el info de un canal por el privado"
puthelp "PRIVMSG $nick :Para ver el info de un canal Poner el siguiente comando /cs INFO #canal."
}
}

bind pub - >!unban pub_unban

proc pub_unban {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información UnBanpor el privado"
puthelp "PRIVMSG $nick :UnBan tienes que ser operador del canal y Poner el siguiente comando /Chanserv UNBAN #canal Nick - Ejemplo /chanserv unban #ayudas Sedition (esto me quita el ban del canal en el cual soy Aop)"
}
}

bind pub - !enviarmemo pub_enviarmemo

proc pub_enviarmemo {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Enviar un memo por el privado"
puthelp "PRIVMSG $nick :Para Mandar MeMo tecleas el siguiente comando /ms SEND nick <mensaje>. Ejemplo: /ms send pepe te amo."
}
}

bind pub - !listarmemo pub_listarmemo

proc pub_listarmemo {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Ver tu lista de memos por el privado"
puthelp "PRIVMSG $nick :Para ver la lista de tus memos teclea el siguiente comando /ms LIST"
}
}

bind pub - !leermemo pub_leermemo

proc pub_leermemo {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Leer tus memos por el privado"
puthelp "PRIVMSG $nick :Para leer tus memos tecleas el siguiente comando /ms READ (Nº). Ejemplo: /ms read 1"
}
}

bind pub - !borrarmemo pub_borrarmemo

proc pub_borrarmemo {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Borrar tus memos por el privado"
puthelp "PRIVMSG $nick :Para borrar tus memos tecleas el siguiente comando /ms del (numero de memo). Ejemplo: /ms del 4 - (se eliminaran los que seleccionaste)"
}
}

bind pub - !chanreg pub_chanreg

proc pub_chanreg {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como registrar un Canal por el privado"
puthelp "PRIVMSG $nick :Como Registrar un Canal: 1. Para registrar un canal debes tener un nick registrado, entonces entras al canal una ves teniendo (@) puedes teclear el comando /cs register #canal descripción. Ejemplo: /cs register #Ayuda Canal de Ayuda"
}
}

bind pub - !nickreg pub_nickreg

proc pub_nickreg {nick user hand chan arg} {
global ayudascomando
if {(([lsearch -exact [string tolower $ayudascomando] [string tolower $chan]] != -1) || ($ayudascomando == ""))} {
puthelp "NOTICE $nick :$nick te acabo de enviar la información sobre Como registrar un Nick por el privado"
puthelp "PRIVMSG $nick :Como Registrar un Nick: 1. Primero debes buscar un nick que no este registrado y ahora una ves que este con el nick No Registrado tecleas para su registro dirigete a la web: https://www.puntochat.net/registro/usuarios/register.php"
puthelp "PRIVMSG $nick :2. Despues PuntoChat te enviara un email con un LINK que debes darle <click>, tienes 1 hora para hacerlo o se borrara tu nick."
puthelp "PRIVMSG $nick :3. Si ingresas por webchat, dentro del mismo tienes el boton <Iniciar sesión>, alli ingresas tu nick y contraseña."
puthelp "PRIVMSG $nick :4. Si ingresas por un cliente IRC <mirc o androIRC>, ingresa el siguiente comando: /login nick contraseña. Ejemplo: /LOGIN pepe mipass123."
puthelp "PRIVMSG $nick :Tú nick ya esta registrado, Felicitaciones!"
}
}

putlog "TCL ayuda para ANOPE editado por Seth irc.puntochat.net - 4Cargado"