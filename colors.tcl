#### Comienzo del Strip #
catch {unbind raw - PRIVMSG *raw:irc:msg}
catch {unbind raw - PRIVMSG *raw:PRIVMSG}
bind raw - PRIVMSG striprivmsg
proc striprivmsg {f k a} {
set a [stripcodes abcgru $a]
*raw:irc:msg $f $k $a
*raw:PRIVMSG $f $k $a
}
# Final del Strip #