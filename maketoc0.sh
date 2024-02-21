cat <<"EOF"
<nav id="toc" role="doc-toc">

# Contents

EOF
for f
do
    html=`echo "$f" |sed 's/\.md$/.html/'`
    cat "$f" |
    sed -n '
    /^#/!b
    s/<span .*<\/span>//
    s/^^[XYZ]//
    s/ *$//
    /{id=/!b
    s/^\(##*\) \([^{}][^{}]*\){id="\([^{}]*\)"}$/\1 1. [\2]('"$html"'#\3)/
    p
    ' |
    sed '
    s/^##### /         /
    s/^#### /       /
    s/^### /     /
    s/^## /   /
    s/^# / /
    '
done
cat <<"EOF"

</nav>
EOF
