#! /bin/sh
for f
do  d=`basename -s .md $f`_x.md
    cat "$f" |
    sed '
# figure
    /^!\[/{
        s/^!\[\([^]]*\)\]\[\([^]][^]]*\)\](\([^)][^)]*\)){\([^}][^}]*\)}/<figure style="\4">\
<img width=\2, src="\3">\
<figcaption>\1<\/figcaption>\
<\/figure>/
        s/^!\[\([^]]*\)\]\[\([^]][^]]*\)\](\([^)][^)]*\))/<figure>\
<img width=\2, src="\3">\
<figcaption>\1<\/figcaption>\
<\/figure>/
    }
# word/desc
    /^<glossary>/,/^<\/glossary>/{
        /^<glossary>/{
            s/.*/<div class="glossary">/
            x
            s/.*//
            x
            b
        }
        /^<\/glossary>/{
            x
            p
            x
            s/.*/<\/div>/
            b
        }
        /^||/!{
            /^ *$/b
            #s/^/<div>/
            #s/$/<\/div>/
            b
        }
        /^||/{
            x
            p
            x
            s/^||\([^|][^|]*\)|| *-- \(.*\)$/<div class="x2-grid">\
  <div class="x-word"><code>\1<\/code><\/div>\
  <div class="x-desc">\
        \2/
            s/^||\([^|][^|]*\)|| *\([^ ].*\)$/<div class="x3-grid">\
  <div class="x-word"><code>\1<\/code><\/div>\
  <div class="x-stack">\2<\/div>\
  <div class="x-desc">/
            s/^||\([^|][^|]*\)|| *$/<div class="x2-grid">\
  <div class="x-word"><code>\1<\/code><\/div> \
  <div class="x-desc">/
            x
            s/^$/  <\/div>\
<\/div>/
            x
        }
    }
# return-underline in pre
    s/{RETURN\([^}][^}]*\)}/<span class="invert">RETURN<\/span><span class="underline">\1<\/span>/
    s/{RETURN}/<span class="invert">RETURN<\/span>/
    s/{{\([^}][^}]*\)}}/<span class="underline">\1<\/span>/g
# handy-hint
    /^<handy-hint>/{
        s/<handy-hint>[^{]*{/<div class="handy-hint">{/
        s/{\([^}][^}]*\)}/\
<h4 style="text-align: center;">\1<\/h4>}/
        s/}.*$//
    }
    /^<\/handy-hint>/{
        s/<\/handy-hint>/<\/div>/
    }
    ' |
    sed '/^<review-of-terms*>/,/^<\/review-of-terms*>/{
        /^<review-of-terms*>/{
            s/.*/<div class="review-of-terms">/
            x
            s/.*//
            x
            b
        }
        /^<\/review-of-terms*>/{
            x
            p
            x
            s/.*/<\/div>/
            b
        }
        /^||/!{
            /^ *$/b
            s/^/<div>/
            s/$/<\/div>/
            b
        }
        /^||/{
            x
            p
            x
            s/^||\([^|][^|]*\)||\(.*\)$/<div class="x2-grid">\
  <span class="x-word">\1<\/span>\
  <span class="x-desc">\
        \2/
            x
            s/^$/  <\/span>\
<\/div>/
            x
        }
    }
    ' |
    sed 's/<figcaption> *<\/figcaption>//
         s/<div><\/div>//'
done

