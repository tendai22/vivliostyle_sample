#! /bin/sh
cat "$@" |
sed -n '/^$/{
:loop
    n
    /^    /{
        H
        b loop
    }
    # got it
    x
    /./{
        s/\n//
        s/^/\
<pre class="keytype">/
        s/$/\
<\/pre>/
        p
        s/.*//
    }
    x
    s/^/\
/
}
p
'
