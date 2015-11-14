KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
FILE_EXTENSIONS="swift|h|m|mm|c|cpp"
find -E "${SRCROOT}" -ipath "${SRCROOT}/Carthage" -o -ipath "${SRCROOT}/pods" -prune -o \( -regex ".*\.($FILE_EXTENSIONS)$" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"
