#! /bin/sh
cat "$@" |
sed '/^<itemize>/,/^<\/itemize>/{
    /^<itemize>/{
        s/.*/\
<ol class="itemize">/
    }
    /^<\/itemize>/{
        s/.*/<\/ol>/
    }
    s/`\([^`][^`]*\)`/<code>\1<\/code>/g
    s/\*\*\([^*][^*]*\)\*\*/<span style="font-weight: 700;">\1<\/span>/g
    s/\*\([^*][^*]*\)\*/<em>\1<\/em>/g
    /^ *[0-9][0-9]*[.)] /{
        s/^ *[0-9][0-9]*[.)]  */<li>/
        s/$/\
    <\/li>/
    }
}
'