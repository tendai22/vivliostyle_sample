#! /bin/sh
cat "$@" |
awk 'BEGIN {
        lp = length("ref=\"")
        count = 0
    }
/class="refcall"/ || /class="refer"/{
    s = $0
    split(s, lin, "ref=\"")
    i = 0
    lin0 = ""
    for (i in lin) {
        ss = lin[i]
        #print "X " i " " ss
        if (i == 1) {
            lin0 = ss
            continue
        }
        lin0 = lin0 "ref=\""
        l = index(ss, "\"")
        k = "X" substr(ss, 0, l - 1)
        v = ++n
        #print "call k = " k ", v = " v
        pat[k] = v
        lin0 = lin0 v substr(ss, l)
    }
    print lin0
    next
}
/class="refbody"/{
    s = $0
    split(s, lin, "ref=\"")
    i = 0
    lin0 = ""
    for (i in lin) {
        ss = lin[i]
        #print "X " i " " ss
        if (i == 1) {
            lin0 = ss
            continue
        }
        lin0 = lin0 "ref=\""
        l = index(ss, "\"")
        k = "X" substr(ss, 1, l - 1)
        v = pat[k]
        #print "body k = " k ", v = " v
        lin0 = lin0 v substr(ss, l)
    }
    print lin0
    next
}
{ print }
'

