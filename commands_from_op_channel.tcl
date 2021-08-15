#canal donde funcionará los comandos
set Channel "#canal_ops"

# seccion o ruta donde leera el archivo del contador
set swearkicks "swearkicks.dat"

#bind del contador
bind kick - * swear:kick:counter

bind pub ABCn|ABCn !kb proc_bakick
proc proc_bakick { nick uhost hand chan text } {
global botnick swearkicks Channel
set arg1 [lindex $text 2]
if {[onchan $text]} {
if {$text == $botnick} { return 0 }
if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
set ban [lindex $text 0]
set mask *!*@[lindex [split [getchanhost $ban] @] 1]
putquick "MODE #gay +b $mask"
putquick "kick #gay $text :1\[Manual\] Incumplimiento de las Normas del Canal. \[$totalkicks\]"
putquick "PRIVMSG #gay_ops : 1(4KICKBAN1) 4NiCK1 $text 14- 4IP1 $mask"
} else { putquick "PRIVMSG #gay_ops : 4ERROR1 Syntaxis Incorrecta: !kb <nick>" }
}

bind pub ABCn|ABCn !kbmenor proc_bakbmenor
proc proc_bakbmenor { nick uhost hand chan text } {
global botnick swearkicks Channel
set arg1 [lindex $text 2]
if {[onchan $text]} {
if {$text == $botnick} { return 0 }
if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
set ban [lindex $text 0]
set mask *!*@[lindex [split [getchanhost $ban] @] 1]
putquick "MODE #gay +b $mask"
putquick "kick #gay $text :1\[4MENORES\] No se Permite la Busqueda ni Entrada de Menores de Edad \[$totalkicks\]"
putquick "PRIVMSG #gay_ops : 1(4T.Menores1) 4NiCK1 $text 14- 4IP1 $mask"
} else { putquick "PRIVMSG #gay_ops : 4ERROR1 Syntaxis Incorrecta: !kbmenor <nick>" }
}

bind pub ABCn|ABCn !kbdrogas proc_bakbdrogas
proc proc_bakbdrogas { nick uhost hand chan text } {
global botnick swearkicks Channel
set arg1 [lindex $text 2]
if {[onchan $text]} {
if {$text == $botnick} { return 0 }
if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
set ban [lindex $text 0]
set mask *!*@[lindex [split [getchanhost $ban] @] 1]
putquick "MODE #gay +b $mask"
putquick "kick #gay $text :1\[4ILEGAL\] No se Permiten Sustancias Ilegales en el Canal. \[$totalkicks\]"
putquick "PRIVMSG #gay_ops : 1(4T.Drogas1) 4NiCK1 $text 14- 4IP1 $mask"
} else { putquick "PRIVMSG #gay_ops : 4ERROR1 Syntaxis Incorrecta: !kbdrogas <nick>" }
}

bind pub ABCn|ABCn !kbact proc_bakbact
proc proc_bakbact { nick uhost hand chan text } {
global botnick swearkicks Channel
set arg1 [lindex $text 2]
if {[onchan $text]} {
if {$text == $botnick} { return 0 }
if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
set ban [lindex $text 0]
set mask *!*@[lindex [split [getchanhost $ban] @] 1]
putquick "MODE #gay +b $mask"
putquick "kick #gay $text :1\[4No Permitido\] Actividades No Permitidas en el canal \[$totalkicks\]"
putquick "PRIVMSG #gay_ops : 1(4No Permitido1) 4NiCK1 $text 14- 4IP1 $mask"
} else { putquick "PRIVMSG #gay_ops : 4ERROR1 Syntaxis Incorrecta: !kbact <nick>" }
}



# Thanks to NeOmAtRiX for this kick counter ###
proc swear:kick:counter {nick uhost hand chan target reason} {
global botnick swearkicks
if {([string equal $target $botnick])} { return 0 }
if {([string equal $nick $botnick])} {
if {![file exists $swearkicks]} {
putlog "Kick Contador: El \002kick contador archivo\002 no existe. Creando archivo \002$swearkicks\002."
set file [open $swearkicks "w"]
puts $file 1; close $file }
set file [open $swearkicks "r"]
set currentkicks [gets $file]; close $file
set file [open $swearkicks "w"]
puts $file [expr $currentkicks + 1]; close $file
}
}